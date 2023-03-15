using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Asn1.Ocsp;

namespace FLMS_BackEnd.Services.Impl
{
    public class MatchServiceImpl : BaseService, MatchService
    {
        private readonly MatchRepository matchRepository;
        private readonly MatchEventRepository matchEventRepository;

        public MatchServiceImpl(MatchRepository matchRepository, MatchEventRepository matchEventRepository)
        {
            this.matchRepository = matchRepository;
            this.matchEventRepository = matchEventRepository;
        }
        public async Task<ClubScheduleResponse> GetClubSchedule(int ClubId)
        {
            List<Match> matches = await matchRepository.FindByCondition
            (m => (m.HomeId == ClubId) || (m.AwayId == ClubId))
            .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
            .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
            .Include(m => m.League)
            .OrderBy(m => m.MatchDate)
            .ToListAsync();
            var listmatches = mapper.Map<List<MatchClubDTO>>(matches);
            foreach (MatchClubDTO matchClub in listmatches)
            {
                var match = await matchRepository.FindByCondition(m => m.MatchId == matchClub.MatchId)
                                .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                                .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                                .FirstOrDefaultAsync();
                if (matchClub.HomeId == ClubId)
                {
                    matchClub.HA = "Home";
                    if (match != null && match.Away != null && match.Away.ClubClone != null)
                    {
                        if (match.Away.ClubClone.Club != null)
                        {
                            matchClub.Against = match.Away.ClubClone.Club.ClubName.Trim();
                        }
                        else
                        {
                            matchClub.Against = match.Away.ClubClone.ClubCloneKey.Trim();
                        }
                    }
                }
                else
                {
                    matchClub.HA = "Away";
                    if (match != null && match.Home != null && match.Home.ClubClone != null)
                    {
                        if (match.Home.ClubClone.Club != null)
                        {
                            matchClub.Against = match.Home.ClubClone.Club.ClubName;
                        }
                        else
                        {
                            matchClub.Against = match.Home.ClubClone.ClubCloneKey;
                        }
                    }
                }
                matchClub.Stadium = null;
                matchClub.Round = null;
            }
            return new ClubScheduleResponse
            {
                Success = true,
                listMatch = listmatches
            };
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
                        .Include(m => m.MatchStats)
                        .FirstOrDefaultAsync();
            if (match == null)
            {
                return new MatchInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-01"
                };
            }
            var result = mapper.Map<MatchDTO>(match);
            //var listGoals = await matchEventRepository.FindByCondition(e => 
            //    e.MatchId == matchId && 
            //        (e.EventType.Equals(Constants.MatchEventType.Goal.ToString()) ||
            //        e.EventType.Equals(Constants.MatchEventType.OwnGoal.ToString()))
            //        )
            //.ToListAsync();
            //result.Home.Score = listGoals.Where(e => e.IsHome).Count();
            //result.Away.Score = listGoals.Where(e => !e.IsHome).Count();
            if (match.IsFinish)
            {
                var homeStats = match.MatchStats.FirstOrDefault(ms => ms.IsHome);
                result.Home.Score = homeStats != null ? homeStats.Score : 0;
                var awayStats = match.MatchStats.FirstOrDefault(ms => !ms.IsHome);
                result.Away.Score = awayStats != null ? awayStats.Score : 0;
            }
            return new MatchInfoResponse
            {
                Success = true,
                Match = result
            };
        }
        public async Task<FinishMatchResponse> FinishMatch(int matchId, int userId)
        {
            var match = await matchRepository.FindByCondition(m => m.MatchId == matchId)
                                .Include(m => m.League)
                                .Include(m => m.MatchStats)
                                .Include(m => m.Home).ThenInclude(h => h.ClubClone)
                                .Include(m => m.Away).ThenInclude(a => a.ClubClone)
                                    .FirstOrDefaultAsync();
            if (match == null)
            {
                return new FinishMatchResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-01"
                };
            }

            if (match.League.UserId != userId)
            {
                return new FinishMatchResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (match.IsFinish)
            {
                return new FinishMatchResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-02"
                };
            }
            if (match.Home.ClubClone == null ||
                match.Home.ClubClone.ClubId == null ||
                match.Away.ClubClone == null ||
                match.Away.ClubClone.ClubId == null
                )
            {
                return new FinishMatchResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-06"
                };
            }
            else
            {
                //TODO: Calculate clubclone
                var listGoals = await matchEventRepository.FindByCondition(e =>
                    e.MatchId == matchId &&
                        (e.EventType.Equals(Constants.MatchEventType.Goal.ToString()) ||
                        e.EventType.Equals(Constants.MatchEventType.OwnGoal.ToString()))
                        )
                .ToListAsync();
                var homeScore = listGoals.Where(e => e.IsHome).Count();
                var awayScore = listGoals.Where(e => !e.IsHome).Count();

                var homeClubClone = match.Home.ClubClone;
                homeClubClone.GoalsFor = homeScore;
                homeClubClone.GoalsAgainst = awayScore;

                var awayClubClone = match.Away.ClubClone;
                awayClubClone.GoalsFor = awayScore;
                awayClubClone.GoalsAgainst = homeScore;
                if (homeScore > awayScore)
                {
                    homeClubClone.Won++;
                    awayClubClone.Loss++;
                }
                else if (homeScore < awayScore)
                {
                    homeClubClone.Loss++;
                    awayClubClone.Won++;
                }
                else
                {
                    homeClubClone.Draw++;
                    awayClubClone.Draw++;
                }

                var homeStats = match.MatchStats.FirstOrDefault(ms => ms.IsHome);
                if (homeStats != null)
                {
                    homeStats.Score = homeScore;
                }
                else
                {
                    match.MatchStats.Add(new MatchStat { Score = homeScore, IsHome = true });
                }
                var awayStats = match.MatchStats.FirstOrDefault(ms => !ms.IsHome);
                if (awayStats != null)
                {
                    awayStats.Score = awayScore;
                }
                else
                {
                    match.MatchStats.Add(new MatchStat { Score = awayScore, IsHome = false });
                }
                match.IsFinish = true;
                var result = await matchRepository.UpdateAsync(match);
                if (result != null)
                {
                    return new FinishMatchResponse
                    {
                        Success = true,
                        MessageCode = "MS-MA-01"
                    };
                }
                else
                {
                    return new FinishMatchResponse
                    {
                        Success = false,
                        MessageCode = "ER-MA-08"
                    };
                }
            }
        }
    }
}

