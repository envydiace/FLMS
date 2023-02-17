namespace FLMS_BackEnd.DTO
{
    public class ClubDTO
    {
        public int ClubId { get; set; }
        public int UserId { get; set; }
        public string ClubName { get; set; } = null!;
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public string? SocialCont { get; set; }
        public DateTime CreateAt { get; set; }
    }
}
