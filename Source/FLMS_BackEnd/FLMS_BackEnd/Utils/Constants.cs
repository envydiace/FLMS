using System.Collections.Generic;

namespace FLMS_BackEnd.Utils
{
    public class Constants
    {
        public enum SystemRole
        {
            CLUB_MANAGER, LEAGUE_MANAGER, ADMIN
        }
        public static class Role
        {
            public const string CLUB_MANAGER = "CLUB_MANAGER";
            public const string LEAGUE_MANAGER = "LEAGUE_MANAGER";
            public const string ADMIN = "ADMIN";
        }

        public static class Message
        {
            public static readonly Dictionary<string, string> Club = new Dictionary<string, string> {
                {"ER-CL-01","Cannot remove the club because there's still (a) players in the club" },
                {"ER-CL-02","Club doesn't existed" },
                {"ER-CL-02","Club doesn't existed" },
                {"MS-CL-02","Club removed successfully" }
            };
        }

        public static readonly Dictionary<string, string> SystemMessage = new Dictionary<string, string>
        {
            {"MS-US-01","Get User Success" },
            {"ER-CL-01","Cannot remove the club because there's still (a) players in the club" },
            {"ER-CL-02","Club doesn't existed" },
            {"ER-CL-03","User doesn't have permission to delete this club" },
            {"ER-CL-04","Delete club failled" },
            {"MS-CL-01","Club removed successfully" }


        };

        public static class MessageUser
        {
            public const string REQUEST_FAIL = "Request fail!";
            public const string EMAIL_EXISTED = "Email existed!";
            public const string USERNAME_EXISTED = "Username existed!";
            public const string PASSWORD_DOES_NOT_MATCH = "Password and confirm password do not match!";
            public const string PASSWORD_IS_WEAK = "Password is weak!";
            public const string INVALID_ROLE = "Invalid Role!";
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
            public const string USER_DOES_NOT_EXISTED = "User does not existed!";
        }
    }
}
