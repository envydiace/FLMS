using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class MatchStatisticServiceImpl : BaseService, MatchStatisticService
    {
        private readonly MatchStatisticRepository matchStatisticRepository;

        public MatchStatisticServiceImpl(MatchStatisticRepository matchStatisticRepository)
        {
            this.matchStatisticRepository = matchStatisticRepository;
        }

        public async Task<MatchStatisticResponse> GetMatchStatistic(int matchId)
        {
            List<MatchStat> matchStats = await matchStatisticRepository.FindByCondition(ms => ms.MatchId == matchId).ToListAsync();
            MatchStatisticResponse response = new MatchStatisticResponse();
            var home = matchStats.FirstOrDefault(m => m.IsHome);
            var away = matchStats.FirstOrDefault(m => !m.IsHome);
            response.Home = home != null ? mapper.Map<StatisticDTO>(home) : new StatisticDTO { MatchId = matchId , IsHome = true };
            response.Away = away != null ? mapper.Map<StatisticDTO>(away) : new StatisticDTO { MatchId = matchId , IsHome = false };
            response.Success = true;
            return response;
        }
    }
}
