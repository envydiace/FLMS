using FLMS_BackEnd.Services;
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
    }
}
