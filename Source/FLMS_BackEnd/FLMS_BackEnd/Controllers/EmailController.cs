using FLMS_BackEnd.Request;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmailController : BaseApiController
    {
        private readonly IMailService mailService;
        public EmailController(IMailService mailService)
        {
            this.mailService = mailService;
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Send([FromForm] MailRequest request)
        {
                bool result = await mailService.SendEmailAsync(request, new CancellationToken());
                if (result)
                {
                    return Ok("Mail with attachment has successfully been sent.");
                }
                else
                {
                    return StatusCode(StatusCodes.Status500InternalServerError, "An error occured. The Mail with attachment could not be sent.");
                }
        }
    }
}
