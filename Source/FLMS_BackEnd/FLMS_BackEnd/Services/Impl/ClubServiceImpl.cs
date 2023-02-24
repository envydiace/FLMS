using AutoMapper;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class ClubServiceImpl : BaseService, ClubService
    {

        private readonly ClubRepository clubRepository;

        public ClubServiceImpl(ClubRepository clubRepository)
        {
            this.clubRepository = clubRepository;
        }
        public async Task<ClubResponse> GetClubById(int id)
        {
            var club = await clubRepository.FindByCondition(c => c.ClubId == id).Include(c => c.User).FirstOrDefaultAsync();
            if (club == null)
            {
                return new ClubResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-02"
                };
            }
            return new ClubResponse
            {
                Success = true,
                ClubInfo = mapper.Map<ClubDTO>(club)
            };
        }

        public async Task<CreateResponse> CreateClub(CreateClubRequest request, int UserId)
        {
            Club club = mapper.Map<Club>(request);
            club.UserId = UserId;
            bool result = await clubRepository.CreateAsync(club);
            return result ?
                new CreateResponse { Success = true, MessageCode = "MS-CL-02" }
                : new CreateResponse { Success = false, MessageCode = "ER-CL-05" };
        }

        public async Task<ListClubResponse> GetListClubFilter(ListClubFilterRequest request)
        {
            var clubs = await clubRepository.FindByCondition(club =>
            (request.searchClubName == null || request.searchClubName == "" || club.ClubName.StartsWith(request.searchClubName))
                && (request.searchManagerName == null || request.searchManagerName == "" || club.User.FullName.StartsWith(request.searchManagerName))
            ).Include(club => club.User).ToListAsync();
            int total = clubs.Count;
            var result = mapper.Map<List<ClubDTO>>(clubs.Skip((request.page - 1) * request.pageSize).Take(request.pageSize).ToList());
            return new ListClubResponse
            {
                Success = true,
                Clubs = result,
                Total = total
            };
        }

        public async Task<UpdateClubResponse> UpdateClub(UpdateClubRequest request)
        {
            var c = await clubRepository.FindByCondition(club => club.ClubId == request.ClubId).FirstOrDefaultAsync();
            if (c == null)
            {
                return new UpdateClubResponse { Success = false, MessageCode = "ER-CL-02" };
            }
            Club club = mapper.Map<Club>(request);
            club.CreateAt = c.CreateAt;
            club.UserId = c.UserId;
            Club result = await clubRepository.UpdateAsync(club);
            if (result != null)
            {
                return new UpdateClubResponse { Success = true, ClubInfo = this.GetClubById(result.ClubId).Result.ClubInfo };
            }
            return new UpdateClubResponse { Success = false, MessageCode = "ER-CL-06" };
        }

        public async Task<DeleteClubResponse> DeleteClub(int id, int userId)
        {
            //TODO: check number of player in club
            var club = await clubRepository.FindByCondition(club => club.ClubId == id).FirstOrDefaultAsync();
            if (club == null)
            {
                return new DeleteClubResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-02"
                };
            }
            if (club.UserId != userId)
            {
                return new DeleteClubResponse { Success = false, MessageCode = "ER-CL-03" };
            }
            Club result = await clubRepository.DeleteAsync(club);
            if (result != null)
            {
                return new DeleteClubResponse
                {
                    Success = true,
                    MessageCode = "MS-CL-01",
                    Club = mapper.Map<ClubDTO>(result)
                };
            }
            return new DeleteClubResponse { Success = false, MessageCode = "ER-CL-04" };
        }
    }
}
