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
        public const string TIME_FORMAT = "HH:mm";

        public const int TOP_EVENT_NUMBER = 3;

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
        public enum LeagueStatus
        {
            New, OnGoing, Finished
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
            public const string DefaultFeeKey = "Fx";
        }
        public static class LeagueStatistic
        {
            public const string WinKey = "W";
            public const string DrawKey = "D";
            public const string LossKey = "L";
        }
        public static class MailType
        {
            public const string Invitation = "Invitation";
            public const string Registration = "Registration";
            public const string Accept = "AcceptRequest";
            public const string Reject = "RejectRequest";
            public const string Cancel = "CancelRequest";
            public const string RemoveClub = "RemoveClub";
            public const string ConfirmFee = "ConfirmFee";
            public const string AnnounceMatch = "AnnounceMatch";
            public const string AnnounceSquad = "AnnounceSquad";
            public const string ForgotPass = "ForgotPass";
        }
        public static class MailSubject
        {
            public const string AnnounceMatch = "Reminder - Upcoming Match in 2 Days";
            public const string AnnounceSquad = "Reminder to review squad before tomorrow's match";
        }

        public static class DataColumn
        {
            public const string Time = "Time";
            public const string Date = "Date";
            public const string Home = "Home";
            public const string Away = "Away";
            public const string HomeScore = "Home Score";
            public const string AwayScore = "Away Score";
            public const string Round = "Round";
            public const string Stadium = "Stadium";
            public const string Status = "Status";
        }

        public const string FORGOTPASSLINK = "forgot-pass/";

        public const string HOME = "Home";
        public const string AWAY = "Away";

        public static readonly Dictionary<string, string> SystemMessage = new Dictionary<string, string>
        {
            {"ER-CO-01","Something happend" },

            {"MS-US-01","Get user success" },
            {"MS-US-02","Sign up success" },
            {"MS-US-03","Logout Success" },
            {"MS-US-04","Change password success" },
            {"MS-US-05","Edit profile success" },
            {"MS-US-06","An email with instructions on how to reset your password has been sent to your email address" },
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
            {"ER-US-18","Invalid token" },
            {"ER-US-19","Token has expired" },

            {"ER-CL-01","Cannot remove the club because there's still (a) players in the club" },
            {"ER-CL-02","Club doesn't existed" },
            {"ER-CL-03","User doesn't have permission to delete this club" },
            {"ER-CL-04","Delete club failled" },
            {"ER-CL-05","Create club failled" },
            {"ER-CL-06","Update club failled" },
            {"ER-CL-07","Club name already existed" },
            {"ER-CL-08","Club doesn't belong to user" },
            {"ER-CL-09","Clubs that have participated in some leagues cannot be deleted" },
            {"ER-CL-10","Clubs have sent some requests that cannot be deleted" },
            {"MS-CL-01","Club removed successfully" },
            {"MS-CL-02","Create club success" },
            {"MS-CL-03","Update club success" },

            {"MS-LE-01","Create league success" },
            {"MS-LE-02","Delete league success" },
            {"MS-LE-03","Update league info success" },
            {"MS-LE-04","Upload league rules success" },
            {"ER-LE-01","Create league fail" },
            {"ER-LE-02","League name existed" },
            {"ER-LE-03","Not enough date between start date and end date" },
            {"ER-LE-04","League Type is not valid" },
            {"ER-LE-05","League doesn't exist" },
            {"ER-LE-06","League doesn't belong to user" },
            {"ER-LE-07","This league has been finished" },
            {"ER-LE-08","Delete league fail" },
            {"ER-LE-09","Unable to delete a league that already has participation" },
            {"ER-LE-10","Wrong league type" },
            {"ER-LE-11","Update league info failed" },
            {"ER-LE-12","Upload league rules failed" },

            {"MS-PL-01","Add player successfully"},
            {"MS-PL-02","Player deleted successfully"},
            {"MS-PL-03","Update player successfully"},
            {"ER-PL-01","Add player failed!" },
            {"ER-PL-02","Player does not exist!" },
            {"ER-PL-03","Update player failed!" },
            {"ER-PL-04","Delete player failled!" },
            {"ER-PL-05","This player was already added in this club!" },
            {"ER-PL-06","This player not in this club!" },

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
            {"ER-PA-05","Remove club failed" },
            {"ER-PA-06","This position doesn't exist" },
            {"ER-PA-07","This position already have participation" },
            {"ER-PA-08","Add participation to position fail" },
            {"ER-PA-09","This participation not available" },
            {"ER-PA-10","This league has been started" },
            {"ER-PA-11","Can not add participation to this position" },
            {"MS-PA-01","Confirm success" },
            {"MS-PA-02","Remove club success" },
            {"MS-PA-03","Add participation to position success" },

            {"MS-FE-01","Add list cost success" },
            {"MS-FE-02","Delete cost success" },
            {"MS-FE-03","Update cost success" },
            {"ER-FE-01","No fees have been announced for this league" },
            {"ER-FE-02","League cost not found!" },
            {"ER-FE-03","Update league cost failed!" },
            {"ER-FE-04","Invalid cost type" },
            {"ER-FE-05","Can not edit plan cost when the league started" },
            {"ER-FE-06","Can not add plan cost when the league started" },
            {"ER-FE-07","Add list cost failed!" },
            {"ER-FE-08","Delete cost failed!" },
            {"ER-FE-09","Can not edit actual cost when the league finished" },
            {"ER-FE-10","Can not add actual cost when the league finished" },
            {"ER-FE-11","Can not delete plan cost when the league started" },
            {"ER-FE-12","Can not delete actual cost when the league finished" },

            {"MS-MAIL-01","You got a new invitation!!!" },
            {"MS-MAIL-02","You got a new registration!!!" },
            {"MS-MAIL-03","Your invitation has been accepted!!!" },
            {"MS-MAIL-04","Your registration has been accepted!!!" },
            {"MS-MAIL-05","Your invitation has been rejected :(" },
            {"MS-MAIL-06","Your registration has been rejected :(" },
            {"MS-MAIL-07","LeagueManager has canceled their invitation request" },
            {"MS-MAIL-08","ClubManager has canceled their registration request" },
            {"MS-MAIL-09","LeagueManager has removed your club from their league" },
            {"MS-MAIL-10","Password Reset Request" },

            {"MS-SQ-01","Add player to position success" },
            {"MS-SQ-02","Remove player from position success" },
            {"MS-SQ-03","Update squad success" },
            {"ER-SQ-01","Squad not found" },
            {"ER-SQ-02","Position not found" },
            {"ER-SQ-03","Position already have player" },
            {"ER-SQ-04","Can not add this player to position" },
            {"ER-SQ-05","Add player to position failed" },
            {"ER-SQ-06","Position doesn't have player to remove" },
            {"ER-SQ-07","Remove player from position failed" },
            {"ER-SQ-08","User doesn't have permission to add player to position" },
            {"ER-SQ-09","User doesn't have permission to remove player from position" },
            {"ER-SQ-10","Squad size does not valid" },
            {"ER-SQ-11","Update squad fail" },

            {"MS-MA-01","Finish match success" },
            {"MS-MA-02","Update match success" },
            {"ER-MA-01","Match not found" },
            {"ER-MA-02","This match has been finished" },
            {"ER-MA-03","This match is not belonged to this user" },
            {"ER-MA-04","Update match statistic failed" },
            {"ER-MA-05","Update match statistic successfully" },
            {"ER-MA-06","Match participation doesn't complete" },
            {"ER-MA-07","Club doesn't join the match" },
            {"ER-MA-08","Finish match fail" },
            {"ER-MA-09","The match date and time you entered must be between the start date and end date of the league" },
            {"ER-MA-10","Please select a date that is at least one day away from any existing matches." },
            {"ER-MA-11","Update match failed" },
            {"ER-MA-12","Please enter the date and time in the correct format (e.g. YYYY-MM-DD HH:MM) and try again." },
            {"ER-MA-13","Knock out match can not draw." },
            {"ER-MA-14","League participation doesn't complete." },

            {"MS-EV-01","Add match event success" },
            {"MS-EV-02","Delete match event success" },
            {"ER-EV-01","Main and sub can not the same player" },
            {"ER-EV-02","Invalid event type" },
            {"ER-EV-03","Main player invalid" },
            {"ER-EV-04","Add match event fail" },
            {"ER-EV-05","Sub player invalid" },
            {"ER-EV-06","Event doesn't exist" },
            {"ER-EV-07","Delete match event fail" },

            {"ER-CC-01","This club clone is not existed" },
        };

        public static readonly Dictionary<string, string> columnMapLeagueSchedule = new Dictionary<string, string>
        {
            { DataColumn.Time, "A" },
            { DataColumn.Date, "B" },
            { DataColumn.Home, "C" },
            { DataColumn.HomeScore, "D" },
            { DataColumn.AwayScore, "E" },
            { DataColumn.Away, "F" },
            { DataColumn.Round, "G" },
            { DataColumn.Stadium, "H" },
            { DataColumn.Status, "I" },
        };


        public static int DEFAULT_PAGE = 1;
        public static int DEFAULT_LEAGUE_PAGE_SIZE = 6;
        public static int DEFAULT_CLUB_PAGE_SIZE = 8;
    }
}
