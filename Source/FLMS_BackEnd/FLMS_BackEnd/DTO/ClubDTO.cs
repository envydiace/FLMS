namespace FLMS_BackEnd.DTO
{
    public class ClubDTO
    {
        public int ClubId { get; set; }
        public int UserId { get; set; }
        public string ClubName { get; set; } = null!;
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public DateTime CreateAt { get; set; }
        public string ManagerName { get; set; } = null!;
        public string? Logo { get; set; }
        public string? FanPage { get; set; }
        public int Win { get; set; }
        public int Draw { get; set; }
        public int Lose { get; set; }
    }
}
