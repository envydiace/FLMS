
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class LeagueServiceImpl : BaseService, LeagueService
    {
        private readonly LeagueRepository leagueRepository;
        private readonly MatchRepository matchRepository;

        public LeagueServiceImpl(LeagueRepository leagueRepository, MatchRepository matchRepository)
        {
            this.leagueRepository = leagueRepository;
            this.matchRepository = matchRepository;
        }

        public async Task<CreateLeagueResponse> CreateLeague(CreateLeagueRequest request, int userId)
        {
            if (!MethodUtils.CheckLeagueType(request.LeagueType))
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-04"
                };
            }
            int numberOfRound = MethodUtils.CountNumberOfRound(request.LeagueType, request.NoParticipate);
            if (request.EndDate
                    .CompareTo(request.StartDate.AddDays(MethodUtils.CountLeagueDateRange(request.LeagueType, request.NoParticipate) - 1))
                < 0)
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-03"
                };
            }
            var league = await leagueRepository.FindByCondition(league => league.LeagueName.ToLower().Trim().Equals(request.LeagueName.ToLower().Trim())).FirstOrDefaultAsync();
            if (league != null)
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-02"
                };
            }
            league = mapper.Map<League>(request);

            List<LeagueFee> leagueFees = new List<LeagueFee>();
            leagueFees.Add(new LeagueFee
            {
                ExpenseName = Constants.Fee.SponsoredName,
                ExpenseKey = Constants.Fee.SponsoredKey,
                Cost = request.Sponsored,
                IsActual = false,
                FeeType = Constants.FeeType.Sponsored.ToString()
            });
            leagueFees.AddRange(mapper.Map<List<LeagueFee>>(request.Prizes));
            leagueFees.AddRange(mapper.Map<List<LeagueFee>>(request.Fees));
            league.LeagueFees = leagueFees;

            league.UserId = userId;

            List<ParticipateNode> participates;
            ICollection<ClubClone> clubClones;
            List<Match> matchList;
            switch (MethodUtils.GetLeagueTypeByName(request.LeagueType))
            {
                case Constants.LeagueType.KO:
                    clubClones = new List<ClubClone>();
                    matchList = new List<Match>();
                    ICollection<ParticipateNodeDTO> participateNodes = MethodUtils.GetKoList(request.NoParticipate);

                    participates = mapper.Map<List<ParticipateNode>>(participateNodes);
                    int index = 0;
                    foreach (ParticipateNode participateNode in participates.Where(p => p.LeftId == 0))
                    {
                        var clubClone = new ClubClone { ClubCloneKey = "C" + (index + 1) };
                        participateNode.ClubClone = clubClone;
                        clubClones.Add(clubClone);
                        index++;
                    }
                    foreach (ParticipateNode participate in participates)
                    {
                        if (participate.LeftId != 0)
                        {
                            Match match = new Match
                            {
                                Home = participates.FirstOrDefault(x => x.ParticipateId == participate.LeftId),
                                Away = participates.FirstOrDefault(x => x.ParticipateId == participate.RightId),
                                MatchDate = league.EndDate.AddDays(-(participate.Deep - 1) * 2),
                                Stadium = request.Location,
                                Round = MethodUtils.GetLeagueKoRound(participate.Deep),
                                Squads = MethodUtils.GenerateMatchSquad(request.NoPlayerSquad, request.MaxNoPlayer)
                            };
                            matchList.Add(match);
                        }
                    }
                    league.Matches = matchList;
                    league.ClubClones = clubClones;
                    league.ParticipateNodes = participates;
                    break;
                case Constants.LeagueType.LEAGUE:
                    participates = new List<ParticipateNode>();
                    clubClones = new List<ClubClone>();
                    matchList = new List<Match>();
                    for (int i = 0; i < request.NoParticipate; i++)
                    {
                        var clubClone = new ClubClone { ClubCloneKey = "C" + (i + 1) };
                        participates.Add(new ParticipateNode
                        {
                            ClubClone = clubClone
                        });
                        clubClones.Add(clubClone);
                    }
                    string[][] matchs = MethodUtils.GetListMatches(participates.Select(x => x.ClubClone != null ? x.ClubClone.ClubCloneKey : "Bye").ToList());

                    for (int day = 0; day < matchs.Length; day++)
                    {
                        for (int matchIndex = 0; matchIndex < matchs[day].Length; matchIndex++)
                        {
                            string[] key = matchs[day][matchIndex].Split('/');
                            if (key.Length == 2)
                            {
                                var home = participates.FirstOrDefault(p => key[0].Equals(p.ClubClone.ClubCloneKey));
                                var away = participates.FirstOrDefault(p => key[1].Equals(p.ClubClone.ClubCloneKey));
                                if (home != null && away != null)
                                {
                                    matchList.Add(new Match
                                    {
                                        Home = home,
                                        Away = away,
                                        MatchDate = league.StartDate.AddDays(day * 2),
                                        Stadium = request.Location,
                                        Round = "Round " + (day + 1),
                                        Squads = MethodUtils.GenerateMatchSquad(request.NoPlayerSquad, request.MaxNoPlayer)
                                    });
                                }
                            }
                        }
                    }

                    league.Matches = matchList;
                    league.ClubClones = clubClones;
                    league.ParticipateNodes = participates;
                    break;
                case Constants.LeagueType.TABLE:
                    break;
            }

            var result = await leagueRepository.CreateAsync(league);
            if (result)
            {
                return new CreateLeagueResponse
                {
                    Success = true,
                    MessageCode = "MS-LE-01"
                };
            }
            else
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-01"
                };
            }
        }

        public async Task<ListLeagueResponse> GetListLeagueFilters(ListLeagueFilterRequest request)
        {
            var leagues = await leagueRepository.FindByCondition(league =>
            (request.searchLeagueName == null
                || request.searchLeagueName == ""
                || league.LeagueName.StartsWith(request.searchLeagueName))
            &&
            (request.from == null
                || request.from.GetValueOrDefault().CompareTo(league.StartDate) <= 0)
            &&
            (request.to == null
                || request.to.GetValueOrDefault().CompareTo(league.StartDate) >= 0)
            ).ToListAsync();
            int total = leagues.Count;
            var result = mapper.Map<List<LeagueDTO>>(leagues.Skip((request.page - 1) * request.pageSize).Take(request.pageSize).ToList());
            return new ListLeagueResponse
            {
                Success = true,
                Leagues = result,
                Total = total,
                PageIndex = request.page,
                PageSize = request.pageSize
            };
        }

        public async Task<LeagueInfoResponse> GetLeagueInfo(int leagueId)
        {
            var league = await leagueRepository.FindByCondition(league => league.LeagueId == leagueId)
                .Include(league => league.User)
                .Include(league => league.LeagueFees)
                .FirstOrDefaultAsync();
            if (league != null)
            {
                return new LeagueInfoResponse
                {
                    Success = true,
                    leagueInfo = mapper.Map<LeagueInfoDTO>(league)
                };
            }
            return new LeagueInfoResponse
            {
                Success = false,
                MessageCode = "ER-LE-05"
            };
        }

        public async Task<List<LeagueByUserDTO>> GetListLeagueByUser(int userId)
        {
            var listLeague = await leagueRepository.FindByCondition(l => l.UserId == userId).ToListAsync();
            return mapper.Map<List<LeagueByUserDTO>>(listLeague);
        }

        public async Task<LeagueStatisticResponse> GetLeagueStatistic(int leagueId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId)
                                    .Include(l => l.ClubClones).ThenInclude(cl => cl.Club)
                                    .Include(l => l.Matches).ThenInclude(m => m.MatchEvents).ThenInclude(m => m.Main)
                                    .Include(l => l.Matches).ThenInclude(m => m.MatchEvents).ThenInclude(m => m.Sub)
                                    .FirstOrDefaultAsync();
            if (league == null)
            {
                return new LeagueStatisticResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            var standings = mapper.Map<List<LeagueStandingDTO>>(league.ClubClones)
                            .OrderByDescending(s => s.Point)
                            .ThenByDescending(s => s.GD)
                            .ThenBy(s => s.ClubName)
                            .ToList();
            standings.ForEach(s => s.Standing = (standings.IndexOf(s) + 1));

            var listevent = new List<MatchEvent>();
            var matchs = league.Matches.Where(m => m.IsFinish).ToList();
            matchs.ForEach(m => listevent.AddRange(m.MatchEvents.Where(e =>
                                e.EventType.Equals(Constants.MatchEventType.Goal.ToString())).ToList())
                           );

            var topScore = listevent.GroupBy(
                e => e.MainId
                )
                .Select(e => new TopRecordPlayerDTO
                {
                    PlayerId = e.Key,
                    PlayerName = e.Select(x => x.Main.Name).FirstOrDefault(),
                    Avatar = e.Select(x => x.Main.Avatar).FirstOrDefault(),
                    Record = e.Count()
                })
                .OrderByDescending(x => x.Record)
                .ThenBy(x => x.PlayerName)
                    .ToList();

            var topAssist = listevent.Where(e => e.SubId != null).GroupBy(
                e => e.SubId
                )
                .Select(e => new TopRecordPlayerDTO
                {
                    PlayerId = e.Key != null ? e.Key.Value : 0,
                    PlayerName = e.Select(x => x.Sub != null ? x.Sub.Name : " ").FirstOrDefault(),
                    Avatar = e.Select(x => x.Sub != null ? x.Sub.Avatar : null).FirstOrDefault(),
                    Record = e.Count()
                })
                .OrderByDescending(x => x.Record)
                .ThenBy(x => x.PlayerName)
                    .ToList();

            return new LeagueStatisticResponse
            {
                Success = true,
                LeagueStanding = standings,
                TopScore = topScore,
                TopAssist = topAssist
            };
        }

        public async Task<DeleteLeagueResponse> DeleteLeague(int leagueId, int userId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId)
                            .Include(l=>l.Participations)
                            .Include(l=>l.Matches)
                            .FirstOrDefaultAsync();
            if (league == null)
            {
                return new DeleteLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            if (league.UserId != userId)
            {
                return new DeleteLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (league.Participations.Any())
            {
                return new DeleteLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-09"
                };
            }
            var matches = league.Matches;
            while(matches.Count > 0)
            {
                var r = await matchRepository.DeleteAsync(matches.FirstOrDefault());
                if (r == null)
                {
                    return new DeleteLeagueResponse
                    {
                        Success = false,
                        MessageCode = "ER-LE-08"
                    };
                }
            }
            var result = await leagueRepository.DeleteAsync(league);
            if (result != null)
            {
                return new DeleteLeagueResponse
                {
                    Success = true,
                    MessageCode = "MS-LE-02"
                };
            }
            else
            {
                return new DeleteLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-08"
                };
            }
        }
    }
}
