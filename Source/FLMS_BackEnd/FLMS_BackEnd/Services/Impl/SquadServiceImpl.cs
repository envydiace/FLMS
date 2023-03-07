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
    }
}
