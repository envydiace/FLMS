using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class MatchStatisticServiceImpl : BaseService, MatchStatisticService
    {
        private readonly MatchStatisticRepository matchStatisticRepository;
        private readonly MatchRepository matchRepository;

        public MatchStatisticServiceImpl(MatchStatisticRepository matchStatisticRepository, MatchRepository matchRepository)
        {
            this.matchStatisticRepository = matchStatisticRepository;
            this.matchRepository = matchRepository;
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

        public async Task<UpdateMatchStatResponse> UpdateMatchStatistic(UpdateMatchStatRequest request, int UserId)
        {
            var match = await matchRepository.FindByCondition(m => m.MatchId == request.MatchId).Include(m=>m.League).FirstOrDefaultAsync();
            if(match == null)
            {
                return new UpdateMatchStatResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-01"
                };
            }
            if (match.IsFinish)
            {
                return new UpdateMatchStatResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-02"
                };
            }
            if (match.League.UserId != UserId)
            {
                return new UpdateMatchStatResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-03"
                };
            }

            List<MatchStat> matchStats = await matchStatisticRepository.FindByCondition(m=>m.MatchId == request.MatchId).ToListAsync();
            var home = matchStats.FirstOrDefault(m => m.IsHome);
            if(home == null)
            {
                MatchStat statHome = mapper.Map<MatchStat>(request.Home);
                statHome.MatchId = request.MatchId;
                statHome.IsHome = true;
                bool result = await matchStatisticRepository.CreateAsync(statHome);
                if (!result)
                {
                    return new UpdateMatchStatResponse
                    {
                        Success = false,
                        MessageCode = "ER-MA-04"
                    };
                }
            }
            else
            {
                MatchStat statHome = mapper.Map<MatchStat>(request.Home);
                statHome.MatchId = request.MatchId;
                statHome.IsHome = true;
                statHome.MatchStatId = home.MatchStatId;
                MatchStat result = await matchStatisticRepository.UpdateAsync(statHome);
                if(result == null)
                {
                    return new UpdateMatchStatResponse
                    {
                        Success = false,
                        MessageCode = "ER-MA-04"
                    };
                }
            }
            var away = matchStats.FirstOrDefault(m => !m.IsHome);
            if(away == null)
            {
                MatchStat statAway = mapper.Map<MatchStat>(request.Away);
                statAway.MatchId = request.MatchId;
                statAway.IsHome = false;
                bool result = await matchStatisticRepository.CreateAsync(statAway);
                if (!result)
                {
                    return new UpdateMatchStatResponse
                    {
                        Success = false,
                        MessageCode = "ER-MA-04"
                    };
                }
            }
            else
            {
                MatchStat statAway = mapper.Map<MatchStat>(request.Away);
                statAway.MatchId = request.MatchId;
                statAway.IsHome = false;
                statAway.MatchStatId = away.MatchStatId;
                MatchStat result = await matchStatisticRepository.UpdateAsync(statAway);
                if (result == null)
                {
                    return new UpdateMatchStatResponse
                    {
                        Success = false,
                        MessageCode = "ER-MA-04"
                    };
                }
            }
            return new UpdateMatchStatResponse
            {
                Success = true,
                MessageCode = "ER-MA-05"
            };
        }
    }
}
