﻿using FLMS_BackEnd.Services;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MatchController : BaseApiController
    {
        private readonly MatchService matchService;
        public MatchController(MatchService matchService)
        {
            this.matchService = matchService;
        }
        [HttpGet("[action]")]
        public async Task<ActionResult<LeagueScheduleResponse>> GetLeagueSchedule([FromQuery]LeagueScheduleRequest request)
        {
            var response = await matchService.GetLeagueSchedule(request);
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