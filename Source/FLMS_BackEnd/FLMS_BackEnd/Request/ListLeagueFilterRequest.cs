using FLMS_BackEnd.Utils;

namespace FLMS_BackEnd.Request
{
    public class ListLeagueFilterRequest
    {
        public string? searchLeagueName { get; set; }
        public DateTime? from { get; set; }
        public DateTime? to { get; set; }
        public int page { get; set; } = Constants.DEFAULT_PAGE;
        public int pageSize { get; set; } = Constants.DEFAULT_LEAGUE_PAGE_SIZE;
    }
}
