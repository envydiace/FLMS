namespace FLMS_BackEnd.DTO
{
    public class LeagueFeeDTO
    {
        public int LeagueId { get; set; }
        public string ExpenseKey { get; set; } = null!;
        public string ExpenseName { get; set; } = null!;
        public double Cost { get; set; }
        public bool IsActual { get; set; }
    }
}
