using FLMS_BackEnd.Services;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MatchController : BaseApiController
    {
        private readonly MatchService matchService;
        public MatchController(MatchService matchService)
        {
            this.matchService = matchService;
        }
        [HttpGet("[action]/{matchId}")]
        public async Task<ActionResult<MatchInfoResponse>> GetMatchInfo(int matchId)
        {
            var response = await matchService.GetMatchInfo(matchId);
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
        public async Task<ActionResult<LeagueScheduleResponse>> GetLeagueSchedule([FromQuery] LeagueScheduleRequest request)
        {
            var response = await matchService.GetLeagueSchedule(request);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpGet("[action]/{clubId}")]
        public async Task<ActionResult<ClubScheduleResponse>> GetClubSchedule(int clubId)
        {
            var response = await matchService.GetClubSchedule(clubId);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPut("[action]/{id}")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<FinishMatchResponse>> FinishMatch(int id)
        {
            var response = await matchService.FinishMatch(id, UserID);
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
        public async Task<ActionResult<UpdateMatchInfoResponse>> UpdateMatch(UpdateMatchInfoRequest request)
        {
            var response = await matchService.UpdateMatchInfo(request, UserID);
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
        public async Task<ActionResult<LoseJudgeResponse>> LoseJudge(LoseJudgeRequest request)
        {
            var response = await matchService.LoseJudge(request, UserID);
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
