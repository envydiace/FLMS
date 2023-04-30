using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface ClubService
    {
        Task<ClubResponse> GetClubById(int id, int userId);
        Task<CreateResponse> CreateClub(CreateClubRequest request, int UserId);
        Task<ListClubResponse> GetListClubFilter(ListClubFilterRequest request);
        Task<List<ClubByUserDTO>> GetListClubByUser(int userId);
        Task<UpdateClubResponse> UpdateClub(UpdateClubRequest request);
        Task<DeleteClubResponse> DeleteClub(int id, int userId);
        Task<List<ClubHistoryDTO>> GetClubLeagueHistory(int clubId);
        Task<List<IncomingMatchDTO>> GetIncomingMatch(int userId);
        Task<ClubHistoryResponse> GetClubHistory(int clubId);
        Task<ClubUpdateInfoResponse> GetClubUpdateInfo(int clubId);
        Task<ClubUpdateInfoResponse> UpdateClubInfo(UpdateClubInfoRequest request, int UserId);
        Task<List<ClubStatsInfoDTO>> GetTopMostWinClubs(int numberOfClub);
    }
}
