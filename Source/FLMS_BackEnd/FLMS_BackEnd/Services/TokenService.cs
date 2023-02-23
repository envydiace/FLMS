using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface TokenService
    {
        Task<TokenResponse> GenerateTokensAsync(int userId);
        Task<TokenResponse> ValidateRefreshTokenAsync(RefreshTokenRequest refreshTokenRequest);
    }
}
