using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
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
        private readonly IMailService mailService;

        public ParticipationController(ParticipationService participationService, IMailService mailService)
        {
            this.participationService = participationService;
            this.mailService = mailService;
        }

        [HttpPut("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<ConfirmRegistFeeResponse>> ConfirmRegistFee(ConfirmRegistFeeRequest request)
        {
            var response = await participationService.ConfirmResgistFee(request, UserID);
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
                MailRequest mailRequest = new MailRequest(
                    new List<string> {
                       response.mailData.Email
                    },
                    response.MailMessage,
                    mailService.GetEmailTemplate("RemoveClub", response.mailData));
                bool sendResult = await mailService.SendEmailAsync(mailRequest, new CancellationToken());
                if (sendResult)
                {
                    return Ok(response);
                }
                else
                {
                    return BadRequest("Mail sent failed");
                }
            }
            else
            {
                return BadRequest(response);
            }
        }
    }
}
