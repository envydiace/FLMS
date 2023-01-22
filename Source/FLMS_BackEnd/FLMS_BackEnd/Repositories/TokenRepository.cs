using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface TokenRepository
    {
        Task<bool> RemoveRefreshTokenAsync(int userId);
        Task<bool> AddRefreshToken(RefreshToken refreshToken);
    }
}
