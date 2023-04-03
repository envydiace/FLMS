using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface FeeService
    {
        Task<LeagueFeeResponse> GetListLeagueFee(int LeagueId);
        Task<FeeDetailResponse> GetLeagueFeeDetail(int LeagueFeeId);
        Task<FeeDetailResponse> UpdateFeeDetail(FeeDetailRequest feeDetailRequest, int UserId);
        Task<LeagueFeeClubResponse> GetListLeagueFeeEachClub(int leagueId, int clubId);
        Task<AddLeagueFeeResponse> AddListLeagueFee(AddLeagueFeeRequest request, int UserId);
        Task<DeleteLeagueFeeResponse> DeleteLeagueFee(int LeagueFeeId, int UserId);
    }
}
