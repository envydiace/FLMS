namespace FLMS_BackEnd.Request
{
    public class LeagueFeeRequest
    {
        public string ExpenseKey { get; set; } = null!;
        public string ExpenseName { get; set; } = null!;
        public double Cost { get; set; }
    }
}
