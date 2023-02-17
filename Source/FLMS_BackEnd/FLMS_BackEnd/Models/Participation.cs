using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Participation
    {
        public int LeagueId { get; set; }
        public int ClubId { get; set; }

        public virtual Club Club { get; set; } = null!;
        public virtual League League { get; set; } = null!;
    }
}
