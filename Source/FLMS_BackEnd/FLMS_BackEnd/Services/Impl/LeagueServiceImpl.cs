﻿
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class LeagueServiceImpl: BaseService, LeagueService
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
            if(request.EndDate.CompareTo(request.StartDate) <= 0)
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
