using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class ParticipateRequestServiceImpl : BaseService, ParticipateRequestService
    {
        private readonly ParticipateRequestRepository participateRequestRepository;
        private readonly LeagueRepository leagueRepository;

        public ParticipateRequestServiceImpl(ParticipateRequestRepository participateRequestRepository, LeagueRepository leagueRepository)
        {
            this.participateRequestRepository = participateRequestRepository;
            this.leagueRepository = leagueRepository;
        }

        public async Task<InvitationResponse> SendInvitation(InvitationRequest request, int UserId)
        {
            var league = await leagueRepository.FindByCondition(l =>
                    l.UserId == UserId &&
                    l.LeagueId == request.LeagueId
                )
                    .FirstOrDefaultAsync();
            if (league == null)
            {
                return new InvitationResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            var listRequest = await participateRequestRepository.FindByCondition(r =>
                    r.ClubId == request.ClubId &&
                    r.LeagueId == request.LeagueId)
                .Include(r => r.League)
                .ThenInclude(l => l.Participations)
                .ToListAsync();

            foreach (var r in listRequest)
            {
                if (r.League.Participations.FirstOrDefault(c => c.ClubId == request.ClubId) != null)
                {
                    return new InvitationResponse
                    {
                        Success = false,
                        MessageCode = "ER-RE-01"
                    };
                }

                if (r.RequestStatus.Equals(Constants.RequestStatus.Pending.ToString()) &&
                    r.RequestType.Equals(Constants.RequestType.Register.ToString()))
                {
                    return new InvitationResponse
                    {
                        Success = false,
                        MessageCode = "ER-RE-02"
                    };
                }
                if (r.RequestStatus.Equals(Constants.RequestStatus.Pending.ToString()) &&
                    r.RequestType.Equals(Constants.RequestType.Invite.ToString()))
                {
                    return new InvitationResponse
                    {
                        Success = false,
                        MessageCode = "ER-RE-03"
                    };
                }
            }
            var participateRequest = mapper.Map<ParticipateRequest>(request);
            var result = await participateRequestRepository.CreateAsync(participateRequest);
            if (result)
            {
                return new InvitationResponse
                {
                    Success = true,
                    MessageCode = "MS-RE-01"
                };
            }
            else
            {
                return new InvitationResponse
                {
                    Success = false,
                    MessageCode = "ER-RE-04"
                };
            }
        }
        public async Task<RequestListResponse> GetRequestList(int userId)
        {
            var listRequest = await participateRequestRepository.FindByCondition(r =>
                    r.Club.UserId == userId ||
                    r.League.UserId == userId
                )
                .Include(r => r.League)
                .Include(r => r.Club)
                .ToListAsync();
            return new RequestListResponse
            {
                Success = true,
                requests = mapper.Map<List<RequestDTO>>(listRequest)
            };
        }
    }
}
