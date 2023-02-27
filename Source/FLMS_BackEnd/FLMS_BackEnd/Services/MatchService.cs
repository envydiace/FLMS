using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
namespace FLMS_BackEnd.Services
{
    public interface MatchService
    {
        Task<LeagueScheduleResponse> GetLeagueSchedule(LeagueScheduleRequest request);
    }
}
