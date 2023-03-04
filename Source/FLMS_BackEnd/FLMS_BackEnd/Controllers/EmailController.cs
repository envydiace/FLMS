using DocumentFormat.OpenXml.Spreadsheet;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

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

        [HttpPost("[action]")]
        public async Task<IActionResult> SendEmailUsingTemplate(MailDTO welcomeMail)
        {
            // Create MailData object
            MailRequest request = new MailRequest(
                new List<string> { 
                    welcomeMail.Email 
                },
            "Welcome to the MailKit Demo",
                mailService.GetEmailTemplate("Index", welcomeMail));


            bool sendResult = await mailService.SendEmailAsync(request, new CancellationToken());

            if (sendResult)
            {
                return StatusCode(StatusCodes.Status200OK, "Mail has successfully been sent using template.");
            }
            else
            {
                return StatusCode(StatusCodes.Status500InternalServerError, "An error occured. The Mail could not be sent.");
            }
        }
    }
}
