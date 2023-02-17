using AutoMapper;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class ClubServiceImpl :BaseService, ClubService
    {
        
        private readonly ClubRepository clubRepository;

        public ClubServiceImpl(ClubRepository clubRepository)
        {
            this.clubRepository = clubRepository;
        }
        public async Task<ClubResponse> GetClubById(int id)
        {
            Club club = await clubRepository.FindByCondition(c => c.ClubId == id).FirstOrDefaultAsync();
            if (club == null)
            {
                return new ClubResponse
                {
                    Success = false,
                    Message = "Club Not Found!"
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
                new CreateResponse { Success = true, Message = "Create Success!" }
                : new CreateResponse { Success = false, Message = "Create Fail!" };
        }
    }
}
