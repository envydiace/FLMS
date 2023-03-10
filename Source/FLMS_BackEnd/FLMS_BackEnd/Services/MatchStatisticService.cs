using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface MatchStatisticService
    {
        Task<MatchStatisticResponse> GetMatchStatistic(int matchId);
        Task<UpdateMatchStatResponse> UpdateMatchStatistic(UpdateMatchStatRequest request, int UserId);
    }
}
