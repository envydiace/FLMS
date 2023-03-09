using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class SquadServiceImpl : BaseService, SquadService
    {
        private readonly SquadRepository squadRepository;
        private readonly SquadPositionRepository squadPositionRepository;
        private readonly PlayerRepository playerRepository;

        public SquadServiceImpl(SquadRepository squadRepository, SquadPositionRepository squadPositionRepository, PlayerRepository playerRepository)
        {
            this.squadRepository = squadRepository;
            this.squadPositionRepository = squadPositionRepository;
            this.playerRepository = playerRepository;
        }
        public async Task<MatchSquadResponse> GetMatchSquad(int matchId)
        {
            var matchSquad = await squadRepository.FindByCondition(s => s.MatchId == matchId)
                                    .Include(s => s.SquadPositions).ThenInclude(p => p.Player)
                                        .ToListAsync();
            return new MatchSquadResponse
            {
                Success = true,
                Home = mapper.Map<SquadDTO>(matchSquad.FirstOrDefault(s => s.IsHome)),
                Away = mapper.Map<SquadDTO>(matchSquad.FirstOrDefault(s => !s.IsHome))
            };
        }
        public async Task<SquadResponse> GetSquadById(int squadId)
        {
            var squad = await squadRepository.FindByCondition(s => s.SquadId == squadId)
                    .Include(s => s.SquadPositions)
                    .ThenInclude(p => p.Player)
                    .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new SquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-01"
                };
            }
            return new SquadResponse
            {
                Success = true,
                Squad = mapper.Map<SquadDTO>(squad)
            };
        }

        public async Task<SquadResponse> GetSquadInMatch(SquadInMatchRequest request)
        {
            var squad = await squadRepository.FindByCondition(s => s.MatchId == request.MatchId && s.IsHome == request.IsHome)
                        .Include(s => s.SquadPositions)
                        .ThenInclude(p => p.Player)
                        .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new SquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-01"
                };
            }
            return new SquadResponse
            {
                Success = true,
                Squad = mapper.Map<SquadDTO>(squad)
            };
        }

        public async Task<List<PlayerSquadPositionDTO>> GetUnsquadPlayer(int squadId)
        {
            var result = new List<PlayerSquadPositionDTO>();
            var checkSquad = await squadRepository.FindByCondition(s => s.SquadId == squadId)
                            .Include(s => s.Match)
                                .ThenInclude(m => m.Home)
                                    .ThenInclude(h => h.ClubClone)
                            .Include(s => s.Match)
                                .ThenInclude(m => m.Away)
                                    .ThenInclude(a => a.ClubClone)
                            .FirstOrDefaultAsync();
            if (checkSquad != null)
            {
                List<Player> players = await playerRepository.FindByCondition(p =>
                            p.SquadPositions.FirstOrDefault(sp => sp.SquadId == squadId) == null &&
                            p.PlayerClubs.FirstOrDefault(pc =>
                                (checkSquad.IsHome ? checkSquad.Match.Home : checkSquad.Match.Away).ClubClone != null ?
                                pc.ClubId == (checkSquad.IsHome ? checkSquad.Match.Home : checkSquad.Match.Away).ClubClone.ClubId :
                                false
                            ) != null
                            ).ToListAsync();
                result = mapper.Map<List<PlayerSquadPositionDTO>>(players);
            }
            return result;
        }
        public async Task<List<PlayerSquadPositionDTO>> GetMatchPlayers(int matchId)
        {
            var players = await squadPositionRepository.FindByCondition(sp => sp.Squad.MatchId == matchId && sp.PlayerId != null)
                            .Include(sp => sp.Squad)
                            .Include(sp => sp.Player)
                                .Select(sp => sp.Player)
                                    .ToListAsync();
            return mapper.Map<List<PlayerSquadPositionDTO>>(players);
        }
        public async Task<AddPositionResponse> AddSquadPosition(AddPositionRequest request, int userId)
        {
            var position = await squadPositionRepository.FindByCondition(p =>
                        p.SquadPositionId == request.SquadPositionId)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Home)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Away)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                .FirstOrDefaultAsync();
            if (position == null)
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-02"
                };
            }

            if (!this.CheckManagePermission(position, userId))
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-08"
                };
            }

            if (position.PlayerId != null)
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-03"
                };
            }
            var checkValidPlayer = this.GetUnsquadPlayer(position.SquadId).Result.Where(p => p.PlayerId == request.PlayerId).FirstOrDefault();
            if (checkValidPlayer == null)
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-04"
                };
            }
            position.PlayerId = request.PlayerId;
            var result = await squadPositionRepository.UpdateAsync(position);
            if (result != null)
            {
                return new AddPositionResponse
                {
                    Success = true,
                    MessageCode = "MS-SQ-01"
                };
            }
            else
            {
                return new AddPositionResponse
                {
                    Success = true,
                    MessageCode = "ER-SQ-05"
                };
            }
        }
        private bool CheckManagePermission(SquadPosition position, int userId)
        {
            bool isHome = position.Squad.IsHome;
            var clubClone = isHome ? position.Squad.Match.Home.ClubClone : position.Squad.Match.Away.ClubClone;

            if (clubClone == null || clubClone.Club == null || clubClone.Club.UserId != userId)
            {
                return false;
            }
            return true;
        }
        public async Task<RemovePositionResponse> RemoveSquadPosition(int squadPositionId, int userId)
        {
            var position = await squadPositionRepository.FindByCondition(p =>
                    p.SquadPositionId == squadPositionId)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Home)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Away)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                .FirstOrDefaultAsync();
            if (position == null)
            {
                return new RemovePositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-02"
                };
            }

            if (!this.CheckManagePermission(position, userId))
            {
                return new RemovePositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-09"
                };
            }
            if (position.PlayerId == null)
            {
                return new RemovePositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-06"
                };
            }
            position.PlayerId = null;
            var result = await squadPositionRepository.UpdateAsync(position);
            if (result != null)
            {
                return new RemovePositionResponse
                {
                    Success = true,
                    MessageCode = "MS-SQ-02"
                };
            }
            else
            {
                return new RemovePositionResponse
                {
                    Success = true,
                    MessageCode = "ER-SQ-07"
                };
            }
        }
    }
}
