using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Club
    {
        public int ClubId { get; set; }
        public string ClubName { get; set; } = null!;
        public int UserId { get; set; }
        public DateTime CreateAt { get; set; }

        public virtual User User { get; set; } = null!;
    }
}
