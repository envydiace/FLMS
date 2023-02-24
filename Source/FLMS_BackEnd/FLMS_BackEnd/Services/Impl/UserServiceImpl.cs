using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Helpers;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class UserServiceImpl : BaseService, UserService
    {
        private readonly UserRepository userRepository;
        private readonly TokenRepository tokenRepository;
        private readonly TokenService tokenService;

        public UserServiceImpl(UserRepository userRepository, TokenRepository tokenRepository, TokenService tokenService)
        {
            this.userRepository = userRepository;
            this.tokenService = tokenService;
            this.tokenRepository = tokenRepository;
        }

        public async Task<SignupResponse> CheckSignUp(SignupRequest signupRequest)
        {
            if (signupRequest == null)
            {
                return new SignupResponse { Success = false, MessageCode = "ER-US-01" };
            }
            var user = await userRepository.FindByCondition(user => user.Email.Equals(signupRequest.Email)).FirstOrDefaultAsync();
            if (user != null)
            {
                return new SignupResponse
                {
                    Success = false,
                    MessageCode = "ER-US-02"
                };
            }
            if (signupRequest.Password != signupRequest.ConfirmPassword)
            {
                return new SignupResponse
                {
                    Success = false,
                    MessageCode = "ER-US-03"
                };
            }
            if (!MethodUtils.CheckUserRole(signupRequest.Role))
            {
                return new SignupResponse
                {
                    Success = false,
                    MessageCode = "ER-US-04"
                };
            }

            // More require for password
            if (signupRequest.Password.Length < 6)
            {
                return new SignupResponse
                {
                    Success = false,
                    MessageCode = "ER-US-05"
                };
            }

            var salt = PasswordHelper.GetSecureSalt();
            var passwordHash = PasswordHelper.HashUsingPbkdf2(signupRequest.Password, salt);
            user = new User
            {
                Email = signupRequest.Email,
                Password = passwordHash,
                PasswordSalt = Convert.ToBase64String(salt),
                FullName = signupRequest.FullName,
                Phone = signupRequest.Phone,
                Address = signupRequest.Address,
                CreateAt = DateTime.Now,
                Role = signupRequest.Role,
                Active = true // You can save is false and send confirmation email to the user, then once the user confirms the email you can make it true
            };

            bool created = await userRepository.CreateAsync(user);
            if (created)
            {
                return new SignupResponse
                {
                    Success = true,
                    MessageCode = "MS-US-02",
                    Email = user.Email
                };
            }

            return new SignupResponse
            {
                Success = false,
                MessageCode = "ER-US-06"
            };
        }

        public async Task<UserProfileResponse> GetUserProfile(int userId)
        {
            var u = await userRepository.FindByCondition(user => user.UserId == userId).FirstOrDefaultAsync();
            if (u == null)
            {
                return new UserProfileResponse
                {
                    Success = false,
                    MessageCode = "ER-US-07"
                };
            }
            return new UserProfileResponse
            {
                Success = true,
                MessageCode = "MS-US-01",
                UserProfile = mapper.Map<UserProfileDTO>(u)
            };
        }

        public async Task<TokenResponse> LoginAsync(LoginRequest loginRequest)
        {
            var user = await userRepository.FindByCondition(user => user.Email.Equals(loginRequest.Email)).FirstOrDefaultAsync();

            if (user == null || !user.Active)
            {
                return new TokenResponse
                {
                    Success = false,
                    MessageCode = "ER-US-08"
                };
            }
            var passwordHash = PasswordHelper.HashUsingPbkdf2(loginRequest.Password, Convert.FromBase64String(user.PasswordSalt));

            if (user.Password != passwordHash)
            {
                return new TokenResponse
                {
                    Success = false,
                    MessageCode = "ER-US-08"
                };
            }

            var token = await System.Threading.Tasks.Task.Run(() => tokenService.GenerateTokensAsync(user.UserId));

            return token;
        }

        public async Task<LogoutResponse> LogoutAsync(int userId)
        {
            var refreshToken = await tokenRepository.FindByCondition(token => token.UserId == userId).FirstOrDefaultAsync();

            if (refreshToken == null)
            {
                return new LogoutResponse { Success = true, MessageCode = "MS-US-03" };
            }
            bool removed = await tokenRepository.RemoveRefreshTokenByUserIdAsync(userId);

            if (removed)
            {
                return new LogoutResponse { Success = true, MessageCode = "MS-US-03" };
            }

            return new LogoutResponse { Success = false, MessageCode = "ER-US-09" };
        }
    }
}
