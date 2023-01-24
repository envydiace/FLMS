using FLMS_BackEnd.Helpers;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;

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
        public async Task<Tuple<string, string>> GenerateTokensAsync(int userId)
        {
            var accessToken = await tokenHelper.GenerateAccessToken(userId);
            var refreshToken = await tokenHelper.GenerateRefreshToken();

            User userRecord = await userRepository.GetUserByUserIdIncludeRefreshToken(userId);

            if (userRecord == null)
            {
                return null;
            }

            var salt = PasswordHelper.GetSecureSalt();

            var refreshTokenHashed = PasswordHelper.HashUsingPbkdf2(refreshToken, salt);

            if (userRecord.RefreshTokens != null && userRecord.RefreshTokens.Any())
            {
                await tokenRepository.RemoveRefreshTokenByUserIdAsync(userId);
            }

            await tokenRepository.AddRefreshToken(new RefreshToken
            {
                ExpiryDate = DateTime.Now.AddSeconds(Convert.ToInt32(_configuration["Jwt:RefreshExpire"])),
                CreateAt = DateTime.Now,
                UserId = userId,
                TokenHash = refreshTokenHashed,
                TokenSalt = Convert.ToBase64String(salt)

            });

            var token = new Tuple<string, string>(accessToken, refreshToken);

            return token;
        }

        public async Task<ValidateRefreshTokenResponse> ValidateRefreshTokenAsync(RefreshTokenRequest refreshTokenRequest)
        {
            var refreshToken = await tokenRepository.GetRefreshTokenByUserIdAsync( refreshTokenRequest.UserId);

            var response = new ValidateRefreshTokenResponse();
            if (refreshToken == null)
            {
                response.Success = false;
                response.Message = Constants.Message.INVALID_SESSION;
                return response;
            }

            var refreshTokenToValidateHash = PasswordHelper.HashUsingPbkdf2(refreshTokenRequest.RefreshToken, Convert.FromBase64String(refreshToken.TokenSalt));

            if (refreshToken.TokenHash != refreshTokenToValidateHash)
            {
                response.Success = false;
                response.Message = Constants.Message.INVALID_REFRESH_TOKEN;
                return response;
            }

            if (refreshToken.ExpiryDate < DateTime.Now)
            {
                response.Success = false;
                response.Message = Constants.Message.REFRESH_TOKEN_EXPIRED;
                return response;
            }

            response.Success = true;
            response.UserId = refreshToken.UserId;

            return response;
        }

    }
}
