using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class LeagueRepositoryImpl : BaseRepositoryImpl<League>, LeagueRepository
    {
        public LeagueRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
