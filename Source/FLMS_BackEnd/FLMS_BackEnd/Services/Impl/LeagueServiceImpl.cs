
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

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
            var league = mapper.Map<League>(request);
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
