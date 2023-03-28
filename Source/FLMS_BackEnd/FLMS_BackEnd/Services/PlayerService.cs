using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Services
{
    public interface PlayerService
    {
        Task<PlayerResponse> GetPlayerById(int id);
        Task<PlayerResponse> GetPlayerByNickname(string nickname);
        Task<ListPlayerSearchResponse> GetListPlayerByClubIdWithSearch(ListPlayerByClubRequest request);
        Task<CreateResponse> CreatePlayer(CreatePlayerRequest request, int UserId);
        Task<ListPlayerResponse> GetListPlayerFilter(ListPlayerFilterRequest request);
        Task<DeletePlayerResponse> DeletePlayer(int id, int UserId);
        Task<UpdatePlayerResponse> UpdatePlayer(UpdatePlayerRequest request, int UserId);
        Task<DeletePlayerClubResponse> DeletePlayerClub(DeletePlayerClubRequest request, int UserId);
    }
}
