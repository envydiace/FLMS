﻿using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface UserService
    {
        Task<SignupResponse> CheckSignUp(SignupRequest signupRequest);
        Task<TokenResponse> LoginAsync(LoginRequest loginRequest);
        Task<LogoutResponse> LogoutAsync(int userId);
        Task<UserProfileResponse> GetUserProfile(int userId);
        Task<ChangePasswordResponse> ChangePass(ChangePasswordRequest changePasswordRequest, int UserId);
        Task<EditProfileResponse> EditProfile(EditProfileRequest request, int userId);
        Task<ForgotPassResponse> ForgotPassword(string email);
        Task<ChangeNewPassResponse> ChangeNewPass(ChangeNewPassRequest request);
    }
}
