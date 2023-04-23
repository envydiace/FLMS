using DocumentFormat.OpenXml.EMMA;
using DocumentFormat.OpenXml.Office2010.Excel;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Asn1.Ocsp;
using System.Globalization;

namespace FLMS_BackEnd.Services.Impl
{
    public class MatchServiceImpl : BaseService, MatchService
    {
        private readonly MatchRepository matchRepository;
        private readonly MatchEventRepository matchEventRepository;
        private readonly ParticipateNodeRepository participateNodeRepository;

        public MatchServiceImpl(MatchRepository matchRepository, MatchEventRepository matchEventRepository, ParticipateNodeRepository participateNodeRepository)
        {
            this.matchRepository = matchRepository;
            this.matchEventRepository = matchEventRepository;
            this.participateNodeRepository = participateNodeRepository;
        }
        public async Task<ClubScheduleResponse> GetClubSchedule(int ClubId)
        {
            var nodes = await participateNodeRepository.FindByCondition(p => p.ClubClone.ClubId == ClubId).ToListAsync();
            if (nodes == null)
            {
                nodes = new List<ParticipateNode>();
            }
            List<Match> lmatches = new List<Match>();
            foreach (var node in nodes)
            {
                var matches = await matchRepository.FindByCondition
                    (m => (m.HomeId == node.ParticipateNodeId) || (m.AwayId == node.ParticipateNodeId))
                    .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                    .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                    .Include(m => m.League)
                    .ToListAsync();
                if (matches != null)
                {
                    lmatches.AddRange(matches);
                }
            }

            var listmatches = mapper.Map<List<MatchClubDTO>>(lmatches.OrderBy(m => m.MatchDate));
            foreach (MatchClubDTO matchClub in listmatches)
            {
                var match = await matchRepository.FindByCondition(m => m.MatchId == matchClub.MatchId)
                                .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                                .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
                                .FirstOrDefaultAsync();
                foreach (var node in nodes)
                {
                    if (matchClub.HomeId == node.ParticipateNodeId)
                    {
                        matchClub.HA = "Home";
                        if (match != null && match.Away != null && match.Away.ClubClone != null)
                        {
                            if (match.Away.ClubClone.Club != null )
                            {
                                matchClub.Against = match.Away.ClubClone.Club.ClubName.Trim();
                                matchClub.Logo = match.Away.ClubClone.Club.Logo;
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
                                matchClub.Against = match.Home.ClubClone.Club.ClubName.Trim();
                                matchClub.Logo = match.Home.ClubClone.Club.Logo;
                            }
                            else
                            {
                                matchClub.Against = match.Home.ClubClone.ClubCloneKey.Trim();
                            }
                        }
                    }
                }
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
            .Include(m => m.MatchStats)
            .OrderBy(m => m.MatchDate)
            .ToListAsync();

            var listMatch = mapper.Map<List<MatchDTO>>(matches);
            listMatch.ForEach(m =>
            {
                var match = matches.Where(x => x.MatchId == m.MatchId).FirstOrDefault();
                if (match != null && match.IsFinish)
                {
                    var homeStats = match.MatchStats.FirstOrDefault(ms => ms.IsHome);
                    m.Home.Score = homeStats != null ? homeStats.Score : 0;
                    var awayStats = match.MatchStats.FirstOrDefault(ms => !ms.IsHome);
                    m.Away.Score = awayStats != null ? awayStats.Score : 0;
                }
            });

            return new LeagueScheduleResponse
            {
                Success = true,
                listMatch = listMatch
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
                homeClubClone.GoalsFor += homeScore;
                homeClubClone.GoalsAgainst += awayScore;

                var awayClubClone = match.Away.ClubClone;
                awayClubClone.GoalsFor += awayScore;
                awayClubClone.GoalsAgainst += homeScore;
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
                switch (MethodUtils.GetLeagueTypeByName(match.League.LeagueType))
                {
                    case Constants.LeagueType.KO:
                        var listNode = await participateNodeRepository.FindByCondition(n =>
                                n.LeagueId == match.LeagueId)
                                .Include(n => n.ClubClone)
                                .ToListAsync();
                        if (listNode.Any(n => n.LeftId == 0 && (n.ClubClone == null || n.ClubClone.ClubId == null)))
                        {
                            return new FinishMatchResponse
                            {
                                Success = false,
                                MessageCode = "ER-MA-14"
                            };
                        }
                        if (homeScore == awayScore)
                        {
                            return new FinishMatchResponse
                            {
                                Success = false,
                                MessageCode = "ER-MA-13"
                            };
                        }
                        var node = listNode.FirstOrDefault(n => n.ParticipateId == match.Home.ParentId);
                        if (node == null)
                        {
                            return new FinishMatchResponse
                            {
                                Success = false,
                                MessageCode = "ER-MA-08"
                            };
                        }
                        node.ClubCloneId = homeScore > awayScore ? match.Home.ClubCloneId : match.Away.ClubCloneId;
                        var r = await participateNodeRepository.UpdateAsync(node);
                        if (r == null)
                        {
                            return new FinishMatchResponse
                            {
                                Success = false,
                                MessageCode = "ER-MA-08"
                            };
                        }
                        break;
                    case Constants.LeagueType.LEAGUE:
                        break;
                    default:
                        return new FinishMatchResponse
                        {
                            Success = true,
                            MessageCode = "ER-MA-08"
                        };
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

        public async Task<UpdateMatchInfoResponse> UpdateMatchInfo(UpdateMatchInfoRequest request, int UserId)
        {
            var dateTime = new DateTime();
            var match = await matchRepository.FindByCondition(m => m.MatchId == request.MatchId)
                .Include(m => m.League).ThenInclude(l => l.User)
                .FirstOrDefaultAsync();
            if (match == null)
            {
                return new UpdateMatchInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-01"
                };
            }
            if (match.League.User.UserId != UserId)
            {
                return new UpdateMatchInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-03"
                };
            }
            if (match.IsFinish)
            {
                return new UpdateMatchInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-02"
                };
            }
            try
            {
                dateTime = DateTime.ParseExact(request.MatchDate.ToString(Constants.DATE_FORMAT) + " " + request.MatchTime
                    , "yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture);
            }
            catch (FormatException)
            {
                return new UpdateMatchInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-12"
                };
            }
            if (dateTime < match.League.StartDate || dateTime > match.League.EndDate)
            {
                return new UpdateMatchInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-09"
                };
            }
            var matchHomes = await matchRepository.FindByCondition(m =>
            m.HomeId == match.HomeId && m.MatchId != match.MatchId)
                .ToListAsync();
            var matchAways = await matchRepository.FindByCondition(m =>
            m.AwayId == match.AwayId && m.MatchId != match.MatchId)
                .ToListAsync();
            foreach (var matchH in matchHomes)
            {
                if (Math.Abs(matchH.MatchDate.Subtract(dateTime).TotalDays) < 1)
                {
                    return new UpdateMatchInfoResponse
                    {
                        Success = false,
                        MessageCode = "ER-MA-10"
                    };
                }
            }
            foreach (var matchA in matchAways)
            {
                if (Math.Abs(matchA.MatchDate.Subtract(dateTime).TotalDays) < 1)
                {
                    return new UpdateMatchInfoResponse
                    {
                        Success = false,
                        MessageCode = "ER-MA-10"
                    };
                }
            }
            match.MatchDate = dateTime;
            match.Stadium = request.Stadium;
            Match result = await matchRepository.UpdateAsync(match);
            if (result != null)
            {
                return new UpdateMatchInfoResponse { Success = true, MessageCode = "MS-MA-02" };
            }
            return new UpdateMatchInfoResponse { Success = false, MessageCode = "ER-MA-11" };
        }
    }
}

