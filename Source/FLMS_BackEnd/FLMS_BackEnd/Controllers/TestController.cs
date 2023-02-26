using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

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
        public async Task<IActionResult> GetListMatches(int number)
        {
            List<ClubCloneDTO> list = new List<ClubCloneDTO>();
            for (int i = 0; i < number; i++)
            {
                list.Add(new ClubCloneDTO { ClubCloneKey = "C" + (i + 1) });
            }
            List<string> listTeam = list.Select(x => x.ClubCloneKey != null ? x.ClubCloneKey : "Bye").ToList();
            return Ok(MethodUtils.GetListMatches(listTeam));
        }
        [HttpGet("[action]")]
        public async Task<IActionResult> GetTree(int number)
        {
            return Ok(MethodUtils.GetKoList(number));
        }
    }
}
