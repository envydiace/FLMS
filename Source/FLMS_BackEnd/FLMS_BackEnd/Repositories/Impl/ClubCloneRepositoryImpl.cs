using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class ClubCloneRepositoryImpl : BaseRepositoryImpl<ClubClone>, ClubCloneRepository
    {
        public ClubCloneRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
