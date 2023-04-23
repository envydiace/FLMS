using FLMS_BackEnd.Listeners;
using FLMS_BackEnd.Listeners.Events;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Serilog;
using System.Diagnostics;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RequestController : BaseApiController
    {
        private readonly ParticipateRequestService participateRequestService;
        private readonly SendMailEventHandler sendMailEventHandler;
        public RequestController(ParticipateRequestService participateRequestService, IMailService mailService, SendMailEventHandler sendMailEventHandler)
        {
            this.participateRequestService = participateRequestService;
            this.sendMailEventHandler = sendMailEventHandler;

            sendMailEventHandler.SendMailEventArgs += async (sender, args) =>
            {
                bool sendResult = await mailService.SendEmailAsync(args.MailRequest, new CancellationToken());
                if (!sendResult)
                {
                    Console.WriteLine($"Failed to send email: {args.MailRequest}");
                }
            };
        }

        [HttpPost("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<JoinResponse>> SendInvitation(JoinRequest request)
        {
            var response = await participateRequestService.SendJoinRequest(request, UserID, Constants.RequestType.Invite);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Invitation,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest});
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPost("[action]")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<JoinResponse>> SendRegistration(JoinRequest request)
        {
            var response = await participateRequestService.SendJoinRequest(request, UserID, Constants.RequestType.Register);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Registration,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }

        [HttpGet("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER,CLUB_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> RequestListFilter([FromQuery] ListRequestFilterRequest request)
        {
            var response = await participateRequestService.GetRequestList(request, UserID);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }

        [HttpPut("[action]/{requestId}")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> AcceptInvitation(int requestId)
        {
            var response = await participateRequestService.ResponseJoinRequest(requestId, Constants.RequestResponse.Accept, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Accept,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPut("[action]/{requestId}")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> RejectInvitation(int requestId)
        {
            var response = await participateRequestService.ResponseJoinRequest(requestId, Constants.RequestResponse.Reject, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Reject,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPut("[action]/{requestId}")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> CancelRegistration(int requestId)
        {
            var response = await participateRequestService.ResponseJoinRequest(requestId, Constants.RequestResponse.Cancel, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Cancel,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPut("[action]/{requestId}")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> AcceptRegistration(int requestId)
        {
            var response = await participateRequestService.ResponseJoinRequest(requestId, Constants.RequestResponse.Accept, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Accept,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPut("[action]/{requestId}")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> RejectRegistration(int requestId)
        {
            var response = await participateRequestService.ResponseJoinRequest(requestId, Constants.RequestResponse.Reject, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Reject,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPut("[action]/{requestId}")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> CancelInvitation(int requestId)
        {
            var response = await participateRequestService.ResponseJoinRequest(requestId, Constants.RequestResponse.Cancel, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.Cancel,
                    MailData = response.mailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
    }
}