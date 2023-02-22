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

        public async Task<ListPlayerResponse> GetListPlayerFilter(ListPlayerFilterRequest request)
        {
            var players = await playerRepository.FindByCondition(player =>
            ((request.searchPlayerName == null || request.searchPlayerName == "" || player.Name.StartsWith(request.searchPlayerName)
            || player.NickName.StartsWith(request.searchPlayerName ))
            &&(player.PlayerClubs.FirstOrDefault(playerClub => playerClub.ClubId == request.clubId) != null))
            ).Include(player => player.PlayerClubs).ToListAsync();
            int total = players.Count;
            var result = mapper.Map<List<PlayerDTO>>(players.ToList());
            return new ListPlayerResponse
            {
                Success = true,
                Players = result
            };
        }

        public async Task<DeletePlayerResponse> DeletePlayer(int id, int userId)
        {
            //TODO: check number of player in club
            var player = await playerRepository.FindByCondition(player => player.PlayerId == id).FirstOrDefaultAsync();
            if (player == null)
            {
                return new DeletePlayerResponse
                {
                    Success = false,
                    MessageCode = "ER-PL-02"
                };
            }
            var playerClubs = await playerClubRepository.FindByCondition(p => p.PlayerId == id).ToListAsync();
            if (playerClubs != null)
            {
                foreach (var playerClub in playerClubs)
                {
                    PlayerClub pcresult = await playerClubRepository.DeleteAsync(playerClub);
                }
            }
            Player result = await playerRepository.DeleteAsync(player);
            if (result != null)
            {
                return new DeletePlayerResponse
                {
                    Success = true,
                    MessageCode = "MS-PL-02",
                    Player = mapper.Map<PlayerDTO>(result)
                };
            }
            return new DeletePlayerResponse { Success = false, MessageCode = "ER-PL-04" };
        }

        public async Task<UpdatePlayerResponse> UpdatePlayer(UpdatePlayerRequest request, int UserId)
        {
            var p = await playerRepository.FindByCondition(player => player.PlayerId == request.PlayerId).FirstOrDefaultAsync();
            if (p == null)
            {
                return new UpdatePlayerResponse { Success = false, MessageCode = "ER-PL-02" };
            }
            Player player = mapper.Map<Player>(request);
            Player result = await playerRepository.UpdateAsync(player);
            if (result != null)
            {
                return new UpdatePlayerResponse { Success = true, PlayerInfo = this.GetPlayerById(result.PlayerId).Result.PlayerInfo };
            }
            return new UpdatePlayerResponse { Success = false, MessageCode = "ER-PL-03" };

        }
    }
}
