using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.AspNetCore.Authorization;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventController : BaseApiController
    {
        private readonly MatchEventService matchEventService;

        public EventController(MatchEventService matchEventService)
        {
            this.matchEventService = matchEventService;
        }
        [HttpGet("[action]/{matchId}")]
        public async Task<List<MatchEventDTO>> GetMatchEvent(int matchId)
        {
            return await matchEventService.GetMatchEvent(matchId);
        }
        [HttpPost("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<AddMatchEventResponse>> AddMatchEvent(AddMatchEventRequest request)
        {
            var response = await matchEventService.AddEvent(request, UserID);
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
