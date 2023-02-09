using FLMS_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class UserRepositoryImpl : UserRepository
    {
        private readonly FLMS_DBContext _dbContext;
        public UserRepositoryImpl(FLMS_DBContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<bool> CreateAsync(User user)
        {
            try
            {
                _dbContext.Add<User>(user);
                int savechanges = await _dbContext.SaveChangesAsync();
                return savechanges > 0;
            }
            catch (Exception)
            {
                return false;
            }

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
