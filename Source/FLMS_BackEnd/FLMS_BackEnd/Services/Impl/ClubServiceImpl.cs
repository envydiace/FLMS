using AutoMapper;
using DocumentFormat.OpenXml.Office2016.Excel;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Asn1.Ocsp;

namespace FLMS_BackEnd.Services.Impl
{
    public class ClubServiceImpl : BaseService, ClubService
    {

        private readonly ClubRepository clubRepository;
        private readonly SquadRepository squadRepository;
        private readonly MatchRepository matchRepository;
        private readonly ParticipateNodeRepository participateNodeRepository;

        public ClubServiceImpl(ClubRepository clubRepository, SquadRepository squadRepository, MatchRepository matchRepository, ParticipateNodeRepository participateNodeRepository)
        {
            this.clubRepository = clubRepository;
            this.squadRepository = squadRepository;
            this.matchRepository = matchRepository;
            this.participateNodeRepository = participateNodeRepository;
        }
        public async Task<ClubResponse> GetClubById(int id)
        {
            var club = await clubRepository.FindByCondition(c => c.ClubId == id).Include(c => c.User).FirstOrDefaultAsync();
            if (club == null)
            {
                return new ClubResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-02"
                };
            }
            return new ClubResponse
            {
                Success = true,
                ClubInfo = mapper.Map<ClubDTO>(club)
            };
        }

        public async Task<CreateResponse> CreateClub(CreateClubRequest request, int UserId)
        {
            var c = await clubRepository.FindByCondition(c =>
                    c.ClubName.ToLower().Trim().Equals(request.ClubName.ToLower().Trim()))
                .FirstOrDefaultAsync();
            if (c != null)
            {
                return new CreateResponse { Success = false, MessageCode = "ER-CL-07" };
            }
            Club club = mapper.Map<Club>(request);
            club.UserId = UserId;
            bool result = await clubRepository.CreateAsync(club);
            return result ?
                new CreateResponse { Success = true, MessageCode = "MS-CL-02" }
                : new CreateResponse { Success = false, MessageCode = "ER-CL-05" };
        }

        public async Task<ListClubResponse> GetListClubFilter(ListClubFilterRequest request)
        {
            var clubs = await clubRepository.FindByCondition(club =>
            (request.searchClubName == null || request.searchClubName == "" || club.ClubName.StartsWith(request.searchClubName))
                && (request.searchManagerName == null || request.searchManagerName == "" || club.User.FullName.StartsWith(request.searchManagerName))
            ).Include(club => club.User).ToListAsync();
            int total = clubs.Count;
            var result = mapper.Map<List<ClubDTO>>(clubs.Skip((request.page - 1) * request.pageSize).Take(request.pageSize).ToList());
            return new ListClubResponse
            {
                Success = true,
                Clubs = result,
                Total = total,
                PageIndex = request.page,
                PageSize = request.pageSize
            };
        }

        public async Task<UpdateClubResponse> UpdateClub(UpdateClubRequest request)
        {
            var c = await clubRepository.FindByCondition(club => club.ClubId == request.ClubId).FirstOrDefaultAsync();
            if (c == null)
            {
                return new UpdateClubResponse { Success = false, MessageCode = "ER-CL-02" };
            }
            Club club = mapper.Map<Club>(request);
            club.CreateAt = c.CreateAt;
            club.UserId = c.UserId;
            Club result = await clubRepository.UpdateAsync(club);
            if (result != null)
            {
                return new UpdateClubResponse
                {
                    Success = true,
                    MessageCode = "MS-CL-03",
                    ClubInfo = this.GetClubById(result.ClubId).Result.ClubInfo
                };
            }
            return new UpdateClubResponse { Success = false, MessageCode = "ER-CL-06" };
        }

