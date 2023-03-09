using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MatchStatisticController : BaseApiController
    {
        private readonly MatchStatisticService matchStatisticService;
        public MatchStatisticController(MatchStatisticService matchStatisticService)
        {
            this.matchStatisticService = matchStatisticService;
        }
        [HttpGet("[action]/{matchId}")]
        public async Task<ActionResult<MatchStatisticResponse>> GetMatchStat(int matchId)
        {
            var response = await matchStatisticService.GetMatchStatistic(matchId);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPut("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<MatchStatisticResponse>> UpdateMatchStat(UpdateMatchStatRequest request)
        {
            var response = await matchStatisticService.UpdateMatchStatistic(request,UserID);
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
