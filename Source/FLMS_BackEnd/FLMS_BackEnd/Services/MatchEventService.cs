using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Services
{
    public interface MatchEventService
    {
        public Task<List<MatchEventDTO>> GetMatchEvent(int matchId);
    }
}
