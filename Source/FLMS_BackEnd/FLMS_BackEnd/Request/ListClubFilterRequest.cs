namespace FLMS_BackEnd.Request
{
    public class ListClubFilterRequest
    {
        public string? searchClubName { get; set; }
        public string? searchManagerName { get; set; }
        public int page { get; set; }
        public int pageSize { get; set; }
    }
}
