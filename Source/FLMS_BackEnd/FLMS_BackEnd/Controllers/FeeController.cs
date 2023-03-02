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
    public class FeeController : BaseApiController
    {
        private readonly FeeService feeService;

        public FeeController(FeeService feeService)
        {
            this.feeService = feeService;
        }

        [HttpGet("[action]")]
        public async Task<ActionResult<LeagueFeeResponse>> GetLeagueFees(int LeagueId)
        {
            var response = await feeService.GetListLeagueFee(LeagueId);
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
