using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface ClubService
    {
        Task<ClubResponse> GetClubById(int id);
        Task<CreateResponse> CreateClub(CreateClubRequest request, int UserId);
        Task<ListClubResponse> GetListClubFilter(ListClubFilterRequest request);
        Task<List<ClubByUserDTO>> GetListClubByUser(int userId);
        Task<UpdateClubResponse> UpdateClub(UpdateClubRequest request);
        Task<DeleteClubResponse> DeleteClub(int id, int userId);
    }
}
