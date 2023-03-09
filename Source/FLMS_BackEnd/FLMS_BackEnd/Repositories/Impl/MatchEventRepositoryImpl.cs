using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class MatchEventRepositoryImpl : BaseRepositoryImpl<MatchEvent>, MatchEventRepository
    {
        public MatchEventRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
