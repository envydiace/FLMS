using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class ParticipateNodeRepositoryImpl : BaseRepositoryImpl<ParticipateNode>, ParticipateNodeRepository
    {
        public ParticipateNodeRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
