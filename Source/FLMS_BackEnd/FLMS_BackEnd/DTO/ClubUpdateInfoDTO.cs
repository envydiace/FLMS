namespace FLMS_BackEnd.DTO
{
    public class ClubUpdateInfoDTO
    {
        public string ClubName { get; set; } = null!;
        public string? Logo { get; set; }
        public string? FanPage { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
    }
}
