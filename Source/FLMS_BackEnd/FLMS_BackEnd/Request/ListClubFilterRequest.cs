using FLMS_BackEnd.Utils;

namespace FLMS_BackEnd.Request
{
    public class ListClubFilterRequest
    {
        public string? Search { get; set; }
        public int Page { get; set; } = Constants.DEFAULT_PAGE;
        public int PageSize { get; set; } = Constants.DEFAULT_CLUB_PAGE_SIZE;
    }
}
