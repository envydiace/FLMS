using FLMS_BackEnd.Helpers;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class TokenServiceImpl : TokenService
    {
        private readonly UserRepository userRepository;
        private readonly TokenRepository tokenRepository;
        private readonly IConfiguration _configuration;
        private readonly TokenHelper tokenHelper;

        public TokenServiceImpl(UserRepository userRepository, TokenRepository tokenRepository, IConfiguration configuration, TokenHelper tokenHelper)
        {
            this.userRepository = userRepository;
            this.tokenRepository = tokenRepository;
            _configuration = configuration;
            this.tokenHelper = tokenHelper;
        }
        public async Task<TokenResponse> GenerateTokensAsync(int userId)
        {
            var accessToken = await tokenHelper.GenerateAccessToken(userId);
            var refreshToken = await tokenHelper.GenerateRefreshToken();

            var userRecord = await userRepository.FindByCondition(user => user.UserId == userId).Include(u => u.RefreshTokens).FirstOrDefaultAsync(); ;

            if (userRecord == null)
            {
                return new TokenResponse { Success = false, MessageCode = "ER-US-07" };
            }

            var salt = PasswordHelper.GetSecureSalt();

            var refreshTokenHashed = PasswordHelper.HashUsingPbkdf2(refreshToken, salt);

            if (userRecord.RefreshTokens != null && userRecord.RefreshTokens.Any())
            {
                await tokenRepository.RemoveRefreshTokenByUserIdAsync(userId);
            }

            await tokenRepository.CreateAsync(new RefreshToken
            {
                ExpiryDate = DateTime.Now.AddSeconds(Convert.ToInt32(_configuration["Jwt:RefreshExpire"])),
                CreateAt = DateTime.Now,
                UserId = userId,
                TokenHash = refreshTokenHashed,
                TokenSalt = Convert.ToBase64String(salt)

            });
            return new TokenResponse { Success = true, AccessToken = accessToken, RefreshToken = refreshToken, Role = userRecord.Role };
        }

        public async Task<TokenResponse> ValidateRefreshTokenAsync(RefreshTokenRequest refreshTokenRequest)
        {
            var refreshToken = await tokenRepository.FindByCondition(token => token.UserId == refreshTokenRequest.UserId).FirstOrDefaultAsync();

            var response = new TokenResponse();
            if (refreshToken == null)
            {
                response.Success = false;
                response.MessageCode = "ER-US-10";
                return response;
            }

            var refreshTokenToValidateHash = PasswordHelper.HashUsingPbkdf2(refreshTokenRequest.RefreshToken, Convert.FromBase64String(refreshToken.TokenSalt));

            if (refreshToken.TokenHash != refreshTokenToValidateHash)
            {
                response.Success = false;
                response.MessageCode = "ER-US-11";
                return response;
            }

            if (refreshToken.ExpiryDate < DateTime.Now)
            {
                response.Success = false;
                response.MessageCode = "ER-US-12";
                return response;
            }
            response = await this.GenerateTokensAsync(refreshToken.UserId);

            return response;
        }

    }
}
