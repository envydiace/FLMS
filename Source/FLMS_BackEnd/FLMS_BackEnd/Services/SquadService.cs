using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface SquadService
    {
        public Task<MatchSquadResponse> GetMatchSquad(int matchId);
        public Task<SquadResponse> GetSquadById(int squadId);
        public Task<SquadResponse> GetSquadInMatch(SquadInMatchRequest request);
        public Task<List<PlayerSquadPositionDTO>> GetUnsquadPlayer(int squadId);
        public Task<List<PlayerSquadPositionDTO>> GetMatchPlayers(int matchId);
        public Task<AddPositionResponse> AddSquadPosition(AddPositionRequest request, int userId);
        public Task<RemovePositionResponse> RemoveSquadPosition(int squadPositionId, int userId);
    }
}
