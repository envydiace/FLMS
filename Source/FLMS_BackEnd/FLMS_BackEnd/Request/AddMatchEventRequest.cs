namespace FLMS_BackEnd.Request
{
    public class AddMatchEventRequest
    {
        public int MainId { get; set; }
        public int? SubId { get; set; }
        public int MatchId { get; set; }
        public string EventType { get; set; } = null!;
        public int EventTime { get; set; }
        public bool IsHome { get; set; }
    }
}
