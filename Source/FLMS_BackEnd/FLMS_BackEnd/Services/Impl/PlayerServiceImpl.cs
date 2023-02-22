using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class PlayerServiceImpl : BaseService, PlayerService
    {
        private readonly PlayerRepository playerRepository;
        private readonly PlayerClubRepository playerClubRepository;

        public PlayerServiceImpl(PlayerRepository playerRepository, PlayerClubRepository playerClubRepository)
        {
            this.playerRepository = playerRepository;
            this.playerClubRepository = playerClubRepository;
        }
        public async Task<PlayerResponse> GetPlayerById(int id)
        {
            var player = await playerRepository.FindByCondition(p => p.PlayerId == id).FirstOrDefaultAsync();
            if (player == null)
            {
                return new PlayerResponse
                {
                    Success = false,
                    MessageCode = "ER-PL-02"
                };
            }
            return new PlayerResponse
            {
                Success = true,
                PlayerInfo = mapper.Map<PlayerDTO>(player)
            };
        }

        public async Task<CreateResponse> CreatePlayer(CreatePlayerRequest request, int UserId)
        {
            Player player = mapper.Map<Player>(request);
            bool result = await playerRepository.CreateAsync(player);
            return result ?
                new CreateResponse { Success = true, MessageCode = "MS-PL-01" }
                : new CreateResponse { Success = false, MessageCode = "ER-PL-01" };
        }


    }
}
