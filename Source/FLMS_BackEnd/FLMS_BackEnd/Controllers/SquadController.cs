using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SquadController : ControllerBase
    {
        private readonly SquadService squadService;
        public SquadController(SquadService squadService)
        {
            this.squadService = squadService;
        }

        [HttpGet("[action]/{matchId}")]
        public async Task<ActionResult<MatchSquadResponse>> GetMatchSquad(int matchId)
        {
            var response = await squadService.GetMatchSquad(matchId);
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
