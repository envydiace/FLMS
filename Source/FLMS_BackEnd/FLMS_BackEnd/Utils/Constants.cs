using System.Collections.Generic;

namespace FLMS_BackEnd.Utils
{
    public class Constants
    {
        public enum SystemRole
        {
            CLUB_MANAGER, LEAGUE_MANAGER, ADMIN
        }

        public const string DATE_FORMAT = "yyyy-MM-dd";
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
            Pending, Accepted, Rejected, Canceled
        }
        public enum RequestResponse
        {
            Accept, Reject, Cancel
        }
        public enum MatchEventType
        {
            Goal, OwnGoal, YellowCard, RedCard
        }
        public enum FeeType
        {
            Sponsored, Prize, Fee
        }
        public static class Fee
        {
            public const string SponsoredKey = "F0";
            public const string SponsoredName = "Sponsored";
            public const string FeeKey = "Ff";
        }

        public static readonly Dictionary<string, string> SystemMessage = new Dictionary<string, string>
        {
            {"ER-CO-01","Something happend" },

            {"MS-US-01","Get user success" },
            {"MS-US-02","Sign up success" },
            {"MS-US-03","Logout Success" },
            {"MS-US-04","Change password success" },
            {"MS-US-05","Edit profile success" },
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
            {"ER-US-15","Re-entered password and new password don't match" },
            {"ER-US-16","Incorrrect old password. Please check again" },
            {"ER-US-17","Edit profile fail" },

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
            {"ER-RE-07","Request doesn't exist" },
            {"ER-RE-08","Response Invalid" },
            {"ER-RE-09","Request has been response" },
            {"ER-RE-10","User don't have permission to accept this request" },
            {"ER-RE-11","User don't have permission to reject this request" },
            {"ER-RE-12","User don't have permission to cancel this request" },
            {"ER-RE-13","Response Fail" },
            {"ER-RE-14","This league has enough teams participating" },
            {"MS-RE-01","Send Invitation Success" },
            {"MS-RE-02","Send Registration Success" },
            {"MS-RE-03","Send Request Success" },
            {"MS-RE-04","Accept Success" },
            {"MS-RE-05","Reject Success" },
            {"MS-RE-06","Cancel Success" },

            {"ER-PA-01","Can not found this participation" },
            {"ER-PA-02","Confirm fail" },
            {"ER-PA-03","There's no more slot in the league" },
            {"ER-PA-04","This participation has been confirmed" },
            {"MS-PA-01","Confirm success" },

            {"ER-FE-01","No fees have been announced for this league" },
            {"ER-FE-02","League fee not found!" },
            {"ER-FE-03","Update league fee failed!" },

            {"MS-MAIL-01","You got a new invitation!!!" },
            {"MS-MAIL-02","You got a new registration!!!" },
            {"MS-MAIL-03","Your invitation has been accepted!!!" },
            {"MS-MAIL-04","Your registration has been accepted!!!" },
            {"MS-MAIL-05","Your invitation has been rejected :(" },
            {"MS-MAIL-06","Your registration has been rejected :(" },
            {"MS-MAIL-07","LeagueManager has canceled their invitation request" },
            {"MS-MAIL-08","ClubManager has canceled their registration request" },

            {"MS-SQ-01","Add player to position success" },
            {"MS-SQ-02","Remove player from position success" },
            {"ER-SQ-01","Squad not found" },
            {"ER-SQ-02","Position not found" },
            {"ER-SQ-03","Position already have player" },
            {"ER-SQ-04","Can not add this player to position" },
            {"ER-SQ-05","Add player to position failed" },
            {"ER-SQ-06","Position doesn't have player to remove" },
            {"ER-SQ-07","Remove player from position failed" },
            {"ER-SQ-08","User doesn't have permission to add player to position" },
            {"ER-SQ-09","User doesn't have permission to remove player from position" },

            {"ER-MA-01","Match not found" },
            {"ER-MA-02","This match has been finished" },
            {"ER-MA-03","This match is not belonged to this user" },
            {"ER-MA-04","Update match statistic failed" },
            {"ER-MA-05","Update match statistic successfully" },
            {"ER-MA-06","Match participation doesn't complete" },
            {"ER-MA-07","Club doesn't join the match" },

            {"MS-EV-01","Add match event success" },
            {"MS-EV-02","Delete match event success" },
            {"ER-EV-01","Main and sub can not the same player" },
            {"ER-EV-02","Invalid event type" },
            {"ER-EV-03","Main player invalid" },
            {"ER-EV-04","Add match event fail" },
            {"ER-EV-05","Sub player invalid" },
            {"ER-EV-06","Event doesn't exist" },
            {"ER-EV-07","Delete match event fail" },
        };

        public static int DEFAULT_PAGE = 1;
        public static int DEFAULT_LEAGUE_PAGE_SIZE = 6;
        public static int DEFAULT_CLUB_PAGE_SIZE = 8;
    }
}
