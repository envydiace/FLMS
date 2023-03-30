using System.Data;

namespace FLMS_BackEnd.Services
{
    public interface ExportService
    {
        Task<DataTable> ExportPlayer();
        Task<DataTable> ExportLeagueSchedule(int LeagueId);
    }
}
