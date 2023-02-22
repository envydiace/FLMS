using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface PlayerService
    {
        Task<PlayerResponse> GetPlayerById(int id);
        Task<CreateResponse> CreatePlayer(CreatePlayerRequest request, int UserId);
        Task<ListPlayerResponse> GetListPlayerFilter(ListPlayerFilterRequest request);
        Task<DeletePlayerResponse> DeletePlayer(int id, int userId);
    }
}
