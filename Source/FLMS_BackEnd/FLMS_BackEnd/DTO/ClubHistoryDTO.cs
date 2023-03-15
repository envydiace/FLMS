namespace FLMS_BackEnd.DTO
{
    public class ClubHistoryDTO
    {
        public int LeagueId { get; set; }
        public string LeagueName { get; set; } = null!;
        public DateTime JoinedDate { get; set; }
        public int Won { get; set; }
        public int Draw { get; set; }
        public int Loss { get; set; }
        public int Goal { get; set; }
        public string? Rank { get; set; } 
    }
}
