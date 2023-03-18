using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class SquadRepositoryImpl : BaseRepositoryImpl<Squad>, SquadRepository
    {
        public SquadRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
