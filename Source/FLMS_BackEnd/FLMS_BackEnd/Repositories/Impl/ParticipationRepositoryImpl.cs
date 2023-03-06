using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class ParticipationRepositoryImpl : BaseRepositoryImpl<Participation>, ParticipationRepository
    {
        public ParticipationRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }
    }
}
