using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Repositories;
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
    }
}
