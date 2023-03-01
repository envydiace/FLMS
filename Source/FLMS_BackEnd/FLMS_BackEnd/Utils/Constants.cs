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
        public enum LeagueType
        {
            KO, TABLE, LEAGUE
        }

        public enum RequestType
        {
            Invite, Register
        }
        public enum RequestStatus
        {
            Pending, Accepted, Rejected
        }

        public static readonly Dictionary<string, string> SystemMessage = new Dictionary<string, string>
        {
            {"ER-CO-01","Something happend" },

            {"MS-US-01","Get User Success" },
            {"MS-US-02","Sign up success" },
            {"MS-US-03","Logout Success" },
            {"ER-US-01","Request fail" },
            {"ER-US-02","E-mail is being used" },
            {"ER-US-03","Re-entered password need to be the same with password" },
            {"ER-US-04","Invalid Role" },
            {"ER-US-05","Password needs to be at least 6 characters" },
            {"ER-US-06","Unable to save the user" },
            {"ER-US-07","User does not existed" },
            {"ER-US-08","Incorrrect username or password. Please check again." },
            {"ER-US-09","Unable to logout user" },
            {"ER-US-10","Invalid session or user is already logged out" },
            {"ER-US-11","Invalid refresh token" },
            {"ER-US-12","Refresh token has expired" },
            {"ER-US-13","Missing login details" },
            {"ER-US-14","Missing refresh token details" },

            {"ER-CL-01","Cannot remove the club because there's still (a) players in the club" },
            {"ER-CL-02","Club doesn't existed" },
            {"ER-CL-03","User doesn't have permission to delete this club" },
            {"ER-CL-04","Delete club failled" },
            {"ER-CL-05","Create club failled" },
            {"ER-CL-06","Update club failled" },
            {"ER-CL-07","Club name already existed" },
            {"ER-CL-08","Club doesn't belong to user" },
            {"MS-CL-01","Club removed successfully" },
            {"MS-CL-02","Create club success" },
            {"MS-CL-03","Update club success" },

            {"MS-LE-01","Create league success" },
            {"ER-LE-01","Create league fail" },
            {"ER-LE-02","League name existed" },
            {"ER-LE-03","End date must after start date" },
            {"ER-LE-04","League Type is not valid" },
            {"ER-LE-05","League doesn't exist" },
            {"ER-LE-06","League doesn't belong to user" },

            {"MS-PL-01","Add player successfully"},
            {"MS-PL-02","Player deleted successfully"},
            {"ER-PL-01","Add player failed!" },
            {"ER-PL-02","Player does not exist!" },
            {"ER-PL-03","Update player failed!" },
            {"ER-PL-04","Delete player failled!" },
            {"ER-PL-05","This player was already added in this club!" },

            {"ER-RE-01","This club already in the league" },
            {"ER-RE-02","This club has request to regist the league" },
            {"ER-RE-03","This club already be invited to join the league" },
            {"ER-RE-04","Send Invitation Fail" },
            {"ER-RE-05","Send Registration Fail" },
            {"ER-RE-06","Send Request Fail" },
            {"MS-RE-01","Send Invitation Success" },
            {"MS-RE-02","Send Registration Success" },
            {"MS-RE-03","Send Request Success" },

        };

        public static int DEFAULT_PAGE = 1;
        public static int DEFAULT_LEAGUE_PAGE_SIZE = 6;
        public static int DEFAULT_CLUB_PAGE_SIZE = 8;
    }
}
