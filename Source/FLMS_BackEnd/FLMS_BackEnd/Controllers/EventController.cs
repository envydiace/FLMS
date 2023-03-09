using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventController : ControllerBase
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
    }
}
