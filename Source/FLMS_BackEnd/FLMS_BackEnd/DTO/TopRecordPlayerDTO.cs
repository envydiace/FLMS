namespace FLMS_BackEnd.DTO
{
    public class TopRecordPlayerDTO
    {
        public int PlayerId { get; set; }
        public string? PlayerName { get; set; } = null!;
        public string? Avatar { get; set; }
        public int Record { get; set; }
        public string ClubName { get; set; } = null!;
        public string? ClubLogo { get; set; }
    }
}
