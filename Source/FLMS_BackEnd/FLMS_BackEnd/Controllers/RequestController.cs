using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
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
        public async Task<ActionResult<JoinResponse>> SendInvitation(JoinRequest request)
        {
            var response = await participateRequestService.SendJoinRequest(request, UserID, Constants.RequestType.Invite);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
        [HttpPost("[action]")]
        [Authorize(Roles ="CLUB_MANAGER")]
        public async Task<ActionResult<JoinResponse>> SendRegistration(JoinRequest request)
        {
            var response = await participateRequestService.SendJoinRequest(request, UserID, Constants.RequestType.Register);
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
        public async Task<ActionResult<RequestListResponse>> RequestList([FromQuery]ListRequestFilterRequest request)
        {
            var response = await participateRequestService.GetRequestList(request,UserID);
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