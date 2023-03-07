using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface SquadService
    {
        public Task<MatchSquadResponse> GetMatchSquad(int matchId)
;    }
}
