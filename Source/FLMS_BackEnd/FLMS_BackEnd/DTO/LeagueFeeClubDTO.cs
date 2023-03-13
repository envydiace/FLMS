namespace FLMS_BackEnd.DTO
{
    public class LeagueFeeClubDTO
    {
        public int LeagueId { get; set; }
        public string ExpenseKey { get; set; } = null!;
        public string ExpenseName { get; set; } = null!;
        public decimal Cost { get; set; }
        public bool IsActual { get; set; }
        public string FeeType { get; set; } = null!;
    }
}
