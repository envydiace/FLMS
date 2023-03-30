namespace FLMS_BackEnd.DTO
{
    public class LeagueStandingDTO
    {
        public int Standing { get; set; }
        public string ClubName { get; set; } = null!;
        public int Pl { get { return Won + Draw + Loss; } }
        public int Won { get; set; } = 0;
        public int Draw { get; set; } = 0;
        public int Loss { get; set; } = 0;
        public int GoalsFor { get; set; } = 0;
        public int GoalsAgainst { get; set; } = 0;
        public int GD { get { return GoalsFor - GoalsAgainst; } }
        public int Point { get { return Won * 3 + Draw; } }
        public List<string> History { get; set; } = new List<string>(new string[] { "W", "D", "L" });

    }
}
