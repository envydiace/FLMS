using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface FeeService
    {
        Task<LeagueFeeResponse> GetListLeagueFee(int LeagueId);
    }
}
