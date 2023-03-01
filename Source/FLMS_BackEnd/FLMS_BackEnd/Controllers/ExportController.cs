using ClosedXML.Excel;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExportController : BaseApiController
    {
        private readonly PlayerService playerService;
        public ExportController(PlayerService playerService)
        {
            this.playerService = playerService;
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> ExporDataToFile()
        {
            var players = await playerService.ExportPlayer();
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add(players);
                using var stream = new MemoryStream();
                workbook.SaveAs(stream);
                var content = stream.ToArray();
                return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "Grid.xlsx");
            }
        }
    }
}
