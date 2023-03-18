using FLMS_BackEnd.DTO;
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
    public class SquadController : BaseApiController
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
        [HttpGet("[action]/{squadId}")]
        public async Task<ActionResult<MatchSquadResponse>> GetSquad(int squadId)
        {
            var response = await squadService.GetSquadById(squadId);
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
        public async Task<ActionResult<MatchSquadResponse>> GetSquadInMatch([FromQuery] SquadInMatchRequest request)
        {
            var response = await squadService.GetSquadInMatch(request);
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
        public async Task<ActionResult<List<PlayerSquadPositionDTO>>> GetUnsquadPlayers(int squadId)
        {
            var response = await squadService.GetUnsquadPlayer(squadId);
            return Ok(response);
        }

        [HttpPut("[action]")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<AddPositionResponse>> AddPlayerToPosition(AddPositionRequest request)
        {
            var response = await squadService.AddSquadPosition(request, UserID);
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
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<RemovePositionResponse>> RemovePlayerFromPosition(int positionId)
        {
            var response = await squadService.RemoveSquadPosition(positionId, UserID);
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
        public async Task<ActionResult<List<PlayerSquadPositionDTO>>> GetPlayerJoinedMatch(int matchId)
        {
            var response = await squadService.GetMatchPlayers(matchId);
            return Ok(response);
        }
        [HttpGet("[action]")]
        public async Task<ActionResult<List<PlayerSquadPositionDTO>>> GetPlayerForEvent([FromQuery]PlayerForEventRequest request)
        {
            var response = await squadService.GetPlayerForEvent(request);
            return Ok(response);
        }
        [HttpPut("[action]")]
        public async Task<ActionResult<UpdateSquadResponse>> UpdateSquad(UpdateSquadRequest request)
        {
            var response = await squadService.UpdateSquad(request, 0);
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
