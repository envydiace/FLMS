using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface PlayerService
    {
        Task<PlayerResponse> GetPlayerById(int id);
        Task<CreateResponse> CreatePLayer(CreatePlayerRequest request, int UserId);
    }
}
