using ClosedXML.Excel;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Numerics;

namespace FLMS_BackEnd.Services.Impl
{
    public class PlayerServiceImpl : BaseService, PlayerService
    {
        private readonly PlayerRepository playerRepository;
        private readonly PlayerClubRepository playerClubRepository;
        private readonly ClubRepository clubRepository;

        public PlayerServiceImpl(PlayerRepository playerRepository, PlayerClubRepository playerClubRepository, ClubRepository clubRepository)
        {
            this.playerRepository = playerRepository;
            this.playerClubRepository = playerClubRepository;
            this.clubRepository = clubRepository;
        }
        public async Task<PlayerResponse> GetPlayerById(int id)
        {
            var player = await playerRepository.FindByCondition(p => p.PlayerId == id)
                .Include(player => player.PlayerClubs)
                .ThenInclude(pc => pc.Club)
                .FirstOrDefaultAsync();
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
            var c = await clubRepository.FindByCondition(c => c.ClubId == request.ClubId).FirstOrDefaultAsync();
            if (c == null)
            {
                return new CreateResponse { Success = false, MessageCode = "ER-CL-02" };
            }
            if (c.UserId != UserId)
            {
                return new CreateResponse { Success = false, MessageCode = "ER-CL-08" };
            }
            var p = await GetPlayerByNickname(request.NickName);
            if (p.PlayerInfo != null)
            {
                if (p.PlayerInfo.PlayerClubs.FirstOrDefault(pc => pc.ClubId
                == request.ClubId) != null)
                {
                    return new CreateResponse { Success = false, MessageCode = "ER-PL-05" };
                }
                PlayerClub playerClub = new PlayerClub
                {
                    ClubId = request.ClubId,
                    Number = request.Number,
                    PlayerId = p.PlayerInfo.PlayerId
                };
                bool resultClub = await playerClubRepository.CreateAsync(playerClub);
                return resultClub ?
                new CreateResponse { Success = true, MessageCode = "MS-PL-01" }
                : new CreateResponse { Success = false, MessageCode = "ER-PL-01" };
            }
            Player player = mapper.Map<Player>(request);
            PlayerClub pc = new PlayerClub
            {
                ClubId = request.ClubId,
                Number = request.Number
            };
            player.PlayerClubs.Add(pc);
            bool result = await playerRepository.CreateAsync(player);
            return result ?
                new CreateResponse { Success = true, MessageCode = "MS-PL-01" }
                : new CreateResponse { Success = false, MessageCode = "ER-PL-01" };
        }

        public async Task<ListPlayerResponse> GetListPlayerFilter(ListPlayerFilterRequest request)
        {
            var players = await playerRepository.FindByCondition(player =>
            ((request.searchPlayerName == null || request.searchPlayerName == "" || player.Name.StartsWith(request.searchPlayerName)
            || player.NickName.StartsWith(request.searchPlayerName))
            && (player.PlayerClubs.FirstOrDefault(playerClub => playerClub.ClubId == request.clubId) != null))
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
            var player = await playerRepository.FindByCondition(p => p.PlayerId == request.PlayerId)
                    .Include(p => p.PlayerClubs)
                    .ThenInclude(pc => pc.Club)
                    .FirstOrDefaultAsync();
            if (player == null)
            {
                return new UpdatePlayerResponse { Success = false, MessageCode = "ER-PL-02" };
            }
            var playerClub = player.PlayerClubs.FirstOrDefault(pc => pc.ClubId == request.ClubId);
            if (playerClub == null)
            {
                return new UpdatePlayerResponse
                {
                    Success = false,
                    MessageCode = "ER-PL-06"
                };
            }
            if (playerClub.Club == null || playerClub.Club.UserId != UserId)
            {
                return new UpdatePlayerResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-08"
                };
            }
            playerClub.Number = request.Number;
            Player updatedPlayer = mapper.Map<Player>(request);
            updatedPlayer.PlayerClubs = player.PlayerClubs;
            updatedPlayer.NickName = player.NickName;
            updatedPlayer.Avatar = request.Avatar != null ? request.Avatar : player.Avatar;
            Player result = await playerRepository.UpdateAsync(updatedPlayer);
            if (result != null)
            {
                return new UpdatePlayerResponse { Success = true, MessageCode = "MS-PL-03" };
            }
            return new UpdatePlayerResponse { Success = false, MessageCode = "ER-PL-03" };

        }

