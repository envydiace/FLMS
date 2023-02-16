using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class ClubLeague
    {
        public int ClubLeagueId { get; set; }
        public string ClubName { get; set; } = null!;
        public int? ClubId { get; set; }

        public virtual Club? Club { get; set; }
    }
}
