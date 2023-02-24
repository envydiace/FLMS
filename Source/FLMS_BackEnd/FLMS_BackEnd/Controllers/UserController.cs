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
        public UserController(UserService userService, TokenService tokenService)
        {
            this.userService = userService;
            this.tokenService = tokenService;
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
            catch (Exception e)
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
            catch (Exception e)
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
    }
}
