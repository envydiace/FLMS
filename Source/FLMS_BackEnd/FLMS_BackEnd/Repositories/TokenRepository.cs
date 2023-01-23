using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface TokenRepository
    {
        Task<bool> RemoveRefreshTokenByUserIdAsync(int userId);
        Task<bool> AddRefreshToken(RefreshToken refreshToken);
        Task<RefreshToken> GetRefreshTokenByUserIdAsync(int userId);
    }
}
