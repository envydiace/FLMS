using FLMS_BackEnd.Models;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
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
        [Authorize(Roles = Constants.Role.LEAGUE_MANAGER)]
        public async Task<ActionResult<BaseResponse>> TestAuthen()
        {
            
            return Ok(UserID);
        }
        [HttpGet("[action]")]
        public async Task<ActionResult<BaseResponse>> TestTole()
        {

            return Ok(
                Enum.GetValues(typeof(Constants.SystemRole))
                .Cast<Constants.SystemRole>()
                .Select(v => v.ToString())
                .ToList()
                );
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> GetMatrix(int number)
        {

            return Ok(MethodUtils.GetLeagueMatchMatrix(number));
        }
        [HttpGet("[action]")]
        public async Task<IActionResult> GetTree(int number)
        {

            return Ok(MethodUtils.GetKoList(number));
        }
    }
}
