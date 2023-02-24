using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class LeagueRepositoryImpl : BaseRepositoryImpl<League>, LeagueRepository
    {
        public LeagueRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }

        public async Task<League> CreateLeague(League league)
        {
            try
            {
                if (league != null)
                {
                    var entity = await _dbContext.Leagues.AddAsync(league);
                    int savechanges = await _dbContext.SaveChangesAsync();
                    if (savechanges > 0)
                    {
                        return entity.Entity;
                    }
                }
            }
            catch (Exception){}
            return null;
        }
    }
}