        public async Task<DeleteClubResponse> DeleteClub(int id, int userId)
        {
            //TODO: check number of player in club
            var club = await clubRepository.FindByCondition(club => club.ClubId == id)
                        .Include(c => c.ClubClones)
                        .Include(c => c.ParticipateRequests)
                        .Include(c => c.Participations)
                        .FirstOrDefaultAsync();
            if (club == null)
            {
                return new DeleteClubResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-02"
                };
            }
            if (club.UserId != userId)
            {
                return new DeleteClubResponse { Success = false, MessageCode = "ER-CL-03" };
            }
            if (club.ParticipateRequests.Any())
            {
                return new DeleteClubResponse { Success = false, MessageCode = "ER-CL-10" };
            }
            if (club.ClubClones.Any() || club.Participations.Any())
            {
                return new DeleteClubResponse { Success = false, MessageCode = "ER-CL-09" };
            }
            Club result = await clubRepository.DeleteAsync(club);
            if (result != null)
            {
                return new DeleteClubResponse
                {
                    Success = true,
                    MessageCode = "MS-CL-01",
                    Club = mapper.Map<ClubDTO>(result)
                };
            }
            return new DeleteClubResponse { Success = false, MessageCode = "ER-CL-04" };
        }

        public async Task<List<ClubByUserDTO>> GetListClubByUser(int userId)
        {
            var listClubs = await clubRepository.FindByCondition(c => c.UserId == userId).ToListAsync();
            return mapper.Map<List<ClubByUserDTO>>(listClubs);
        }

        public async Task<List<ClubHistoryDTO>> GetClubLeagueHistory(int clubId)
        {
            var club = await clubRepository.FindByCondition(c => c.ClubId == clubId)
                                    .Include(c => c.ClubClones).ThenInclude(cl => cl.League).ThenInclude(l => l.Participations)
                                        .FirstOrDefaultAsync();
            if (club == null)
            {
                return new List<ClubHistoryDTO>();
            }
            var result = mapper.Map<ICollection<ClubHistoryDTO>>(club.ClubClones).OrderByDescending(ch => ch.JoinedDate).ToList();
            
            return result;
        }

        public async Task<List<IncomingMatchDTO>> GetIncomingMatch(int userId)
        {
            var result = new List<IncomingMatchDTO>();
            var clubIds = await clubRepository.FindByCondition(c => c.UserId == userId).Select(c => c.ClubId).ToListAsync();
            if (clubIds == null || !clubIds.Any())
            {
                return result;
            }
            var squads = await squadRepository.FindByCondition(s =>
                            s.Match.Home.ClubClone != null &&
                            s.Match.Away.ClubClone != null &&
                            s.Match.Home.ClubClone.ClubId != null &&
                            s.Match.Away.ClubClone.ClubId != null &&
                            (
                                (
                                    s.IsHome &&
                                    clubIds.Contains(s.Match.Home.ClubClone.ClubId.Value)
                                ) ||
                                (
                                    !s.IsHome &&
                                    clubIds.Contains(s.Match.Away.ClubClone.ClubId.Value)
                                )
                            ) &&
                            !s.Match.IsFinish
                            )
                            .Include(s => s.Match).ThenInclude(m => m.Home).ThenInclude(h => h.ClubClone).ThenInclude(cl => cl.Club)
                            .Include(s => s.Match).ThenInclude(m => m.Away).ThenInclude(h => h.ClubClone).ThenInclude(cl => cl.Club)
                            .Include(s => s.Match).ThenInclude(m => m.League)
                            .OrderBy(s => s.Match.MatchDate)
                    .ToListAsync();
            squads.ForEach(s =>
            {
                result.Add(new IncomingMatchDTO
                {
                    SquadId = s.SquadId,
                    ClubName = s.IsHome ? s.Match.Home.ClubClone.Club.ClubName : s.Match.Away.ClubClone.Club.ClubName,
                    Against = s.IsHome ? s.Match.Away.ClubClone.Club.ClubName : s.Match.Home.ClubClone.Club.ClubName,
                    Ha = s.IsHome ? Constants.HOME : Constants.AWAY,
                    LeagueName = s.Match.League.LeagueName,
                    Round = s.Match.Round,
                    Stadium = s.Match.Stadium,
                    MatchDate = s.Match.MatchDate.ToString(Constants.DATE_FORMAT),
                    MatchTime = s.Match.MatchDate.ToString(Constants.TIME_FORMAT)
                });
            });
            return result;
        }

        public async Task<ClubHistoryResponse> GetClubHistory(int clubId)
        {
            var nodes = await participateNodeRepository.FindByCondition(p => p.ClubClone.ClubId == clubId).ToListAsync();
            if (nodes == null)
            {
                nodes = new List<ParticipateNode>();
            }
            List<Match> lmatches = new List<Match>();
            foreach (var node in nodes)
            {
                var matches = await matchRepository.FindByCondition
                    (m => ((m.HomeId == node.ParticipateNodeId) || (m.AwayId == node.ParticipateNodeId)) && m.IsFinish)
                    .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                    .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                    .Include(m => m.League)
                    .Include(m => m.MatchStats)
                    .ToListAsync();
                if (matches != null)
                {
                    lmatches.AddRange(matches);
                }
            }
            var listMatch = mapper.Map<List<MatchDTO>>(lmatches.OrderByDescending(m => m.MatchDate));
            listMatch.ForEach(m =>
            {
                var match = lmatches.Where(x => x.MatchId == m.MatchId).FirstOrDefault();
                if (match != null)
                {
                    var homeStats = match.MatchStats.FirstOrDefault(ms => ms.IsHome);
                    m.Home.Score = homeStats != null ? homeStats.Score : 0;
                    var awayStats = match.MatchStats.FirstOrDefault(ms => !ms.IsHome);
                    m.Away.Score = awayStats != null ? awayStats.Score : 0;
                }
            });

            return new ClubHistoryResponse
            {
                Success = true,
                listMatch = listMatch
            };
        }

        public async Task<ClubUpdateInfoResponse> GetClubUpdateInfo(int clubId)
        {
            var club = await clubRepository.FindByCondition(c => c.ClubId == clubId).FirstOrDefaultAsync();
            if(club == null)
            {
                return new ClubUpdateInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-02"
                };
            }
            return new ClubUpdateInfoResponse
            {
                Success = true,
                Info = mapper.Map<ClubUpdateInfoDTO>(club),
            };
        }

        public async Task<ClubUpdateInfoResponse> UpdateClubInfo(UpdateClubInfoRequest request, int UserId)
        {
            var club = await clubRepository.FindByCondition(c => c.ClubId == request.ClubId).FirstOrDefaultAsync();
            if (club == null)
            {
                return new ClubUpdateInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-02"
                };
            }
            if (club.UserId != UserId)
            {
                return new ClubUpdateInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-08"
                };
            }
            if(request.Logo == null || request.Logo.Equals(""))
            {
                club.Logo = null;
            }
            else
            {
                club.Logo = request.Logo;
            }
            club.FanPage = request.FanPage;
            club.Email = request.Email;
            club.PhoneNumber = request.PhoneNumber;
            var result = await clubRepository.UpdateAsync(club);
            if (result != null)
            {
                return new ClubUpdateInfoResponse
                {
                    Success = true,
                    MessageCode = "MS-CL-03",
                    Info = mapper.Map<ClubUpdateInfoDTO>(result)
                };
            }
            return new ClubUpdateInfoResponse { Success = false, MessageCode = "ER-CL-06" };
        }
    }
}
