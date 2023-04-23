namespace FLMS_BackEnd.DTO
{
    public class IncomingMatchDTO
    {
        public string MatchDate { get; set; } = null!;
        public string MatchTime { get; set; } = null!;
        public string LeagueName { get; set; } = null!;
        public string ClubName { get; set; } = null!;
        public string? ClubLogo { get; set; }
        public string Against { get; set; } = null!;
        public string? AgainstLogo { get; set; }
        public string? Round { get; set; }
        public string? Stadium { get; set; }
        public string Ha { get; set; } = null!; 
        public int SquadId { get; set; }
    }
}
