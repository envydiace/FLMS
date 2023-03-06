using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class FeeRepositoryImpl : BaseRepositoryImpl<LeagueFee>, FeeRepository
    {
        public FeeRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
