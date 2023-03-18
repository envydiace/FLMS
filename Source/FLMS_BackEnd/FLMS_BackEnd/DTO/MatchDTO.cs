namespace FLMS_BackEnd.DTO
{
    public class MatchDTO
    {
        public int MatchId { get; set; }
        public int LeagueId { get; set; }
        public string LeagueName { get; set; } = null!;
        public string? Round { get; set; }
        public string? Stadium { get; set; }
        public string MatchDate { get; set; } = null!;
        public string MatchTime { get; set; } = null!;
        public bool IsFinish { get; set; }
        public virtual ClubMatchDTO Away { get; set; } = null!;
        public virtual ClubMatchDTO Home { get; set; } = null!;

    }
}
