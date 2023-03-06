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
            string leagueManagerFullName = "";
            string clubManagerFullName = "";
            string email = "";
            string defaultFailMessageCode = "ER-RE-06";
            string defaultSuccessMessageCode = "MS-RE-03";
            string messageMailCode = "";
            switch (type)
            {
                case Constants.RequestType.Invite:
                    var league = await leagueRepository.FindByCondition(l =>
                    l.UserId == UserId &&
                    l.LeagueId == request.LeagueId)
                        .Include(l => l.User)
                    .FirstOrDefaultAsync();
                    if (league == null)
                    {
                        return new JoinResponse
                        {
                            Success = false,
                            MessageCode = "ER-LE-06"
                        };
                    }
                    var c = await clubRepository.FindByCondition(c => c.ClubId == request.ClubId).Include(c => c.User).FirstOrDefaultAsync();
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
                    if (league != null && c != null)
                    {
                        leagueManagerFullName = league.User.FullName;
                        clubManagerFullName = c.User.FullName;
                        email = c.User.Email;
                        messageMailCode = "MS-MAIL-01";
                    }
                    break;
                case Constants.RequestType.Register:
                    var club = await clubRepository.FindByCondition(c =>
                    c.UserId == UserId &&
                    c.ClubId == request.ClubId)
                        .Include(c => c.User)
                    .FirstOrDefaultAsync();
                    if (club == null)
                    {
                        return new JoinResponse
                        {
                            Success = false,
                            MessageCode = "ER-CL-08"
                        };
                    }
                    var l = await leagueRepository.FindByCondition(l => l.LeagueId == request.LeagueId).Include(l => l.User).FirstOrDefaultAsync();
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
                    if (club != null && l != null)
                    {
                        leagueManagerFullName = l.User.FullName;
                        clubManagerFullName = club.User.FullName;
                        email = l.User.Email;
                        messageMailCode = "MS-MAIL-02";
                    }
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
                switch (type)
                {
                    case Constants.RequestType.Invite:
                        return new JoinResponse
                        {
                            Success = true,
                            mailData = new MailDTO
                            {
                                LeagueManagerName = leagueManagerFullName,
                                ClubManagerName = clubManagerFullName,
                                Email = email,
                            },
                            MessageCode = defaultSuccessMessageCode,
                            MessageMailCode = messageMailCode
                        };
                    case Constants.RequestType.Register:
                        return new JoinResponse
                        {
                            Success = true,
                            mailData = new MailDTO
                            {
                                LeagueManagerName = leagueManagerFullName,
                                ClubManagerName = clubManagerFullName,
                                Email = email,
                            },
                            MessageCode = defaultSuccessMessageCode,
                            MessageMailCode = messageMailCode
                        };
                    default:
                        return new JoinResponse
                        {
                            Success = false,
                            MessageCode = defaultFailMessageCode
                        };
                }
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
        public async Task<ResponseRequestResponse> ResponseJoinRequest(int requestId, Constants.RequestResponse response, int userId)
        {
            string messageCode = "ER-RE-13";
            var request = await participateRequestRepository.FindByCondition(r => r.RequestId == requestId)
                    .Include(r => r.Club)
                    .Include(r => r.League).ThenInclude(l => l.Participations)
                .FirstOrDefaultAsync();
            if (request == null)
            {
                return new ResponseRequestResponse
                {
                    Success = false,
                    MessageCode = "ER-RE-07"
                };
            }
            if (!request.RequestStatus.Equals(Constants.RequestStatus.Pending.ToString()))
            {
                return new ResponseRequestResponse
                {
                    Success = false,
                    MessageCode = "ER-RE-09"
                };
            }
            var user = await userRepository.FindByCondition(u => u.UserId == userId)
                    .FirstOrDefaultAsync();
            if (user == null)
            {
                return new ResponseRequestResponse
                {
                    Success = false,
                    MessageCode = "ER-US-07"
                };
            }

            string role = user.Role;
            string roleClubManager = Constants.SystemRole.CLUB_MANAGER.ToString();
            string roleLeagueManager = Constants.SystemRole.LEAGUE_MANAGER.ToString();

            if (role.Equals(roleClubManager) && request.Club.UserId != userId)
            {
                return new ResponseRequestResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-08"
                };
            }
            if (role.Equals(roleLeagueManager) && request.League.UserId != userId)
            {
                return new ResponseRequestResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }

            switch (response)
            {
                case Constants.RequestResponse.Accept:
                    if ((request.RequestType.Equals(Constants.RequestType.Invite.ToString()) && role.Equals(roleLeagueManager)) ||
                        (request.RequestType.Equals(Constants.RequestType.Register.ToString()) && role.Equals(roleClubManager)))
                    {
                        return new ResponseRequestResponse
                        {
                            Success = false,
                            MessageCode = "ER-RE-10"
                        };
                    }
                    request.RequestStatus = Constants.RequestStatus.Accepted.ToString();
                    messageCode = "MS-RE-04";
                    request.League.Participations.Add(new Participation { ClubId = request.ClubId, Confirmed = false });
                    break;
                case Constants.RequestResponse.Reject:
                    if ((request.RequestType.Equals(Constants.RequestType.Invite.ToString()) && role.Equals(roleLeagueManager)) ||
                        (request.RequestType.Equals(Constants.RequestType.Register.ToString()) && role.Equals(roleClubManager)))
                    {
                        return new ResponseRequestResponse
                        {
                            Success = false,
                            MessageCode = "ER-RE-11"
                        };
                    }
                    request.RequestStatus = Constants.RequestStatus.Rejected.ToString();
                    messageCode = "MS-RE-05";
                    break;
                case Constants.RequestResponse.Cancel:
                    if ((request.RequestType.Equals(Constants.RequestType.Invite.ToString()) && role.Equals(roleClubManager)) ||
                        (request.RequestType.Equals(Constants.RequestType.Register.ToString()) && role.Equals(roleLeagueManager)))
                    {
                        return new ResponseRequestResponse
                        {
                            Success = false,
                            MessageCode = "ER-RE-12"
                        };
                    }
                    request.RequestStatus = Constants.RequestStatus.Canceled.ToString();
                    messageCode = "MS-RE-06";
                    break;
                default:
                    return new ResponseRequestResponse
                    {
                        Success = false,
                        MessageCode = "ER-RE-08"
                    };
            }

            var result = await participateRequestRepository.UpdateAsync(request);
            if (result != null)
            {
                MailDTO mailData = await this.HandleSendMail(request.ClubId, request.LeagueId, response, request.RequestType);
                return new ResponseRequestResponse
                {
                    Success = true,
                    mailData = mailData,
                    MessageCode = messageCode,
                    MessageMailCode = mailData.MailMessageCode
                };
            }
            else
            {
                return new ResponseRequestResponse
                {
                    Success = false,
                    MessageCode = messageCode
                };
            }
        }

        public async Task<MailDTO> HandleSendMail(int clubId, int leagueId, Constants.RequestResponse response, string requestType)
        {
            var club = await clubRepository.FindByCondition(c => c.ClubId == clubId).Include(c => c.User).FirstOrDefaultAsync();
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId).Include(l => l.User).FirstOrDefaultAsync();
            if (club == null || league == null)
            {
                throw new Exception("Send Mail Fail");
            }
            MailDTO mailForLeagueManager = new MailDTO
            {
                ClubName = club.ClubName,
                LeagueName = league.LeagueName,
                ClubManagerName = club.User.FullName,
                LeagueManagerName = league.User.FullName,
                Email = league.User.Email,
                ReceiverRole = league.User.Role
            };
            MailDTO mailForClubManager = new MailDTO
            {
                LeagueName = league.LeagueName,
                ClubName = club.ClubName,
                ClubManagerName = club.User.FullName,
                LeagueManagerName = league.User.FullName,
                Email = club.User.Email,
                ReceiverRole = club.User.Role
            };
            switch (response)
            {
                case Constants.RequestResponse.Accept:
                    if (requestType.Equals(Constants.RequestType.Invite.ToString()))
                    {
                        mailForLeagueManager.MailMessageCode = "MS-MAIL-03";
                        return mailForLeagueManager;
                    }
                    else if (requestType.Equals(Constants.RequestType.Register.ToString()))
                    {
                        mailForClubManager.MailMessageCode = "MS-MAIL-04";
                        return mailForClubManager;
                    }
                    else
                    {
                        throw new Exception("Send Mail Fail");
                    }
                case Constants.RequestResponse.Reject:
                    if (requestType.Equals(Constants.RequestType.Invite.ToString()))
                    {
                        mailForLeagueManager.MailMessageCode = "MS-MAIL-05";
                        return mailForLeagueManager;
                    }
                    else if (requestType.Equals(Constants.RequestType.Register.ToString()))
                    {
                        mailForClubManager.MailMessageCode = "MS-MAIL-06";
                        return mailForClubManager;
                    }
                    else
                    {
                        throw new Exception("Send Mail Fail");
                    }
                case Constants.RequestResponse.Cancel:
                    if (requestType.Equals(Constants.RequestType.Invite.ToString()))
                    {
                        mailForClubManager.MailMessageCode = "MS-MAIL-07";
                        return mailForClubManager;
                    }
                    else if (requestType.Equals(Constants.RequestType.Register.ToString()))
                    {
                        mailForLeagueManager.MailMessageCode = "MS-MAIL-08";
                        return mailForLeagueManager;
                    }
                    else
                    {
                        throw new Exception("Send Mail Fail");
                    }
                default:
                    throw new Exception("Send Mail Fail");
            }
        }
    }
}

