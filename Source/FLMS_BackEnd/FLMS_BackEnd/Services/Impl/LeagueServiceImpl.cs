﻿
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

            switch (MethodUtils.GetLeagueTypeByName(request.LeagueType))
            {
                case Constants.LeagueType.KO:
                    ICollection<ClubClone> clubClones = new List<ClubClone>();
                    ICollection<ParticipateNodeDTO> participateNodes = MethodUtils.GetKoList(request.NoParticipate);

                    List<ParticipateNode> participates = mapper.Map<List<ParticipateNode>>(participateNodes);
                    int index = 0;
                    foreach (ParticipateNode participateNode in participates.Where(p => p.LeftId == 0))
                    {
                        var clubClone = new ClubClone { ClubCloneKey = "C" + (index + 1) };
                        participateNode.ClubClone = clubClone;
                        clubClones.Add(clubClone);
                        index++;
                    }
                    List<Match> matchList = new List<Match>();
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
    }
}
