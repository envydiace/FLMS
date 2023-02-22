using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class PlayerClubRepositoryImpl : BaseRepositoryImpl<PlayerClub>, PlayerClubRepository
    {
        public PlayerClubRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
