namespace FLMS_BackEnd.Request
{
    public class PlayerForEventRequest
    {
        public int MatchId { get; set; }
        public string EventType { get; set; } = null!;
        public int ClubId { get; set; }
    }
}
