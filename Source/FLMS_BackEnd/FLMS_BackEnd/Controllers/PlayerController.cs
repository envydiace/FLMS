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

        [HttpGet("[action]/{id:int}")]
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
        [HttpGet("[action]")]
        public async Task<ActionResult<ListPlayerSearchResponse>> GetListPlayerByClubId([FromQuery] ListPlayerByClubRequest request)
        {
            var response = await playerService.GetListPlayerByClubIdWithSearch(request);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }

        [HttpDelete("[action]/{id}")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<DeletePlayerResponse>> DeletePlayer(int id)
        {
            var response = await playerService.DeletePlayer(id, UserID);
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
        public async Task<ActionResult<UpdatePlayerResponse>> UpdatePlayer(UpdatePlayerRequest request)
        {
            var response = await playerService.UpdatePlayer(request, UserID);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpGet("[action]/{nickname}")]
        public async Task<ActionResult<PlayerResponse>> GetPlayerByNickName(string nickname)
        {
            var response = await playerService.GetPlayerByNickname(nickname);
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
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<DeletePlayerClubResponse>> DeletePlayerClub(DeletePlayerClubRequest request)
        {
            var response = await playerService.DeletePlayerClub(request, UserID);
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
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<GetPlayerByClubManagerResponse>> GetPlayerByClubManager([FromQuery] GetPlayerByClubManagerRequest request)
        {
            var response = await playerService.GetPlayerByClubManager(request, UserID);
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
