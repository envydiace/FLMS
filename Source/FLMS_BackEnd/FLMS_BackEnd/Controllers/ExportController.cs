using ClosedXML.Excel;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FLMS_BackEnd.Utils;
namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExportController : BaseApiController
    {
        private readonly ExportService exportService;
        public ExportController(ExportService exportService)
        {
            this.exportService = exportService;
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> ExporPlayerList()
        {
            var players = await exportService.ExportPlayer();
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add(players);
                using var stream = new MemoryStream();
                workbook.SaveAs(stream);
                var content = stream.ToArray();
                return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "Players.xlsx");
            }
        }
        [HttpGet("[action]/{LeagueId}")]
        public async Task<IActionResult> ExporLeagueSchedule(int LeagueId)
        {
            var schedule = await exportService.ExportLeagueSchedule(LeagueId);
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add(schedule);
                MethodUtils.SetColumnWidths(worksheet);
                using var stream = new MemoryStream();
                workbook.SaveAs(stream);
                var content = stream.ToArray();
                return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "LeagueSchedule_"+DateTime.Today.ToString("yyyy_MM_dd")+".xlsx");
            }
        }
    }
}
