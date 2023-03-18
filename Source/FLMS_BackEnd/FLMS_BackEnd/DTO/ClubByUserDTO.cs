namespace FLMS_BackEnd.DTO
{
    public class ClubByUserDTO
    {
        public int ClubId { get; set; }
        public int UserId { get; set; }
        public string ClubName { get; set; } = null!;
        public string? Logo { get; set; }
    }
}
