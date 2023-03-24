using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Listeners;
using FLMS_BackEnd.Listeners.Events;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using MailKit;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using IMailService = FLMS_BackEnd.Services.IMailService;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ParticipationController : BaseApiController
    {
        private readonly ParticipationService participationService;
        private readonly SendMailEventHandler sendMailEventHandler;
        public ParticipationController(ParticipationService participationService, IMailService mailService, SendMailEventHandler sendMailEventHandler)
        {
            this.participationService = participationService;
            this.sendMailEventHandler = sendMailEventHandler;

            sendMailEventHandler.SendMailEventArgs += async (sender, args) =>
            {
                bool sendResult = await mailService.SendEmailAsync(args.MailRequest, new CancellationToken());
                if (!sendResult)
                {
                    Console.WriteLine("Failed to send email: {EmailRequest}", args.MailRequest);
                }
            };
        }

        [HttpPut("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<ConfirmRegistFeeResponse>> ConfirmRegistFee(ConfirmRegistFeeRequest request)
        {
            var response = await participationService.ConfirmResgistFee(request, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.ConfirmFee,
                    MailData = response.mailData
                };
                sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpGet("[action]")]
        public async Task<ActionResult<ParticipationByLeagueResponse>> GetClubByLeague([FromQuery] ParticipationByLeagueRequest request)
        {
            var response = await participationService.GetParticipationByLeague(request);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpDelete("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<RemoveClubResponse>> RemoveJoinedClub([FromQuery] RemoveClubRequest request)
        {
            var response = await participationService.RemoveJoinedTeam(request, UserID);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.mailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.RemoveClub,
                    MailData = response.mailData
                };
                sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpGet("[action]/{id}")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<List<ClubBasicInfoDTO>>> GetUnpositionClub(int id)
        {
            var result = await participationService.ListUnpositionClub(id, UserID);
            return Ok(result);
        }
        [HttpPut("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<AddClubPositionResponse>> AddParticipationToPosition(int clubId, int clubCloneId)
        {
            var response = await participationService.AddClubPosition(clubCloneId, clubId, UserID);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpGet("[action]")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<List<JoinedLeagueDTO>>> GetListJoinedLeague()
        {
            var response = await participationService.GetListJoinedLeague(UserID);
            return response;
        }
        [HttpGet("[action]/{id}")]
        public async Task<ActionResult<ParticipateTreeResponse>> GetLeagueTree(int id)
        {
            var response = await participationService.GetLeagueParticipateTree(id);
            return response;
        }
    }
}

