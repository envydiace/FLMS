namespace FLMS_BackEnd.Request
{
    public class EditProfileRequest
    {
        public string FullName { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string? Address { get; set; }
        public string? Avatar { get; set; } 
    }
}
