using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface MatchEventService
    {
        public Task<List<MatchEventDTO>> GetMatchEvent(int matchId);
        public Task<AddMatchEventResponse> AddEvent(AddMatchEventRequest request, int userId);
    }
}
