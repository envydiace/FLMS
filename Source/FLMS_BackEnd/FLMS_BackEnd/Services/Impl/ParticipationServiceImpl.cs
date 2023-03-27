using DocumentFormat.OpenXml.Spreadsheet;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Repositories.Impl;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class ParticipationServiceImpl : BaseService, ParticipationService
    {
        private readonly ParticipationRepository participationRepository;
        private readonly ClubCloneRepository clubCloneRepository;
        private readonly ParticipateNodeRepository participateNodeRepository;
        private readonly LeagueRepository leagueRepository;
        private readonly SquadPositionRepository squadPositionRepository;

        public ParticipationServiceImpl(
            ParticipationRepository participationRepository,
            ClubCloneRepository clubCloneRepository,
            ParticipateNodeRepository participateNodeRepository,
            LeagueRepository leagueRepository,
            SquadPositionRepository squadPositionRepository)
        {
            this.participationRepository = participationRepository;
            this.clubCloneRepository = clubCloneRepository;
            this.participateNodeRepository = participateNodeRepository;
            this.leagueRepository = leagueRepository;
            this.squadPositionRepository = squadPositionRepository;
        }

        public async Task<ConfirmRegistFeeResponse> ConfirmResgistFee(ConfirmRegistFeeRequest request, int userId)
        {
            var participation = await participationRepository.FindByCondition(p =>
                    p.ClubId == request.ClubId &&
                    p.LeagueId == request.LeagueId)
                .Include(p => p.Club).ThenInclude(c => c.User)
                .Include(p => p.League).ThenInclude(l => l.User)
                .Include(p => p.League).ThenInclude(l => l.ClubClones)
                .FirstOrDefaultAsync();
            if (participation == null)
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-01"
                };
            }
            if (participation.Confirmed)
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-04"
                };
            }
            participation.Confirmed = true;
            participation.Evidence = request.Evidence;
            switch (MethodUtils.GetLeagueTypeByName(participation.League.LeagueType))
            {
                case Constants.LeagueType.LEAGUE:
                    var clubClone = participation.League.ClubClones.Where(c => c.ClubId == null).FirstOrDefault();
                    if (clubClone != null)
                    {
                        clubClone.ClubId = request.ClubId;
                    }
                    else
                    {
                        return new ConfirmRegistFeeResponse
                        {
                            Success = false,
                            MessageCode = "ER-PA-03"
                        };
                    }
                    break;
            }

            var result = await participationRepository.UpdateAsync(participation);
            if (result != null)
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = true,
                    MessageCode = "MS-PA-01",
                    mailData = new MailDTO
                    {
                        LeagueManagerName = result.League.User.FullName,
                        ClubManagerName = result.Club.User.FullName,
                        Email = result.Club.User.Email,
                        LeagueName = result.League.LeagueName,
                        ClubName = result.Club.ClubName,
                        ReceiverRole = result.Club.User.Role
                    },
                };
            }
            else
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-02"
                };
            }
        }

        public async Task<ParticipationByLeagueResponse> GetParticipationByLeague(ParticipationByLeagueRequest request)
        {
            var participations = await participationRepository.FindByCondition(p =>
                p.LeagueId == request.LeagueId &&
                (request.SearchName == null || p.Club.ClubName.ToLower().Contains(request.SearchName.ToLower())))
                .Include(p => p.Club)
                .ToListAsync();
            return new ParticipationByLeagueResponse
            {
                Success = true,
                Clubs = mapper.Map<List<ParticipationClubDTO>>(participations)
            };
        }
        public async Task<RemoveClubResponse> RemoveJoinedTeam(RemoveClubRequest request, int UserId)
        {
            var participation = await participationRepository.FindByCondition(p =>
                p.LeagueId == request.leagueId && p.ClubId == request.clubId)
                .Include(p => p.League).ThenInclude(l => l.User)
                .Include(p => p.Club).ThenInclude(c => c.User)
                .FirstOrDefaultAsync();

            if (participation == null)
            {
                return new RemoveClubResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-01"
                };
            }
            if (participation.League.UserId != UserId)
            {
                return new RemoveClubResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (participation.League.IsFinished)
            {
                return new RemoveClubResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-07"
                };
            }
            if (participation.Confirmed)
            {
                return new RemoveClubResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-04"
                };
            }
            Participation result = await participationRepository.DeleteAsync(participation);
            if (result != null)
            {
                return new RemoveClubResponse
                {
                    Success = true,
                    MessageCode = "MS-PA-02",
                    MessageMailCode = "MS-MAIL-09",
                    mailData = new MailDTO
                    {
                        LeagueManagerName = result.League.User.FullName,
                        ClubManagerName = result.Club.User.FullName,
                        Email = result.Club.User.Email,
                        LeagueName = result.League.LeagueName,
                        ClubName = result.Club.ClubName,
                        ReceiverRole = result.Club.User.Role
                    },
                };
            }
            return new RemoveClubResponse
            {
                Success = false,
                MessageCode = "ER-PA-05"
            };
        }
        public async Task<List<ClubBasicInfoDTO>> ListUnpositionClub(int leagueId, int userId)
        {
            List<ClubBasicInfoDTO> result = new List<ClubBasicInfoDTO>();
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId)
                        .Include(l => l.ClubClones)
                        .Include(l => l.Participations).ThenInclude(p => p.Club)
                        .FirstOrDefaultAsync();
            if (league != null && league.UserId == userId)
            {
                var clubs = league.Participations.Where(p =>
                        p.Confirmed &&
                        !league.ClubClones.Any(cl => cl.ClubId == p.ClubId))
                    .Select(p => p.Club)
                    .ToList();
                if (clubs != null && clubs.Count > 0)
                {
                    result = mapper.Map<List<ClubBasicInfoDTO>>(clubs);
                }
            }
            return result;
        }

        public async Task<AddClubPositionResponse> AddClubPosition(int clubCloneId, int clubId, int userId)
        {
            var clubClone = await clubCloneRepository.FindByCondition(cl => cl.ClubCloneId == clubCloneId)
                            .Include(cl => cl.League).ThenInclude(l => l.Matches)
                            .FirstOrDefaultAsync();
            if (clubClone == null)
            {
                return new AddClubPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-06"
                };
            }
            if (clubClone.League.UserId != userId)
            {
                return new AddClubPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            var checkSquadPosition = await squadPositionRepository.FindByCondition(sp =>
                        sp.Squad.Match.LeagueId == clubClone.LeagueId &&
                        sp.PlayerId != null
                        ).AnyAsync();
            if (checkSquadPosition)
            {
                return new AddClubPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-10"
                };
            }
            if (clubClone.ClubId != null || clubClone.ClubId == 0)
            {
                return new AddClubPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-07"
                };
            }
            var unpositionClubs = await this.ListUnpositionClub(clubClone.LeagueId, userId);
            if (!unpositionClubs.Any(c => c.ClubId == clubId))
            {
                return new AddClubPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-09"
                };
            }
            clubClone.ClubId = clubId;
            var result = await clubCloneRepository.UpdateAsync(clubClone);
            if (result != null)
            {
                return new AddClubPositionResponse
                {
                    Success = true,
                    MessageCode = "MS-PA-03"
                };
            }
            else
            {
                return new AddClubPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-08"
                };
            }
        }
        public async Task<List<JoinedLeagueDTO>> GetListJoinedLeague(int userId)
        {
            var leagues = await participationRepository.FindByCondition(p =>
                    p.Club.UserId == userId &&
                    p.Confirmed)
                .Include(p => p.League)
                .Select(p => p.League)
                .ToListAsync();
            return mapper.Map<List<JoinedLeagueDTO>>(leagues != null ? leagues : new List<League>());
        }

        public async Task<ParticipateTreeResponse> GetLeagueParticipateTree(int leagueId)
        {

            var list = await participateNodeRepository.FindByCondition(n => n.LeagueId == leagueId)
                    .Include(n => n.ClubClone).ThenInclude(c => c.Club)
                    .OrderByDescending(n => n.Deep).ThenByDescending(n => n.ParentId).ThenBy(n => n.ParticipateId)
                    .ToListAsync();
            if (list != null)
            {
                var listAvailNode = new List<ParticipateTreeNodeDTO>();
                List<ClubBasicInfoDTO> result = new List<ClubBasicInfoDTO>();
                var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId)
                            .Include(l => l.ClubClones)
                            .Include(l => l.Participations).ThenInclude(p => p.Club)
                            .FirstOrDefaultAsync();
                if (league != null)
                {
                    var clubs = league.Participations.Where(p =>
                            p.Confirmed &&
                            !league.ClubClones.Any(cl => cl.ClubId == p.ClubId))
                        .Select(p => p.Club)
                        .ToList();
                    if (clubs != null && clubs.Count > 0)
                    {
                        result = mapper.Map<List<ClubBasicInfoDTO>>(clubs);
                    }
                    result.ForEach(c =>
                    {
                        listAvailNode.Add(new ParticipateTreeNodeDTO
                        {
                            ClubBasicInfo = c
                        });
                    });
                }
                var listNode = mapper.Map<List<ParticipateTreeNodeDTO>>(list);
                List<MatchNodeDTO> listMatchNode = new List<MatchNodeDTO>();
                var groupNodes = from node in listNode
                                 group node by node.ParentId;
                foreach (var node in groupNodes)
                {
                    List<ParticipationNodeTreeDTO> Participation = new List<ParticipationNodeTreeDTO>();
                    int deep = 0;
                    foreach (var n in node.ToList())
                    {
                        Participation.Add(mapper.Map<ParticipationNodeTreeDTO>(n));
                        deep = n.Deep;
                    }
                    var matchNode = new MatchNodeDTO
                    {
                        ParentId = node.Key,
                        Deep = deep,
                        Participation = Participation
                    };
                    listMatchNode.Add(matchNode);
                }
                return new ParticipateTreeResponse
                {
                    LeagueId = leagueId,
                    ListNode = listMatchNode,
                    ListAvailNode = listAvailNode,
                    NumberOfNode = list.Count,
                    TreeHeight = list.FirstOrDefault().Deep,
                    CanEdit = !list.Any(n => (n.ClubCloneId != null && n.ClubCloneId != 0) &&
                            (n.LeftId != null && n.LeftId != 0))
                };
            }
            return new ParticipateTreeResponse();
        }

        public async Task<LeagueSettingResponse> SaveLeagueTree(SaveLeagueTreeRequest request, int userId)
        {
            //TODO: authorize
            var league = await leagueRepository.FindByCondition(n => n.LeagueId == request.LeagueId)
                    .Include(l => l.ParticipateNodes).ThenInclude(p => p.ClubClone)
                    .FirstOrDefaultAsync();
            //TODO: validate
            if (league == null)
            {
                return new LeagueSettingResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            if (league.UserId != userId)
            {
                return new LeagueSettingResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (league.ParticipateNodes.Any(n => (n.ClubCloneId != null && n.ClubCloneId != 0) &&
                            (n.LeftId != null && n.LeftId != 0)))
            {
                return new LeagueSettingResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-10"
                };
            }
            foreach (var node in league.ParticipateNodes.ToList())
            {
                if (node.LeftId == 0)
                {
                    if (node.ClubClone == null)
                    {
                        return new LeagueSettingResponse
                        {
                            Success = false,
                            MessageCode = "ER-PA-06"
                        };
                    }
                    node.ClubClone.ClubId = null;
                }
            };

            foreach (var node in request.ListNode)
            {
                var pNode = league.ParticipateNodes.FirstOrDefault(n => n.ParticipateId == node.NodeId);

                if (pNode == null || pNode.ClubClone == null)
                {
                    return new LeagueSettingResponse
                    {
                        Success = false,
                        MessageCode = "ER-PA-06"
                    };
                }
                if (pNode.LeftId != 0)
                {
                    return new LeagueSettingResponse
                    {
                        Success = false,
                        MessageCode = "ER-PA-11"
                    };
                }
                pNode.ClubClone.ClubId = node.ClubId;
            };
            var result = await leagueRepository.UpdateAsync(league);
            if (result != null)
            {
                return new LeagueSettingResponse
                {
                    Success = true,
                    MessageCode = "MS-PA-03"
                };
            }
            else
            {
                return new LeagueSettingResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-08"
                };
            }
        }
    }
}
