﻿namespace FLMS_BackEnd.Utils
{
    public class Constants
    {
        public enum SystemRole
        {
            MEMBER, MANAGER, ADMIN
        }
        public static class Role
        {
            public const string MEMBER = "MEMBER";
            public const string MANAGER = "MANAGER";
            public const string ADMIN = "ADMIN";
        }

        public static class Message
        {
            public const string REQUEST_FAIL = "Request fail!";
            public const string EMAIL_EXISTED = "Email existed!";
            public const string USERNAME_EXISTED = "Username existed!";
            public const string PASSWORD_DOES_NOT_MATCH = "Password and confirm password do not match!";
            public const string PASSWORD_IS_WEAK = "Password is weak!";
            public const string SAVE_USER_FAIL = "Unable to save the user!";
            public const string MISSING_LOGIN_DETAILS = "Missing login details!";
            public const string USERNAME_NOT_FOUND = "Username not found!";
            public const string INVALID_PASSWORD = "Invalid password!";
            public const string LOGOUT_SUCCESS = "Logout Success!";
            public const string LOGOUT_FAIL = "Unable to logout user!";
            public const string MISSING_REFRESH_TOKEN_DETAILS = "Missing refresh token details!";
            public const string INVALID_SESSION = "Invalid session or user is already logged out!";
            public const string INVALID_REFRESH_TOKEN = "Invalid refresh token!";
            public const string REFRESH_TOKEN_EXPIRED = "Refresh token has expired!";
        }
    }
}
