using FLMS_BackEnd.DTO;
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

        public SquadServiceImpl(SquadRepository squadRepository, SquadPositionRepository squadPositionRepository)
        {
            this.squadRepository = squadRepository;
            this.squadPositionRepository = squadPositionRepository;
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

        public Task<List<PlayerSquadPositionDTO>> GetUnsquadPlayer(int squadId)
        {
            var result = new List<PlayerSquadPositionDTO>();
            //var checkHome = 
            //var squad = await squadRepository.FindByCondition(s => s.SquadId == squadId)
            //                    .Include(s => s.Match).ThenInclude(m => m.)
            //                    .FirstOrDefaultAsync();
            //if(squad != null)
            //{
            //    var node = squad.IsHome ? squad.Match.Home : squad.Match.Away;
            //    var clubClone = node.ClubClone;
            //    if (clubClone != null && clubClone.Club!=null && clubClone.Club.PlayerClubs!=null)
            //    {
            //        var club = clubClone.Club.PlayerClubs;
                    
            //    }
            //};
            


            return result;
        }
    }
}
