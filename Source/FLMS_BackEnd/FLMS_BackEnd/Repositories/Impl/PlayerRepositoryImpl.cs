using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class PlayerRepositoryImpl : BaseRepositoryImpl<Player>, PlayerRepository
    {
        public PlayerRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
