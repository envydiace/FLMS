namespace FLMS_BackEnd.DTO
{
    public class TopLeaguePrizeDTO
    {
        public int LeagueId { get; set; }
        public string LeagueName { get; set; } = null!;
        public string? Logo { get; set; }
        public decimal? TotalPrize { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }
}