        public async Task<PlayerResponse> GetPlayerByNickname(string nickname)
        {
            var player = await playerRepository.FindByCondition(p => p.NickName.Equals(nickname))
                .Include(player => player.PlayerClubs).FirstOrDefaultAsync();
            if (player == null)
            {
                return new PlayerResponse
                {
                    Success = true,
                    PlayerInfo = null
                };
            }
            return new PlayerResponse
            {
                Success = true,
                PlayerInfo = mapper.Map<PlayerDTO>(player)
            };
        }

        public async Task<ListPlayerSearchResponse> GetListPlayerByClubIdWithSearch(ListPlayerByClubRequest request)
        {
            var players = await playerClubRepository.FindByCondition(playerClub => (request.searchPlayerName == null || request.searchPlayerName == ""
            || playerClub.Player.Name.ToLower().Contains(request.searchPlayerName.ToLower()))
            && (playerClub.ClubId == request.clubId))
                .Include(p => p.Player).ToListAsync();
            int total = players.Count;
            var result = mapper.Map<List<PlayerSearchDTO>>(players.ToList());
            return new ListPlayerSearchResponse
            {
                Success = true,
                Players = result
            };
        }

        public async Task<DeletePlayerClubResponse> DeletePlayerClub(DeletePlayerClubRequest request, int UserId)
        {
            var playerClub = await playerClubRepository.FindByCondition(pClub
                => pClub.PlayerId == request.PlayerId && pClub.ClubId == request.ClubId).FirstOrDefaultAsync();
            if (playerClub == null)
            {
                return new DeletePlayerClubResponse
                {
                    Success = false,
                    MessageCode = "ER-PL-02"
                };
            }
            PlayerClub result = await playerClubRepository.DeleteAsync(playerClub);
            if (result != null)
            {
                return new DeletePlayerClubResponse
                {
                    Success = true,
                    MessageCode = "MS-PL-02",
                    PlayerClub = mapper.Map<PlayerClubDTO>(result)
                };
            }
            return new DeletePlayerClubResponse { Success = false, MessageCode = "ER-PL-04" };
        }

        public async Task<GetPlayerByClubManagerResponse> GetPlayerByClubManager(GetPlayerByClubManagerRequest request, int UserId)
        {
            var player = await playerRepository.FindByCondition(p => p.PlayerId == request.PlayerId)
                .Include(player => player.PlayerClubs)
                .ThenInclude(pc => pc.Club)
                .FirstOrDefaultAsync();
            if (player == null)
            {
                return new GetPlayerByClubManagerResponse
                {
                    Success = false,
                    MessageCode = "ER-PL-02"
                };
            }
            var playerClub = player.PlayerClubs.FirstOrDefault(pc => pc.ClubId == request.ClubId);
            if (playerClub == null)
            {
                return new GetPlayerByClubManagerResponse
                {
                    Success = false,
                    MessageCode = "ER-PL-06"
                };
            }
            if (playerClub.Club == null || playerClub.Club.UserId != UserId)
            {
                return new GetPlayerByClubManagerResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-08"
                };
            }
            var playerInfo = mapper.Map<PlayerByManagerDTO>(player);
            playerInfo.ClubId = playerClub.ClubId;
            playerInfo.ClubName = playerClub.Club.ClubName;
            playerInfo.ClubLogo = playerClub.Club.Logo;
            playerInfo.Number = playerClub.Number;
            return new GetPlayerByClubManagerResponse
            {
                Success = true,
                PlayerInfo = playerInfo
            };
        }
    }
}
