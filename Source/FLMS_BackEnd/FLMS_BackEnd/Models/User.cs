using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class User
    {
        public User()
        {
            Clubs = new HashSet<Club>();
            RefreshTokens = new HashSet<RefreshToken>();
        }

        public int UserId { get; set; }
        public string Username { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string PasswordSalt { get; set; } = null!;
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public bool Active { get; set; }
        public DateTime CreateAt { get; set; }
        public string Role { get; set; } = null!;

        public virtual ICollection<Club> Clubs { get; set; }
        public virtual ICollection<RefreshToken> RefreshTokens { get; set; }
    }
}
