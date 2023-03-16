namespace FLMS_BackEnd.Request
{
    public class UpdateMatchInfoRequest
    {
        public int MatchId { get; set; }
        public string? matchDate { get; set; }
        public string? matchTime { get; set; }
        public string? Stadium { get; set; }

    }
}
