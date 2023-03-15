namespace FLMS_BackEnd.DTO
{
    public class LeagueByUserDTO
    {
        public int LeagueId { get; set; }
        public int UserId { get; set; }
        public string LeagueName { get; set; } = null!;
        public string? Logo { get; set; }
    }
}
