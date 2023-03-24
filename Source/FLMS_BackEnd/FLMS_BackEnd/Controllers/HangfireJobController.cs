using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using Hangfire;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HangfireJobController : BaseApiController
    {
        private readonly IHangfireService _hangfireService;
        private readonly IBackgroundJobClient _backgroundJobClient;
        private readonly IRecurringJobManager _recurringJobManager;
        public HangfireJobController(IHangfireService _hangfireService, IBackgroundJobClient backgroundJobClient, IRecurringJobManager _recurringJobManager)
        {
            this._hangfireService = _hangfireService;
            _backgroundJobClient = backgroundJobClient;
            this._recurringJobManager = _recurringJobManager;
        }

        [HttpGet("[action]")]
        public ActionResult AddFireAndForgetJob()
        {
            _backgroundJobClient.Enqueue(() => _hangfireService.AddFireAndForgetJob());
            return Ok();
        }

        [HttpGet("[action]")]
        public ActionResult AddDelayedJob()
        {
            _backgroundJobClient.Schedule(() => _hangfireService.AddDelayedJob(), TimeSpan.FromMinutes(2));
            return Ok();
        }

        [HttpGet("[action]")]
        public ActionResult AddRecurringJob()
        {
            _recurringJobManager.AddOrUpdate("AnnounceMatch", () => _hangfireService.AnnouceMatchIncoming(Constants.MailType.AnnounceMatch), "48 0 * * *" , TimeZoneInfo.Local);
            _recurringJobManager.AddOrUpdate("AnnounceSquad", () => _hangfireService.AnnouceMatchIncoming(Constants.MailType.AnnounceSquad), "48 0 * * *" , TimeZoneInfo.Local);
            return Ok();
        }
    }
}
