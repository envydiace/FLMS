using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class PlayerClub
    {
        public int PlayerId { get; set; }
        public int ClubId { get; set; }

        public virtual Club Club { get; set; } = null!;
        public virtual Player Player { get; set; } = null!;
    }
}
