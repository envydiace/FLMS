namespace FLMS_BackEnd.Request
{
    public class LeaguePrizeRequest
    {
        public string ExpenseKey { get; set; } = null!;
        public string ExpenseName { get; set; } = null!;
        public decimal Cost { get; set; }
    }
}
