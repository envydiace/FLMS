using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface MatchStatisticService
    {
        Task<MatchStatisticResponse> GetMatchStatistic(int matchId);
    }
}
