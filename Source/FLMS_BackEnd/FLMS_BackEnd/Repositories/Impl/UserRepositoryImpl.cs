using FLMS_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class UserRepositoryImpl : BaseRepositoryImpl<User>, UserRepository
    {
        public UserRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }

    }
}
