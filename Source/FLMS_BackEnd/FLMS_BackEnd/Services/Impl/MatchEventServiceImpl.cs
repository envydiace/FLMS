using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Repositories;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class MatchEventServiceImpl : BaseService, MatchEventService
    {
        private readonly MatchEventRepository matchEventRepository;

        public MatchEventServiceImpl(MatchEventRepository matchEventRepository)
        {
            this.matchEventRepository = matchEventRepository;
        }

        public async Task<List<MatchEventDTO>> GetMatchEvent(int matchId)
        {
            var matchEvents = await matchEventRepository.FindByCondition(e => e.MatchId == matchId)
                                    .Include(e => e.Main)
                                    .Include(e => e.Sub)
                                        .ToListAsync();
            return mapper.Map<List<MatchEventDTO>>(matchEvents);
        }
    }
}
