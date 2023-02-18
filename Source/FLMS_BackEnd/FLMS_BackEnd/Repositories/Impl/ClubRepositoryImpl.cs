using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class ClubRepositoryImpl : BaseRepositoryImpl<Club>, ClubRepository
    {
        public ClubRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }

    }
}
