using System.ComponentModel.DataAnnotations;

namespace FLMS_BackEnd.Request
{
    public class UpdateClubRequest
    {
        [Required]
        public int ClubId { get; set; }
        [Required]
        public string? ClubName { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public string? SocialCont { get; set; }
    }
}
