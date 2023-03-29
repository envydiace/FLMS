namespace FLMS_BackEnd.DTO
{
    public class AddFeeDTO
    {
        public string ExpenseName { get; set; } = null!;
        public decimal Cost { get; set; }
        public string FeeType { get; set; } = null!;
    }
}
