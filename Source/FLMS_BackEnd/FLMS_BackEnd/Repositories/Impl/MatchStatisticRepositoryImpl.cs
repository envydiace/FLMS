using FLMS_BackEnd.Models;
using System.Linq.Expressions;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class MatchStatisticRepositoryImpl : BaseRepositoryImpl<MatchStat>, MatchStatisticRepository
    {
        public MatchStatisticRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
