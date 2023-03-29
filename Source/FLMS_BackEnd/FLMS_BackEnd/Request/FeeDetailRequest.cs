namespace FLMS_BackEnd.Request
{
    public class FeeDetailRequest
    {
        public int LeagueFeeId { get; set; }
        public string ExpenseName { get; set; } = null!;
        public decimal Cost { get; set; }
        public string FeeType { get;set; } = null!;
        public string FeeKey { get; set; } = null!; 
    }
}
