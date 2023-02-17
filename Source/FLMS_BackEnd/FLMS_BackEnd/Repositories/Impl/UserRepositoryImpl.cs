using FLMS_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class UserRepositoryImpl : BaseRepositoryImpl<User>, UserRepository
    {
        public UserRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }

        public async Task<User> GetByEmail(string email)
        {
            return await _dbContext.Users.FirstOrDefaultAsync(u => u.Email.Equals(email));
        }

        public async Task<User> GetUserByUserId(int userId)
        {
            return await _dbContext.Users.FirstOrDefaultAsync(u => u.UserId == userId);
        }

        public async Task<User> GetUserByUserIdIncludeRefreshToken(int userId)
        {
            return await _dbContext.Users.Include(u=> u.RefreshTokens).FirstOrDefaultAsync(u => u.UserId == userId);
        }
    }
}
