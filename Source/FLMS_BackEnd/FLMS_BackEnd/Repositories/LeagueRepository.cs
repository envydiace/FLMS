using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface LeagueRepository: BaseRepository<League> 
    {
        public Task<League> CreateLeague(League league);
    }
}
