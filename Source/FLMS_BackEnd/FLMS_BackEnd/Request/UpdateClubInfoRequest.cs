using System.ComponentModel.DataAnnotations;

namespace FLMS_BackEnd.Request
{
    public class UpdateClubInfoRequest
    {
        [Required]
        public int ClubId { get; set; }
        public string? Logo { get; set; }
        public string? FanPage { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
    }
}
