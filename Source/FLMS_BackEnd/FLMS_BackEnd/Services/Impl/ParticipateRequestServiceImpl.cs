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
        private readonly ClubRepository clubRepository;
        private readonly UserRepository userRepository;

        public ParticipateRequestServiceImpl(ParticipateRequestRepository participateRequestRepository, LeagueRepository leagueRepository, UserRepository userRepository, ClubRepository clubRepository)
        {
            this.participateRequestRepository = participateRequestRepository;
            this.leagueRepository = leagueRepository;
            this.userRepository = userRepository;
            this.clubRepository = clubRepository;
        }

        public async Task<JoinResponse> SendJoinRequest(JoinRequest request, int UserId, Constants.RequestType type)
        {
            string defaultFailMessageCode = "ER-RE-06";
            string defaultSuccessMessageCode = "MS-RE-03";
            switch (type)
            {
                case Constants.RequestType.Invite:
                    var league = await leagueRepository.FindByCondition(l =>
                    l.UserId == UserId &&
                    l.LeagueId == request.LeagueId)
                    .FirstOrDefaultAsync();
                    if (league == null)
                    {
                        return new JoinResponse
                        {
                            Success = false,
                            MessageCode = "ER-LE-06"
                        };
                    }
                    var c = await clubRepository.FindByCondition(c => c.ClubId == request.ClubId).FirstOrDefaultAsync();
                    if (c == null)
                    {
                        return new JoinResponse
                        {
                            Success = false,
                            MessageCode = "ER-CL-02"
                        };
                    }
                    defaultSuccessMessageCode = "MS-RE-01";
                    defaultFailMessageCode = "ER-RE-04";
                    break;
                case Constants.RequestType.Register:
                    var club = await clubRepository.FindByCondition(c =>
                    c.UserId == UserId &&
                    c.ClubId == request.ClubId)
                    .FirstOrDefaultAsync();
                    if (club == null)
                    {
                        return new JoinResponse
                        {
                            Success = false,
                            MessageCode = "ER-CL-08"
                        };
                    }
                    var l = await leagueRepository.FindByCondition(l => l.LeagueId == request.LeagueId).FirstOrDefaultAsync();
                    if (l == null)
                    {
                        return new JoinResponse
                        {
                            Success = false,
                            MessageCode = "ER-LE-05"
                        };
                    }
                    defaultSuccessMessageCode = "MS-RE-02";
                    defaultFailMessageCode = "ER-RE-05";
                    break;
                default:
                    return new JoinResponse
                    {
                        Success = false,
                        MessageCode = defaultFailMessageCode
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
                    return new JoinResponse
                    {
                        Success = false,
                        MessageCode = "ER-RE-01"
                    };
                }

                if (r.RequestStatus.Equals(Constants.RequestStatus.Pending.ToString()) &&
                    r.RequestType.Equals(Constants.RequestType.Register.ToString()))
                {
                    return new JoinResponse
                    {
                        Success = false,
                        MessageCode = "ER-RE-02"
                    };
                }
                if (r.RequestStatus.Equals(Constants.RequestStatus.Pending.ToString()) &&
                    r.RequestType.Equals(Constants.RequestType.Invite.ToString()))
                {
                    return new JoinResponse
                    {
                        Success = false,
                        MessageCode = "ER-RE-03"
                    };
                }
            }
            var participateRequest = mapper.Map<ParticipateRequest>(request);
            participateRequest.RequestType = type.ToString();
            var result = await participateRequestRepository.CreateAsync(participateRequest);
            if (result)
            {
                return new JoinResponse
                {
                    Success = true,
                    MessageCode = defaultSuccessMessageCode
                };
            }
            else
            {
                return new JoinResponse
                {
                    Success = false,
                    MessageCode = defaultFailMessageCode
                };
            }
        }
        public async Task<RequestListResponse> GetRequestList(ListRequestFilterRequest request, int userId)
        {
            var user = await userRepository.FindByCondition(u => u.UserId == userId).FirstOrDefaultAsync();
            if (user == null)
            {
                return new RequestListResponse
                {
                    Success = false,
                    MessageCode = "ER-US-07"
                };
            }
            string role = user.Role;
            var listRequest = await participateRequestRepository.FindByCondition(r =>
                    (r.Club.UserId == userId || r.League.UserId == userId) &&
                    (request.From == null || r.RequestDate.CompareTo(request.From.GetValueOrDefault()) >= 0) &&
                    (request.To == null || r.RequestDate.CompareTo(request.To.GetValueOrDefault()) <= 0) &&
                    (request.Type == null || request.Type.Equals("All") || r.RequestType.Equals(request.Type)) &&
                    (request.Status == null || request.Status.Equals("All") || r.RequestType.Equals(request.Status))
                )
                .Include(r => r.League)
                .Include(r => r.Club)
                .OrderByDescending(r => r.RequestDate)
                .ToListAsync();
            List<RequestDTO> results = mapper.Map<List<RequestDTO>>(listRequest);
            results.ForEach(request =>
            {
                if (request.RequestStatus.Equals(Constants.RequestStatus.Pending.ToString())
                )
                {
                    string invite = Constants.RequestType.Invite.ToString();
                    string register = Constants.RequestType.Register.ToString();
                    string clubRole = Constants.SystemRole.CLUB_MANAGER.ToString();
                    string leagueRole = Constants.SystemRole.LEAGUE_MANAGER.ToString();

                    request.CanResponse = (request.RequestType.Equals(invite) &&
                                            clubRole.Equals(role)) ||
                                            (request.RequestType.Equals(register) &&
                                            leagueRole.Equals(role));

                    request.CanCancel = (request.RequestType.Equals(invite) &&
                                            leagueRole.Equals(role)) ||
                                            (request.RequestType.Equals(register) &&
                                            clubRole.Equals(role));
                }
            });
            return new RequestListResponse
            {
                Success = true,
                requests = results
            };
        }
    }
}
