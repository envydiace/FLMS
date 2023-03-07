using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class SquadPositionRepositoryImpl : BaseRepositoryImpl<SquadPosition>, SquadPositionRepository
    {
        public SquadPositionRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
