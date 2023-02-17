using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface TokenRepository : BaseRepository<RefreshToken>
    {
        Task<bool> RemoveRefreshTokenByUserIdAsync(int userId);
        Task<RefreshToken> GetRefreshTokenByUserIdAsync(int userId);
    }
}
