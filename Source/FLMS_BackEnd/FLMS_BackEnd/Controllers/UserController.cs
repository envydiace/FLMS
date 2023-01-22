using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : BaseApiController
    {
        private readonly UserService userService;
        public UserController(UserService userService)
        {
            this.userService = userService;
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
                return BadRequest(new SignupResponse { Message = e.Message });
            }
        }

        [HttpPost("[action]")]
        public async Task<ActionResult<TokenResponse>> Login(LoginRequest loginRequest)
        {
            try
            {
                if (loginRequest == null || string.IsNullOrEmpty(loginRequest.Username) || string.IsNullOrEmpty(loginRequest.Password))
                {
                    return BadRequest(new TokenResponse
                    {
                        Success = false,
                        Message = Constants.Message.MISSING_LOGIN_DETAILS
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
                return BadRequest(new TokenResponse { Message = e.Message });
            }
            
        }
    }
}
