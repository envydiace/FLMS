using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface LeagueService
    {
        Task<CreateLeagueResponse> CreateLeague(CreateLeagueRequest request, int userId);
        Task<ListLeagueResponse> GetListLeagueFilters(ListLeagueFilterRequest request);
    }
}
