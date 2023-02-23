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
            {"MS-CL-01","Club removed successfully" },
            {"MS-CL-02","Create club success" },

            {"MS-LE-01","Create league success" },
            {"ER-LE-01","Create league fail" },
            {"ER-LE-02","League name existed" },
            {"ER-LE-03","End date must after start date" },
            {"ER-LE-04","League Type is not valid" },

            {"MS-PL-01","Add player successfully"},
            {"MS-PL-02","Player deleted successfully"},
            {"ER-PL-01","Add player failed!" },
            {"ER-PL-02","Player does not exist!" },
            {"ER-PL-03","Update player failed!" },
            {"ER-PL-04","Delete player failled!" }

        };
    }
}
