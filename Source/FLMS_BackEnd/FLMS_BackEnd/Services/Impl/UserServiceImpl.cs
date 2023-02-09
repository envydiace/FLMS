using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Helpers;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;

namespace FLMS_BackEnd.Services.Impl
{
    public class UserServiceImpl : UserService
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
                return new SignupResponse { Success = false, Message = Constants.Message.REQUEST_FAIL };
            }
            User u = await userRepository.GetByEmail(signupRequest.Email);
            if (u != null)
            {
                return new SignupResponse
                {
                    Success = false,
                    Message = Constants.Message.EMAIL_EXISTED
                };
            }
            if (signupRequest.Password != signupRequest.ConfirmPassword)
            {
                return new SignupResponse
                {
                    Success = false,
                    Message = Constants.Message.PASSWORD_DOES_NOT_MATCH
                };
            }
            if (!Enum.GetValues(typeof(Constants.SystemRole))
                .Cast<Constants.SystemRole>()
                .Select(v => v.ToString())
                .ToList().Contains(signupRequest.Role))
            {
                return new SignupResponse
                {
                    Success = false,
                    Message = Constants.Message.INVALID_ROLE
                };
            }

            // More require for password
            if (signupRequest.Password.Length < 6)
            {
                return new SignupResponse
                {
                    Success = false,
                    Message = Constants.Message.PASSWORD_IS_WEAK
                };
            }

            var salt = PasswordHelper.GetSecureSalt();
            var passwordHash = PasswordHelper.HashUsingPbkdf2(signupRequest.Password, salt);
            User user = new User
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
                    Email = user.Email
                };
            }

            return new SignupResponse
            {
                Success = false,
                Message = Constants.Message.SAVE_USER_FAIL
            };
        }

        public async Task<UserProfileResponse> GetUserProfile(int userId)
        {
            User u = await userRepository.GetUserByUserId(userId);
            if (u == null)
            {
                return new UserProfileResponse
                {
                    Success = false,
                    Message = Constants.Message.USER_DOES_NOT_EXISTED
                };
            }
            return new UserProfileResponse
            {
                Success = true,
                // Need auto mapper
                UserProfile = new UserProfileDTO
                {
                    Email = u.Email,
                    FullName = u.FullName,
                    Address = u.Address,
                    Phone = u.Phone
                }
            };
        }

        public async Task<TokenResponse> LoginAsync(LoginRequest loginRequest)
        {
            User user = await userRepository.GetByEmail(loginRequest.Email);

            if (user == null || !user.Active)
            {
                return new TokenResponse
                {
                    Success = false,
                    Message = Constants.Message.USERNAME_NOT_FOUND
                };
            }
            var passwordHash = PasswordHelper.HashUsingPbkdf2(loginRequest.Password, Convert.FromBase64String(user.PasswordSalt));

            if (user.Password != passwordHash)
            {
                return new TokenResponse
                {
                    Success = false,
                    Message = Constants.Message.INVALID_PASSWORD
                };
            }

            var token = await System.Threading.Tasks.Task.Run(() => tokenService.GenerateTokensAsync(user.UserId));

            return new TokenResponse
            {
                Success = true,
                AccessToken = token.Item1,
                RefreshToken = token.Item2
            };
        }

        public async Task<LogoutResponse> LogoutAsync(int userId)
        {
            var refreshToken = await tokenRepository.GetRefreshTokenByUserIdAsync(userId);

            if (refreshToken == null)
            {
                return new LogoutResponse { Success = true, Message = Constants.Message.LOGOUT_SUCCESS };
            }
            bool removed = await tokenRepository.RemoveRefreshTokenByUserIdAsync(userId);

            if (removed)
            {
                return new LogoutResponse { Success = true , Message = Constants.Message.LOGOUT_SUCCESS };
            }

            return new LogoutResponse { Success = false, Message = Constants.Message.LOGOUT_FAIL };
        }
    }
}
