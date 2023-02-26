
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

        public LeagueServiceImpl(LeagueRepository leagueRepository)
        {
            this.leagueRepository = leagueRepository;
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
            if (request.EndDate.CompareTo(request.StartDate) <= 0)
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
                                MatchDate = league.EndDate.AddDays(-(participate.Deep - 1) * 2)
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
                                        MatchDate = league.StartDate.AddDays(day * 2)
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
                || request.from.GetValueOrDefault().CompareTo(league.StartDate)<=0)
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
                Total = total
            };
        }
    }
}
