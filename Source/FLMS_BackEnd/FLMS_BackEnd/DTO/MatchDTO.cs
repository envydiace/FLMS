namespace FLMS_BackEnd.DTO
{
    public class MatchDTO
    {
        public int MatchId { get; set; }
        public int LeagueId { get; set; }
        public DateTime MatchDate { get; set; }
        public bool IsFinish { get; set; }
        public virtual ClubMatchDTO Away { get; set; } = null!;
        public virtual ClubMatchDTO Home { get; set; } = null!;

    }
}
