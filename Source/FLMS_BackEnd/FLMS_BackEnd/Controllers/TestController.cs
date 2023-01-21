using FLMS_BackEnd.Models;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    public class TestController : BaseApiController
    {
        private readonly UserService userService;
        
        public TestController(UserService userService)
        {
            this.userService = userService;
        }
        [HttpGet("[action]")]
        public async Task<IActionResult> test(string username)
        {
            User u = await userService.GetUserByUsername(username);
            if (u != null)
            {
                return Ok(new TestResponse { user = u, Success = true, Message = "Success" });
            } 
            else
            {
                return NotFound(new TestResponse { Message = "User not found" });
            }
        }
    }
}
