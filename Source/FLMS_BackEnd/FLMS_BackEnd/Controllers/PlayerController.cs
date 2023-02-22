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
    public class PlayerController : BaseApiController
    {
        private readonly PlayerService playerService;
        public PlayerController(PlayerService playerService)
        {
            this.playerService = playerService;
        }

        [HttpPost("[action]")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<CreateResponse>> CreatePlayer(CreatePlayerRequest createPlayerRequest)
        {
            var response = await playerService.CreatePlayer(createPlayerRequest, UserID);
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
        public async Task<ActionResult<PlayerResponse>> GetPlayer(int id)
        {
            var response = await playerService.GetPlayerById(id);
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
        public async Task<ActionResult<ListPlayerResponse>> GetListPlayerFilter([FromQuery] ListPlayerFilterRequest request)
        {
            var response = await playerService.GetListPlayerFilter(request);
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
