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
    public class RequestController : BaseApiController
    {
        private readonly ParticipateRequestService participateRequestService;

        public RequestController(ParticipateRequestService participateRequestService)
        {
            this.participateRequestService = participateRequestService;
        }

        [HttpPost("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<InvitationResponse>> SendInvitation(InvitationRequest request)
        {
            var response = await participateRequestService.SendInvitation(request, UserID);
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
        [Authorize(Roles = "LEAGUE_MANAGER,CLUB_MANAGER")]
        public async Task<ActionResult<RequestListResponse>> RequestList()
        {
            var response = await participateRequestService.GetRequestList(UserID);
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