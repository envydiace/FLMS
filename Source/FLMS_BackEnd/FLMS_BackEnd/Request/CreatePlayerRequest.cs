using FLMS_BackEnd.Models;
using System.ComponentModel.DataAnnotations;

namespace FLMS_BackEnd.Request
{
    public class CreatePlayerRequest
    {
        public string Name { get; set; } = null!;
        public string NickName { get; set; } = null!;
        public DateTime? Dob { get; set; }
        public string? Height { get; set; }
        public string? Weight { get; set; }
        public string? Address { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }
        public string? SocialCont { get; set; }
        public virtual ICollection<PlayerClubRequest> PlayerClubs { get; set; }

    }
}
