namespace FLMS_BackEnd.DTO
{
    public class ParticipationClubDTO
    {
        public int LeagueId { get; set; }
        public int ClubId { get; set; }
        public bool Confirmed { get; set; }
        public string ClubName { get; set; } = null!;
        public string? Logo { get; set; } 
    }
}
