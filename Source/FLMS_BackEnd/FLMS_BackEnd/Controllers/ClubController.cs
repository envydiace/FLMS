using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api")]
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
            }else
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
        public async Task<ActionResult<ListClubResponse>> GetListClubFilter([FromQuery]ListClubFilterRequest request)
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
    }
}
