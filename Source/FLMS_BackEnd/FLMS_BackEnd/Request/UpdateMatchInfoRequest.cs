namespace FLMS_BackEnd.Request
{
    public class UpdateMatchInfoRequest
    {
        public int MatchId { get; set; }
        public DateTime MatchDate { get; set; }
        public string? MatchTime { get; set; }
        public string? Stadium { get; set; }

    }
}
