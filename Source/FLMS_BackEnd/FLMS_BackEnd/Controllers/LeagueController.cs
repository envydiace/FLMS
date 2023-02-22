﻿using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LeagueController : BaseApiController
    {
        private readonly LeagueService leagueService;
        public LeagueController(LeagueService leagueService)
        {
            this.leagueService = leagueService;
        }

        [HttpPost("[action]")]
        [Authorize(Roles = "LEAGUE_MANAGER")]
        public async Task<ActionResult<CreateLeagueResponse>> CreateLeague(CreateLeagueRequest request)
        {
            var response = await leagueService.CreateLeague(request, UserID);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
    }
}