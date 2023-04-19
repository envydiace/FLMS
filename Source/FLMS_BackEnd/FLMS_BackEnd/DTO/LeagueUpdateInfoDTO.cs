namespace FLMS_BackEnd.DTO
{
    public class LeagueUpdateInfoDTO
    {
        public int LeagueId { get; set; }
        public string LeagueName { get; set; } = null!;
        public string? Location { get; set; }
        public string? Fanpage { get; set; }
        public string? Logo { get; set; }
        public string Status { get; set; } = null!;
    }
}
