using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class MatchEventServiceImpl : BaseService, MatchEventService
    {
        private readonly MatchEventRepository matchEventRepository;
        private readonly MatchRepository matchRepository;
        private readonly SquadPositionRepository squadPositionRepository;
        private readonly ParticipateNodeRepository participateNodeRepository;

        public MatchEventServiceImpl(MatchEventRepository matchEventRepository, MatchRepository matchRepository, SquadPositionRepository squadPositionRepository, ParticipateNodeRepository participateNodeRepository)
        {
            this.matchEventRepository = matchEventRepository;
            this.matchRepository = matchRepository;
            this.squadPositionRepository = squadPositionRepository;
            this.participateNodeRepository = participateNodeRepository;
        }
        public async Task<List<MatchEventDTO>> GetMatchEvent(int matchId)
        {
            var matchEvents = await matchEventRepository.FindByCondition(e => e.MatchId == matchId)
                                    .Include(e => e.Match).ThenInclude(m => m.Home).ThenInclude(h => h.ClubClone)
                                    .Include(e => e.Match).ThenInclude(m => m.Away).ThenInclude(a => a.ClubClone)
                                    .Include(e => e.Main)
                                    .Include(e => e.Sub)
                                        .OrderBy(e => e.EventTime)
                                        .ToListAsync();
            return mapper.Map<List<MatchEventDTO>>(matchEvents);
        }
        public async Task<AddMatchEventResponse> AddEvent(AddMatchEventRequest request, int userId)
        {
            request.EventType = request.EventType.Trim();
            var match = await matchRepository.FindByCondition(m => m.MatchId == request.MatchId)
                    .Include(m => m.Home).ThenInclude(p => p.ClubClone)
                    .Include(m => m.Away).ThenInclude(p => p.ClubClone)
                    .Include(m => m.League)
                    .FirstOrDefaultAsync();
            if (match == null)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-01"
                };
            }
            if (match.League.UserId != userId)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (match.Home.ClubClone == null || match.Home.ClubClone.ClubId == null ||
                match.Away.ClubClone == null || match.Away.ClubClone.ClubId == null)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-06"
                };
            }
            bool isHome;
            if (match.Home.ClubClone.ClubId == request.ClubId)
            {
                isHome = true;
            }
            else if (match.Away.ClubClone.ClubId == request.ClubId)
            {
                isHome = false;
            }
            else
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-07"
                };
            }
            request.SubId = request.SubId != 0 ? request.SubId : null;
            if (request.MainId == request.SubId)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-EV-01"
                };
            }
            bool checkHome;
            switch (MethodUtils.GetMatchEventTypeByName(request.EventType))
            {
                case Constants.MatchEventType.Goal:
                case Constants.MatchEventType.YellowCard:
                case Constants.MatchEventType.RedCard:
                    checkHome = isHome;
                    break;
                case Constants.MatchEventType.OwnGoal:
                    checkHome = !isHome;
                    break;
                default:
                    return new AddMatchEventResponse
                    {
                        Success = false,
                        MessageCode = "ER-EV-02"
                    };
            }
            var squadPosition = await squadPositionRepository.FindByCondition(sp =>
                            sp.Squad.MatchId == request.MatchId &&
                            sp.Squad.IsHome == checkHome &&
                            sp.PlayerId == request.MainId)
                        .Include(sp => sp.Squad)
                        .FirstOrDefaultAsync();
            //if (squadPosition == null)
            //{
            //    return new AddMatchEventResponse
            //    {
            //        Success = false,
            //        MessageCode = "ER-EV-03"
            //    };
            //}
            var squadPositionSub = await squadPositionRepository.FindByCondition(sp =>
                            sp.Squad.MatchId == request.MatchId &&
                            sp.PlayerId == request.SubId)
                        .Include(sp => sp.Squad)
                        .FirstOrDefaultAsync();
            //if (request.SubId != null && squadPositionSub == null)
            //{
            //    return new AddMatchEventResponse
            //    {
            //        Success = false,
            //        MessageCode = "ER-EV-05"
            //    };
            //}

            MatchEvent matchEvent = new MatchEvent
            {
                EventType = request.EventType,
                EventTime = request.EventTime,
                MatchId = request.MatchId,
                MainId = request.MainId,
                SubId = request.SubId,
                IsHome = isHome
            };
            var result = await matchEventRepository.CreateAsync(matchEvent);
            if (result)
            {
                return new AddMatchEventResponse
                {
                    Success = true,
                    MessageCode = "MS-EV-01"
                };
            }
            else
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-EV-04"
                };
            }
        }

        public async Task<DeleteMatchEventResponse> DeleteEvent(int eventId, int userId)
        {
            var matchEvent = await matchEventRepository.FindByCondition(e => e.MatchEventId == eventId)
                                    .Include(e => e.Match).ThenInclude(m => m.League)
                                    .FirstOrDefaultAsync();
            if (matchEvent == null)
            {
                return new DeleteMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-EV-06"
                };
            }
            if (matchEvent.Match.League.UserId != userId)
            {
                return new DeleteMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            var result = await matchEventRepository.DeleteAsync(matchEvent);
            if (result != null)
            {
                return new DeleteMatchEventResponse
                {
                    Success = true,
                    MessageCode = "MS-EV-02"
                };
            }
            else
            {
                return new DeleteMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-07"
                };
            }
        }

        public async Task<AddMatchEventResponse> AddMultipleEvent(List<AddMatchEventRequest> requests, int userId)
        {
            if (requests == null || requests.Count == 0)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-EV-04"
                };
            }
            var match = await matchRepository.FindByCondition(m => m.MatchId == requests.First().MatchId)
                    .Include(m => m.MatchStats)
                    .Include(m => m.MatchEvents)
                    .Include(m => m.Home).ThenInclude(p => p.ClubClone)
                    .Include(m => m.Away).ThenInclude(p => p.ClubClone)
                    .Include(m => m.League)
                    .FirstOrDefaultAsync();
            if (match == null)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-01"
                };
            }
            if (match.League.UserId != userId)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (match.League.Status.Equals(Constants.LeagueStatus.Finished.ToString()))
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-07"
                };
            }
            if (match.Home.ClubClone == null || match.Home.ClubClone.ClubId == null ||
                match.Away.ClubClone == null || match.Away.ClubClone.ClubId == null)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-06"
                };
            }
            var listOldMatchEvent = match.MatchEvents.ToList();
            List<MatchEvent> matchEvents = new List<MatchEvent>();
            try
            {
                matchEvents = this.GenerateMatchEvents(requests, match);
            }
            catch (Exception e)
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = e.Message
                };
            }
            if (match.IsFinish)
            {
                var listNewGoal = matchEvents.Where(ev =>
                    ev.EventType.Equals(Constants.MatchEventType.Goal.ToString()) ||
                    ev.EventType.Equals(Constants.MatchEventType.OwnGoal.ToString())
                ).ToList();
                if (listNewGoal.Count > 0)
                {
                    var listOldGoal = match.MatchEvents.Where(ev =>
                        ev.EventType.Equals(Constants.MatchEventType.Goal.ToString()) ||
                        ev.EventType.Equals(Constants.MatchEventType.OwnGoal.ToString())
                    ).ToList();

                    var homeNewScore = listNewGoal.Where(e => e.IsHome).Count();
                    var awayNewScore = listNewGoal.Where(e => !e.IsHome).Count();

                    var homeOldScore = listOldGoal.Where(e => e.IsHome).Count();
                    var awayOldScore = listOldGoal.Where(e => !e.IsHome).Count();

                    var homeClubClone = match.Home.ClubClone;
                    var awayClubClone = match.Away.ClubClone;

                    homeClubClone.GoalsFor = homeClubClone.GoalsFor - homeOldScore + homeNewScore;
                    homeClubClone.GoalsAgainst = homeClubClone.GoalsAgainst - awayOldScore + awayNewScore;

                    awayClubClone.GoalsFor = awayClubClone.GoalsFor - awayOldScore + awayNewScore;
                    awayClubClone.GoalsAgainst = awayClubClone.GoalsAgainst - homeOldScore + homeNewScore;

                    if (homeOldScore > awayOldScore)
                    {
                        homeClubClone.Won--;
                        awayClubClone.Loss--;
                    }
                    else if (homeOldScore < awayOldScore)
                    {
                        homeClubClone.Loss--;
                        awayClubClone.Won--;
                    }
                    else
                    {
                        homeClubClone.Draw--;
                        awayClubClone.Draw--;
                    }

                    if (homeNewScore > awayNewScore)
                    {
                        homeClubClone.Won++;
                        awayClubClone.Loss++;
                    }
                    else if (homeNewScore < awayNewScore)
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
                        case Constants.LeagueType.LEAGUE:
                            break;
                        case Constants.LeagueType.KO:
                            var listNode = await participateNodeRepository.FindByCondition(n =>
                                n.LeagueId == match.LeagueId)
                                .Include(n => n.MatchHomes)
                                .Include(n => n.MatchAways)
                                .ToListAsync();
                            if (homeNewScore == awayNewScore)
                            {
                                return new AddMatchEventResponse
                                {
                                    Success = false,
                                    MessageCode = "ER-MA-13"
                                };
                            }
                            var node = listNode.FirstOrDefault(n => n.ParticipateId == match.Home.ParentId);
                            if (node == null)
                            {
                                return new AddMatchEventResponse
                                {
                                    Success = false,
                                    MessageCode = "ER-EV-04"
                                };
                            }
                            var listMatch = node.MatchHomes.ToList();
                            listMatch.AddRange(node.MatchAways);
                            var m = listMatch.FirstOrDefault();
                            if (m == null)
                            {
                                return new AddMatchEventResponse
                                {
                                    Success = false,
                                    MessageCode = "ER-EV-04"
                                };
                            }
                            if (m.IsFinish)
                            {
                                return new AddMatchEventResponse
                                {
                                    Success = false,
                                    MessageCode = "ER-EV-08"
                                };
                            }
                            node.ClubCloneId = homeNewScore > awayNewScore ? match.Home.ClubCloneId : match.Away.ClubCloneId;
                            var r = await participateNodeRepository.UpdateAsync(node);
                            if (r == null)
                            {
                                return new AddMatchEventResponse
                                {
                                    Success = false,
                                    MessageCode = "ER-EV-04"
                                };
                            }
                            break;
                        default:
                            break;
                    }
                    var homeStats = match.MatchStats.FirstOrDefault(ms => ms.IsHome);
                    if (homeStats != null)
                    {
                        homeStats.Score = homeNewScore;
                    }
                    else
                    {
                        match.MatchStats.Add(new MatchStat { Score = homeNewScore, IsHome = true });
                    }
                    var awayStats = match.MatchStats.FirstOrDefault(ms => !ms.IsHome);
                    if (awayStats != null)
                    {
                        awayStats.Score = awayNewScore;
                    }
                    else
                    {
                        match.MatchStats.Add(new MatchStat { Score = awayNewScore, IsHome = false });
                    }
                }
            }
            matchEvents.ForEach(matchEvent =>
            {
                match.MatchEvents.Add(matchEvent);
            });
            var result = await matchRepository.UpdateMatchAsync(match);
            if (result != null)
            {
                foreach (var ev in listOldMatchEvent)
                {
                    await matchEventRepository.DeleteAsync(ev);
                }
                return new AddMatchEventResponse { Success = true, MessageCode = "MS-EV-01" };
            }
            else
            {
                return new AddMatchEventResponse
                {
                    Success = false,
                    MessageCode = "ER-EV-04"
                };
            }
        }
        private List<MatchEvent> GenerateMatchEvents(List<AddMatchEventRequest> requests, Match match)
        {
            var result = new List<MatchEvent>();
            foreach (var request in requests)
            {
                request.EventType = request.EventType.Trim();

                bool isHome;
                if (match.Home.ClubClone != null && match.Home.ClubClone.ClubId == request.ClubId)
                {
                    isHome = true;
                }
                else if (match.Away.ClubClone != null && match.Away.ClubClone.ClubId == request.ClubId)
                {
                    isHome = false;
                }
                else
                {
                    throw new Exception("ER-MA-07");
                }
                request.SubId = request.SubId != 0 ? request.SubId : null;
                if (request.MainId == request.SubId)
                {
                    throw new Exception("ER-EV-01");
                }
                bool checkHome;
                switch (MethodUtils.GetMatchEventTypeByName(request.EventType))
                {
                    case Constants.MatchEventType.Goal:
                        checkHome = isHome;
                        break;
                    case Constants.MatchEventType.YellowCard:
                    case Constants.MatchEventType.RedCard:
                        request.SubId = null;
                        checkHome = isHome;
                        break;
                    case Constants.MatchEventType.OwnGoal:
                        checkHome = !isHome;
                        request.SubId = null;
                        break;
                    default:
                        throw new Exception("ER-EV-02");
                }
                MatchEvent matchEvent = new()
                {
                    EventType = request.EventType,
                    EventTime = request.EventTime,
                    MatchId = request.MatchId,
                    MainId = request.MainId,
                    SubId = request.SubId,
                    IsHome = isHome
                };
                result.Add(matchEvent);
            }
            return result;
        }
    }
}
