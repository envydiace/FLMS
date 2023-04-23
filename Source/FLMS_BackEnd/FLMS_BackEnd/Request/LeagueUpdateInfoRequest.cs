namespace FLMS_BackEnd.Request
{
    public class LeagueUpdateInfoRequest
    {
        public int LeagueId { get; set; }
        public string LeagueName { get; set; } = null!;
        public string? Location { get; set; }
        public string? Fanpage { get; set; }
        public string? Logo { get; set; }
        public string Status { get; set; } = null!;
    }
}
