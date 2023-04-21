using FLMS_BackEnd.Listeners;
using FLMS_BackEnd.Listeners.Events;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api")]
    [ApiController]
    public class UserController : BaseApiController
    {
        private readonly UserService userService;
        private readonly TokenService tokenService;
        private readonly SendMailEventHandler sendMailEventHandler;
        public UserController(UserService userService, TokenService tokenService, SendMailEventHandler sendMailEventHandler, IMailService mailService)
        {
            this.userService = userService;
            this.tokenService = tokenService;
            this.sendMailEventHandler = sendMailEventHandler;

            sendMailEventHandler.SendMailEventArgs += async (sender, args) =>
            {
                bool sendResult = await mailService.SendEmailAsync(args.MailRequest, new CancellationToken());
                if (!sendResult)
                {
                    Console.WriteLine($"Failed to send email: {args.MailRequest}" );
                }
            };
        }
        [HttpPut("[action]")]
        [Authorize]
        public async Task<ActionResult<ChangePasswordResponse>> ChangePassword(ChangePasswordRequest changePasswordRequest)
        {
            try
            {
                ChangePasswordResponse response = await userService.ChangePass(changePasswordRequest, UserID);
                if (response.Success)
                {
                    return Ok(response);
                }
                else
                {
                    return BadRequest(response);
                }
            }
            catch (Exception)
            {
                return BadRequest(new ChangePasswordResponse { MessageCode = "ER-CO-01" });
            }
        }
        [HttpPut("[action]")]
        [Authorize]
        public async Task<ActionResult<EditProfileResponse>> EditProfile(EditProfileRequest request)
        {
            try
            {
                var response = await userService.EditProfile(request, UserID);
                if (response.Success)
                {
                    return Ok(response);
                }
                else
                {
                    return BadRequest(response);
                }
            }
            catch (Exception)
            {
                return BadRequest(new EditProfileResponse { MessageCode = "ER-CO-01" });
            }
        }
        [HttpPost("[action]")]
        public async Task<ActionResult<SignupResponse>> Signup(SignupRequest signupRequest)
        {
            try
            {
                SignupResponse response = await userService.CheckSignUp(signupRequest);
                if (response.Success)
                {
                    return Ok(response);
                }
                else
                {
                    return BadRequest(response);
                }
            }
            catch (Exception)
            {
                return BadRequest(new SignupResponse { MessageCode = "ER-CO-01" });
            }
        }

        [HttpPost("[action]")]
        public async Task<ActionResult<TokenResponse>> Login(LoginRequest loginRequest)
        {
            try
            {
                if (loginRequest == null || string.IsNullOrEmpty(loginRequest.Email) || string.IsNullOrEmpty(loginRequest.Password))
                {
                    return BadRequest(new TokenResponse
                    {
                        Success = false,
                        MessageCode = "ER-US-13"
                    });
                }

                TokenResponse loginResponse = await userService.LoginAsync(loginRequest);

                if (!loginResponse.Success)
                {
                    return BadRequest(loginResponse);
                }

                return Ok(loginResponse);
            }
            catch (Exception)
            {
                return BadRequest(new TokenResponse { MessageCode = "ER-CO-01" });
            }
        }

        [Authorize]
        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> Logout()
        {
            var logout = await userService.LogoutAsync(UserID);

            if (!logout.Success)
            {
                return BadRequest(logout);
            }
            return Ok();
        }

        [HttpPost]
        [Route("refresh_token")]
        public async Task<ActionResult<TokenResponse>> RefreshToken(RefreshTokenRequest refreshTokenRequest)
        {
            if (refreshTokenRequest == null || string.IsNullOrEmpty(refreshTokenRequest.RefreshToken) || refreshTokenRequest.UserId == 0)
            {
                return BadRequest(new TokenResponse
                {
                    MessageCode = "ER-US-14"
                });
            }

            var validateRefreshTokenResponse = await tokenService.ValidateRefreshTokenAsync(refreshTokenRequest);

            if (!validateRefreshTokenResponse.Success)
            {
                return BadRequest(validateRefreshTokenResponse);
            }

            return Ok(validateRefreshTokenResponse);
        }

        [Authorize]
        [HttpGet]
        [Route("[action]")]
        public async Task<ActionResult<UserProfileResponse>> GetUserProfile()
        {
            var response = await userService.GetUserProfile(UserID);
            if (response.Success)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }

        [HttpPost("[action]")]
        public async Task<ActionResult<ForgotPassResponse>> ForgotPass(string email)
        {
            var response = await userService.ForgotPassword(email);
            if (response.Success)
            {
                MailRequest mailRequest = new MailRequest
                {
                    To = new List<string> {
                       response.MailData.Email
                    },
                    Subject = response.MailMessage,
                    MailType = Constants.MailType.ForgotPass,
                    MailData = response.MailData
                };
                await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequest });
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }

        [HttpPost("[action]")]
        public async Task<ActionResult<ChangeNewPassResponse>> ChangeNewPass(ChangeNewPassRequest request)
        {
            var response = await userService.ChangeNewPass(request);
            if (response.Success)
            {

                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }
    }
}
