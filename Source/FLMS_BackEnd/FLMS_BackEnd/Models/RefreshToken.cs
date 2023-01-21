using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class RefreshToken
    {
        public int TokenId { get; set; }
        public int UserId { get; set; }
        public string TokenHash { get; set; } = null!;
        public string TokenSalt { get; set; } = null!;
        public DateTime CreateAt { get; set; }
        public DateTime ExpiryDate { get; set; }

        public virtual User User { get; set; } = null!;
    }
}
