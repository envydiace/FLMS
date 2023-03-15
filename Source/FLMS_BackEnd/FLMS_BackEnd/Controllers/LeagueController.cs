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
    public class LeagueController : BaseApiController
    {
        private readonly LeagueService leagueService;
        public LeagueController(LeagueService leagueService)
        {
            this.leagueService = leagueService;
        }

        [HttpPost("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<CreateLeagueResponse>> CreateLeague(CreateLeagueRequest request)
        {
            var response = await leagueService.CreateLeague(request, UserID);
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
        public async Task<ActionResult<ListLeagueResponse>> GetListLeagueFilters([FromQuery] ListLeagueFilterRequest request)
        {
            var response = await leagueService.GetListLeagueFilters(request);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }

        [HttpGet("[action]/{id}")]
        public async Task<ActionResult<LeagueInfoResponse>> GetListLeagueInfo(int id)
        {
            var response = await leagueService.GetLeagueInfo(id);
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
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<IActionResult> GetListLeagueByUser()
        {
            try
            {
                var response = await leagueService.GetListLeagueByUser(UserID);
                return Ok(response);
            }
            catch (Exception)
            {
                return BadRequest(new BaseResponse { MessageCode = "ER-CO-01" });
            }
        }
        [HttpGet("[action]/{id}")]
        public async Task<ActionResult<LeagueStatisticResponse>> GetLeagueStatistic(int id)
        {

            var response = await leagueService.GetLeagueStatistic(id);
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
