namespace FLMS_BackEnd.DTO
{
    public class MatchEventDTO
    {
        public int MatchEventId { get; set; }
        public int MatchId { get; set; }
        public string EventType { get; set; } = null!;
        public int EventTime { get; set; }
        public bool IsHome { get; set; }
        public virtual MatchEventPlayerDTO Main { get; set; } = null!;
        public virtual MatchEventPlayerDTO? Sub { get; set; }
    }
}
