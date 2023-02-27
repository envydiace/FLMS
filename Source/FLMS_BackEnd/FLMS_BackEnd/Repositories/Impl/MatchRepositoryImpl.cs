using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class MatchRepositoryImpl : BaseRepositoryImpl<Match>, MatchRepository
    {
        public MatchRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
