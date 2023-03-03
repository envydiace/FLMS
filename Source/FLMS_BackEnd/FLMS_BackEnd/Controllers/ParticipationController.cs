using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ParticipationController : BaseApiController
    {
        private readonly ParticipationService participationService;

        public ParticipationController(ParticipationService participationService)
        {
            this.participationService = participationService;
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
    }
}
