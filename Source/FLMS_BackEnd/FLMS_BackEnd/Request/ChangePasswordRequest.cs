using System.ComponentModel.DataAnnotations;

namespace FLMS_BackEnd.Request
{
    public class ChangePasswordRequest
    {
        [Required]
        public string OldPassword { get; set; } = null!;
        [Required]
        public string NewPassword { get; set; } = null!;
        [Required]
        public string RePassword { get; set; } = null!;
    }
}
