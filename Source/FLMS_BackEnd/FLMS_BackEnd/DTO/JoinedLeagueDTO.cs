namespace FLMS_BackEnd.DTO
{
    public class JoinedLeagueDTO
    {
        public int LeagueId { get; set; }
        public int UserId { get; set; }
        public string LeagueName { get; set; } = null!;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string LeagueType { get; set; } = null!;
        public string? Logo { get; set; }
        public string Status { get; set; } = null!;
    }
}
