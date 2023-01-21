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

        public UserServiceImpl(UserRepository userRepository)
        {
            this.userRepository = userRepository;
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
            u = await userRepository.GetByUserName(signupRequest.Username);
            if (u != null)
            {
                return new SignupResponse
                {
                    Success = false,
                    Message = Constants.Message.USERNAME_EXISTED
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
                Username = signupRequest.Username,
                Email = signupRequest.Email,
                Password = passwordHash,
                PasswordSalt = Convert.ToBase64String(salt),
                FirstName = signupRequest.FirstName,
                LastName = signupRequest.LastName,
                CreateAt = DateTime.Now,
                Active = true // You can save is false and send confirmation email to the user, then once the user confirms the email you can make it true
            };

            bool created = await userRepository.CreateAsync(user);
            if (created)
            {
                return new SignupResponse
                {
                    Success = true,
                    Username = user.Username
                };
            }

            return new SignupResponse
            {
                Success = false,
                Message = Constants.Message.SAVE_USER_FAIL
            };
        }

        public async Task<User> GetUserByUsername(string username)
        {
            return await userRepository.GetByUserName(username);
        }
    }
}
