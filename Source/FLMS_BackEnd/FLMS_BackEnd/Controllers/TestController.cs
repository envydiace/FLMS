using FLMS_BackEnd.Models;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    public class TestController : BaseApiController
    {
        private readonly UserService userService;
        
        public TestController(UserService userService)
        {
            this.userService = userService;
        }

        [HttpGet("[action]")]
        [Authorize]
        public async Task<ActionResult<BaseResponse>> TestAuthen()
        {
            return Ok();
        }
    }
}
