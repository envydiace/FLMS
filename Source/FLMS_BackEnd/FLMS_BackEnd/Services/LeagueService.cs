using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface LeagueService
    {
        Task<CreateLeagueResponse> CreateLeague(CreateLeagueRequest request, int userId);
        Task<ListLeagueResponse> GetListLeagueFilters(ListLeagueFilterRequest request);
        Task<LeagueInfoResponse> GetLeagueInfo(int leagueId);
        Task<List<LeagueByUserDTO>> GetListLeagueByUser(int userId);
        Task<TopEventResponse> GetLeagueTopEvent(int leagueId);
        Task<TopLeaguePrizeResponse> GetLeagueTopPrize(int size);
        Task<LeagueLeagueStatisticResponse> GetLeagueStatisticTypeLeague(int leagueId);
        Task<LeagueKnockOutStatisticResponse> GetLeagueStatisticTypeKO(int leagueId);
        Task<DeleteLeagueResponse> DeleteLeague(int leagueId, int userId);
    }
}
