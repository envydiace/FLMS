using FLMS_BackEnd.Helpers;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;

namespace FLMS_BackEnd.Services.Impl
{
    public class TokenServiceImpl : TokenService
    {
        private readonly UserRepository userRepository;
        private readonly TokenRepository tokenRepository;

        public TokenServiceImpl(UserRepository userRepository, TokenRepository tokenRepository)
        {
            this.userRepository = userRepository;
            this.tokenRepository = tokenRepository;
        }
        public async Task<Tuple<string, string>> GenerateTokensAsync(int userId)
        {
            var accessToken = await TokenHelper.GenerateAccessToken(userId);
            var refreshToken = await TokenHelper.GenerateRefreshToken();

            User userRecord = await userRepository.GetUserByUserIdIncludeRefreshToken(userId);

            if (userRecord == null)
            {
                return null;
            }

            var salt = PasswordHelper.GetSecureSalt();

            var refreshTokenHashed = PasswordHelper.HashUsingPbkdf2(refreshToken, salt);

            if (userRecord.RefreshTokens != null && userRecord.RefreshTokens.Any())
            {
                await tokenRepository.RemoveRefreshTokenAsync(userId);
            }

            await tokenRepository.AddRefreshToken(new RefreshToken
            {
                ExpiryDate = DateTime.Now.AddMinutes(1),
                CreateAt = DateTime.Now,
                UserId = userId,
                TokenHash = refreshTokenHashed,
                TokenSalt = Convert.ToBase64String(salt)

            });

            //userRecord.RefreshTokens?.Add(new RefreshToken
            //{
            //    ExpiryDate = DateTime.Now.AddDays(30),
            //    Ts = DateTime.Now,
            //    UserId = userId,
            //    TokenHash = refreshTokenHashed,
            //    TokenSalt = Convert.ToBase64String(salt)

            //});

            //await tasksDbContext.SaveChangesAsync();

            var token = new Tuple<string, string>(accessToken, refreshToken);

            return token;
        }
       
    }
}
