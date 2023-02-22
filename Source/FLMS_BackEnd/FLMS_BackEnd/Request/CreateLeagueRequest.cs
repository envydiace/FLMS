namespace FLMS_BackEnd.Request
{
    public class CreateLeagueRequest
    {
        public string LeagueName { get; set; } = null!;
        public int NoParticipate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int MaxNoPlayer { get; set; }
        public int NoPlayerSquad { get; set; }
        public string? Location { get; set; }
        public string? Fanpage { get; set; }
        public virtual ICollection<LeagueFeeRequest> LeagueFees { get; set; }
    }
}
