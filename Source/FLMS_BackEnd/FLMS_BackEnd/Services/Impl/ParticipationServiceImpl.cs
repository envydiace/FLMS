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

        public ParticipationServiceImpl(ParticipationRepository participationRepository, ClubCloneRepository clubCloneRepository, ParticipateNodeRepository participateNodeRepository)
        {
            this.participationRepository = participationRepository;
            this.clubCloneRepository = clubCloneRepository;
            this.participateNodeRepository = participateNodeRepository;
        }

        public async Task<ConfirmRegistFeeResponse> ConfirmResgistFee(ConfirmRegistFeeRequest request, int userId)
        {
            var participation = await participationRepository.FindByCondition(p =>
                    p.ClubId == request.ClubId &&
                    p.LeagueId == request.LeagueId)
                .Include(p => p.League)
                .ThenInclude(l => l.ClubClones)
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
            if (participation.League.LeagueType.Equals(Constants.LeagueType.LEAGUE.ToString()))
            {
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
                .Include(p=>p.League).ThenInclude(l => l.User)
                .Include(p=>p.Club).ThenInclude(c => c.User)
                .FirstOrDefaultAsync();

            if (participation == null)
            {
                return new RemoveClubResponse { 
                    Success = false,
                    MessageCode = "ER-PA-01"
                };
            }
            if(participation.League.UserId != UserId)
            {
                return new RemoveClubResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if(participation.League.IsFinished)
            {
                return new RemoveClubResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-07"
                };
            }
            if(participation.Confirmed)
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
                    MessageMailCode= "MS-MAIL-09",
                    mailData = new MailDTO
                    {
                        LeagueManagerName = result.League.User.FullName,
                        ClubManagerName = result.Club.User.FullName,
                        Email = result.Club.User.Email,
                        LeagueName = result.League.LeagueName,
                        ClubName =result.Club.ClubName,
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
    }
}
