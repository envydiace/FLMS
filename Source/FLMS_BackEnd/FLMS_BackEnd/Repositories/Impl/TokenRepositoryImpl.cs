using FLMS_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class TokenRepositoryImpl : TokenRepository
    {
        private readonly FLMS_DBContext _dbContext;
        public TokenRepositoryImpl(FLMS_DBContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<bool> AddRefreshToken(RefreshToken refreshToken)
        {
            try
            {
                _dbContext.Add<RefreshToken>(refreshToken);
                int savechanges = await _dbContext.SaveChangesAsync();
                return savechanges > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public async Task<RefreshToken> GetRefreshTokenByUserIdAsync(int userId)
        {
            return await _dbContext.RefreshTokens.FirstOrDefaultAsync(o => o.UserId == userId);
        }

        public async Task<bool> RemoveRefreshTokenByUserIdAsync(int userId)
        {
            var userRecord = await _dbContext.Users.Include(o => o.RefreshTokens).FirstOrDefaultAsync(e => e.UserId == userId);

            if (userRecord == null)
            {
                return false;
            }

            if (userRecord.RefreshTokens != null && userRecord.RefreshTokens.Any())
            {
                var currentRefreshToken = userRecord.RefreshTokens.First();

                _dbContext.RefreshTokens.Remove(currentRefreshToken);
                int savechanges = await _dbContext.SaveChangesAsync();
                return savechanges > 0;
            }

            return false;
        }
    }
}
