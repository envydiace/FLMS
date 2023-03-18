using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClubController : BaseApiController
    {
        private readonly ClubService clubService;
        public ClubController(ClubService clubService)
        {
            this.clubService = clubService;
        }

        [HttpPost("[action]")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<CreateResponse>> CreateClub(CreateClubRequest createClubRequest)
        {
            var response = await clubService.CreateClub(createClubRequest, UserID);
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
        public async Task<ActionResult<ClubResponse>> GetClub(int id)
        {
            var response = await clubService.GetClubById(id);
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
        public async Task<ActionResult<ListClubResponse>> GetListClubFilter([FromQuery] ListClubFilterRequest request)
        {
            var response = await clubService.GetListClubFilter(request);
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
        public async Task<ActionResult<UpdateClubResponse>> UpdateClub(UpdateClubRequest request)
        {
            var response = await clubService.UpdateClub(request);
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
        public async Task<ActionResult<DeleteClubResponse>> DeleteClub(int id)
        {
            var response = await clubService.DeleteClub(id, UserID);
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
        public async Task<ActionResult<List<ClubByUserDTO>>> GetListClubByUser()
        {
            try
            {
                var response = await clubService.GetListClubByUser(UserID);
                return Ok(response);
            }
            catch (Exception)
            {
                return BadRequest(new BaseResponse { MessageCode = "ER-CO-01" });
            }
        }
        [HttpGet("[action]/{id}")]
        public async Task<ActionResult<List<ClubHistoryDTO>>> GetClubLeagueHistory(int id)
        {
            try
            {
                var response = await clubService.GetClubLeagueHistory(id);
                return Ok(response);
            }
            catch (Exception)
            {
                return BadRequest(new BaseResponse { MessageCode = "ER-CO-01" });
            }
        }
        [HttpGet("[action]")]
        [Authorize(Roles = "CLUB_MANAGER")]
        public async Task<ActionResult<List<IncomingMatchDTO>>> GetIncomingMatches()
        {
            var response = await clubService.GetIncomingMatch(UserID);
            return Ok(response);
        }
    }
}
