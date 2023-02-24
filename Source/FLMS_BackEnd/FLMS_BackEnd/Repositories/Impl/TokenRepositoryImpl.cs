using FLMS_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class TokenRepositoryImpl :BaseRepositoryImpl<RefreshToken>, TokenRepository
    {
        public TokenRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
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
