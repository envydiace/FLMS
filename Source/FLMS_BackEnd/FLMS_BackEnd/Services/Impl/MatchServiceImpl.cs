using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class MatchServiceImpl : BaseService, MatchService
    {
        private readonly MatchRepository matchRepository;

        public MatchServiceImpl(MatchRepository matchRepository)
        {
            this.matchRepository = matchRepository;
        }

        public async Task<LeagueScheduleResponse> GetLeagueSchedule(LeagueScheduleRequest request)
        {
            List<Match> matches = await matchRepository.FindByCondition
            (m =>
                (m.LeagueId == request.LeagueId) &&
                (request.From == null || m.MatchDate.CompareTo(request.From.GetValueOrDefault()) >= 0) &&
                (request.To == null || m.MatchDate.CompareTo(request.To.GetValueOrDefault()) <= 0) &&
                (request.SearchClubName == null || "".Equals(request.SearchClubName) ||
                    (m.Home.ClubClone != null && m.Home.ClubClone.Club != null &&
                        m.Home.ClubClone.Club.ClubName.StartsWith(request.SearchClubName)) ||
                    (m.Away.ClubClone != null && m.Away.ClubClone.Club != null &&
                        m.Away.ClubClone.Club.ClubName.StartsWith(request.SearchClubName))
                )
            )
            .Include(m => m.League)
            .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
            .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
            .OrderBy(m => m.MatchDate)
            .ToListAsync();
            return new LeagueScheduleResponse
            {
                Success = true,
                listMatch = mapper.Map<List<MatchDTO>>(matches)
            };
        }

        public async Task<MatchInfoResponse> GetMatchInfo(int matchId)
        {
            var match = await matchRepository.FindByCondition(m => m.MatchId == matchId)
                        .Include(m => m.League)
                        .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                        .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                        .FirstOrDefaultAsync();
            if (match == null)
            {
                return new MatchInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-01"
                };
            }
            return new MatchInfoResponse
            {
                Success = true,
                Match = mapper.Map<MatchDTO>(match)
            };
        }
    }
}

