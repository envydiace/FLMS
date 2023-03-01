namespace FLMS_BackEnd.Request
{
    public class ListRequestFilterRequest
    {
        public DateTime? From { get; set; }
        public DateTime? To { get; set; }
        public string? Type { get; set; }
        public string? Status { get; set; }
    }
}
