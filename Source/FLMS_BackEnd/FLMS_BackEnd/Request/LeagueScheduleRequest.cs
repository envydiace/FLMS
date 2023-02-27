namespace FLMS_BackEnd.Request
{
    public class LeagueScheduleRequest
    {
        public int LeagueId { get; set; }
        public DateTime? From { get; set; }
        public DateTime? To { get; set; }
        public string? SearchClubName { get; set; }
    }
}
