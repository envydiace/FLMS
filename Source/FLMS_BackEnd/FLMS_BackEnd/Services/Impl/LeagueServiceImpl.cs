
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;
using static FLMS_BackEnd.Utils.Constants;

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
            leagueFees.Add(new LeagueFee
            {
                ExpenseName = Constants.Fee.SponsoredName,
                ExpenseKey = Constants.Fee.SponsoredKey,
                Cost = 0,
                IsActual = true,
                FeeType = Constants.FeeType.Sponsored.ToString()
            });
            var listPrizes = mapper.Map<List<LeagueFee>>(request.Prizes);
            leagueFees.AddRange(listPrizes);
            var listFees = mapper.Map<List<LeagueFee>>(request.Fees);
            leagueFees.AddRange(listFees);
            listPrizes.ForEach(prize =>
            {
                leagueFees.Add(new LeagueFee
                {
                    Cost = 0,
                    ExpenseKey = prize.ExpenseKey,
                    ExpenseName = prize.ExpenseName,
                    FeeType = prize.FeeType,
                    IsActual = true,
                    LeagueId = prize.LeagueId
                });
            });
            listFees.ForEach(fee =>
            {
                leagueFees.Add(new LeagueFee
                {
                    Cost = 0,
                    ExpenseKey = fee.ExpenseKey,
                    ExpenseName = fee.ExpenseName,
                    FeeType = fee.FeeType,
                    IsActual = true,
                    LeagueId = fee.LeagueId
                });
            });

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
                || league.LeagueName.ToLower().Contains(request.searchLeagueName.ToLower()))
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

        public async Task<List<LeagueInfoDTO>> GetListLeagueByUser(int userId)
        {
            var listLeague = await leagueRepository.FindByCondition(l => l.UserId == userId)
                .Include(l => l.User)
                .Include(l => l.LeagueFees).ToListAsync();
            return mapper.Map<List<LeagueInfoDTO>>(listLeague);
        }
        public async Task<TopEventResponse> GetLeagueTopEvent(int leagueId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId)
                                    .Include(l => l.Matches).ThenInclude(m => m.MatchEvents).ThenInclude(m => m.Main)
                                    .Include(l => l.Matches).ThenInclude(m => m.MatchEvents).ThenInclude(m => m.Sub)
                                    .FirstOrDefaultAsync();
            if (league != null)
            {
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
                    .Take(Constants.TOP_EVENT_NUMBER)
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
                    .Take(Constants.TOP_EVENT_NUMBER)
                        .ToList();
                return new TopEventResponse
                {
                    TopScore = topScore,
                    TopAssist = topAssist
                };
            }
            return new TopEventResponse();
        }
        public async Task<LeagueLeagueStatisticResponse> GetLeagueStatisticTypeLeague(int leagueId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId)
                                    .Include(l => l.ClubClones).ThenInclude(cl => cl.Club)
                                    .Include(l => l.ClubClones).ThenInclude(cl => cl.ParticipateNodes).ThenInclude(pn => pn.MatchHomes).ThenInclude(m => m.MatchStats)
                                    .Include(l => l.ClubClones).ThenInclude(cl => cl.ParticipateNodes).ThenInclude(pn => pn.MatchAways).ThenInclude(m => m.MatchStats)
                                    .FirstOrDefaultAsync();
            if (league == null)
            {
                return new LeagueLeagueStatisticResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            if (!Constants.LeagueType.LEAGUE.Equals(MethodUtils.GetLeagueTypeByName(league.LeagueType)))
            {
                return new LeagueLeagueStatisticResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-10"
                };
            }
            var standings = mapper.Map<List<LeagueStandingDTO>>(league.ClubClones)
                            .OrderByDescending(s => s.Point)
                            .ThenByDescending(s => s.GD)
                            .ThenBy(s => s.ClubName)
                            .ToList();
            standings.ForEach(s => s.Standing = (standings.IndexOf(s) + 1));

            var topEvent = await this.GetLeagueTopEvent(leagueId);

            return new LeagueLeagueStatisticResponse
            {
                Success = true,
                LeagueId = leagueId,
                LeagueType = league.LeagueType,
                LeagueStanding = standings,
                TopScore = topEvent.TopScore,
                TopAssist = topEvent.TopAssist
            };
        }


        public async Task<DeleteLeagueResponse> DeleteLeague(int leagueId, int userId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId)
                            .Include(l => l.Participations)
                            .Include(l => l.Matches)
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
            while (matches.Count > 0)
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

        public async Task<LeagueKnockOutStatisticResponse> GetLeagueStatisticTypeKO(int leagueId)
        {
            var league = await leagueRepository.FindByCondition(n => n.LeagueId == leagueId)
                    .Include(l => l.ParticipateNodes)
                        .ThenInclude(n => n.ClubClone).ThenInclude(c => c.Club)
                    .Include(l => l.ParticipateNodes)
                        .ThenInclude(pn => pn.MatchHomes).ThenInclude(mh => mh.MatchEvents)
                    .Include(l => l.ParticipateNodes)
                        .ThenInclude(pn => pn.MatchAways).ThenInclude(ma => ma.MatchEvents)
                    .FirstOrDefaultAsync();
            if (league == null)
            {
                return new LeagueKnockOutStatisticResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            if (!Constants.LeagueType.KO.Equals(MethodUtils.GetLeagueTypeByName(league.LeagueType)))
            {
                return new LeagueKnockOutStatisticResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-10"
                };
            }
            var list = league.ParticipateNodes
                    .OrderByDescending(n => n.Deep).ThenBy(n => n.ParentId).ThenBy(n => n.ParticipateId)
                    .ToList();
            var listNodes = mapper.Map<List<ParticipateTreeNodeDTO>>(list);
            List<MatchNodeDTO> listMatchNode = new List<MatchNodeDTO>();
            var groupNodes = from node in listNodes
                             group node by node.ParentId;
            foreach (var node in groupNodes)
            {
                List<ParticipationNodeTreeDTO> Participation = new List<ParticipationNodeTreeDTO>();
                int deep = 0;
                foreach (var n in node.ToList())
                {
                    Participation.Add(mapper.Map<ParticipationNodeTreeDTO>(n));
                    deep = n.Deep;
                }
                var matchNode = new MatchNodeDTO
                {
                    ParentId = node.Key,
                    Deep = deep,
                    Participation = Participation
                };
                listMatchNode.Add(matchNode);
            }

            var topEvent = await this.GetLeagueTopEvent(leagueId);

            return new LeagueKnockOutStatisticResponse
            {
                Success = true,
                LeagueId = leagueId,
                Height = list.Max(x => x.Deep),
                LeagueType = league.LeagueType,
                ListNode = listMatchNode,
                TopScore = topEvent.TopScore,
                TopAssist = topEvent.TopAssist
            };
        }

        public async Task<TopLeaguePrizeResponse> GetLeagueTopPrize(int size)
        {
            var leagueFeesQuery = leagueRepository
                .FindByCondition(l => l.LeagueFees
                    .Any(fee => (fee.FeeType.Equals(Constants.FeeType.Sponsored.ToString()) ||
                        fee.FeeType.Equals(Constants.FeeType.Prize.ToString())) && !fee.IsActual))
                .Include(l => l.LeagueFees)
                .SelectMany(l => l.LeagueFees
                    .Where(fee => (fee.FeeType.Equals(Constants.FeeType.Sponsored.ToString()) ||
                        fee.FeeType.Equals(Constants.FeeType.Prize.ToString())) && !fee.IsActual)
                    .Select(fee => new
                    {
                        LeagueId = l.LeagueId,
                        FeeCost = fee.Cost
                    }));

            var groupedFeesQuery = leagueFeesQuery
                .GroupBy(x => x.LeagueId)
                .Select(g => new
                {
                    LeagueId = g.Key,
                    TotalPrize = g.Sum(x => x.FeeCost)
                });

            var topPrizeQuery = groupedFeesQuery
                .Where(x => x.TotalPrize > 0)
                .Join(leagueRepository.FindAll(), x => x.LeagueId, l => l.LeagueId, (x, l) => new
                {
                    League = l,
                    TotalPrize = x.TotalPrize
                })
                .OrderByDescending(x => x.TotalPrize)
                .Take(size);

            var listTopPrize = await topPrizeQuery.Select(x => new LeagueTotalPrizeDTO
            {
                League = x.League,
                TotalPrize = x.TotalPrize
            }).ToListAsync();

            if (listTopPrize == null)
            {
                return new TopLeaguePrizeResponse();
            }
            return new TopLeaguePrizeResponse
            {
                Success = true,
                TopLeaguePrizes = mapper.Map<List<TopLeaguePrizeDTO>>(listTopPrize)
            };
        }

        public async Task<LeagueUpdateInfoResponse> GetLeagueUpdateInfo(int leagueId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId).FirstOrDefaultAsync();
            if (league == null)
            {
                return new LeagueUpdateInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            return new LeagueUpdateInfoResponse
            {
                Success = true,
                Info = mapper.Map<LeagueUpdateInfoDTO>(league),
            };
        }

        public async Task<LeagueUpdateInfoResponse> UpdateLeagueInfo(LeagueUpdateInfoRequest request, int UserId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == request.LeagueId).FirstOrDefaultAsync();
            if (league == null)
            {
                return new LeagueUpdateInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            if (league.UserId != UserId)
            {
                return new LeagueUpdateInfoResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (request.Logo == null || request.Logo.Equals(""))
            {
                league.Logo = null;
            }
            else
            {
                league.Logo = request.Logo;
            }
            league.LeagueName = request.LeagueName;
            league.Fanpage = request.Fanpage;
            league.Location = request.Location;
            var result = await leagueRepository.UpdateAsync(league);
            if (result != null)
            {
                return new LeagueUpdateInfoResponse
                {
                    Success = true,
                    MessageCode = "MS-LE-03",
                    Info = mapper.Map<LeagueUpdateInfoDTO>(result)
                };
            }
            return new LeagueUpdateInfoResponse { Success = false, MessageCode = "ER-LE-11" };
        }
    }
}
