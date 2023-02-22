namespace FLMS_BackEnd.Utils
{
    public static class MethodUtils
    {
        public static bool CheckLeagueType(string type)
        {
            return Enum.GetValues(typeof(Constants.LeagueType))
                .Cast<Constants.LeagueType>()
                .Select(v => v.ToString())
                .ToList().Contains(type);
        }

        public static bool CheckUserRole(string role)
        {
            return Enum.GetValues(typeof(Constants.SystemRole))
                .Cast<Constants.SystemRole>()
                .Select(v => v.ToString())
                .ToList().Contains(role);
        }
    }
}
