using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class User
    {
        public User()
        {
            Clubs = new HashSet<Club>();
            Leagues = new HashSet<League>();
            RefreshTokens = new HashSet<RefreshToken>();
        }

        public int UserId { get; set; }
        public string Email { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string PasswordSalt { get; set; } = null!;
        public string FullName { get; set; } = null!;
        public string? Phone { get; set; }
        public string? Address { get; set; }
        public bool Active { get; set; }
        public DateTime CreateAt { get; set; }
        public string Role { get; set; } = null!;
        public string? Avatar { get; set; }
        public string? ResetToken { get; set; }
        public DateTime? TokenExpire { get; set; }

        public virtual ICollection<Club> Clubs { get; set; }
        public virtual ICollection<League> Leagues { get; set; }
        public virtual ICollection<RefreshToken> RefreshTokens { get; set; }
    }
}
