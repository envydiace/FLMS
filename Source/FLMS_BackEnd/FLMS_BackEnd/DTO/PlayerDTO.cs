namespace FLMS_BackEnd.DTO
{
    public class PlayerDTO
    {
        public int PlayerId { get; set; }
        public string Name { get; set; } = null!;
        public string NickName { get; set; } = null!;
        public int? Number { get; set; }
        public DateTime? Dob { get; set; }
        public string? Height { get; set; }
        public string? Weight { get; set; }
        public string? Address { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }
        public string? SocialCont { get; set; }
    }
}
