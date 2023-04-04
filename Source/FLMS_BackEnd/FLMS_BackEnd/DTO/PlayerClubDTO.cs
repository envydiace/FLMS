namespace FLMS_BackEnd.DTO
{
    public class PlayerClubDTO
    {
        public int PlayerId { get; set; }
        public string ClubName { get; set; } = null!;
        public string? ClubLogo { get; set; }
        public int ClubId { get; set; }
        public int Number { get; set; }
    }
}
