using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class MatchStat
    {
        public int MatchStatId { get; set; }
        public int MatchId { get; set; }
        public bool IsHome { get; set; }

        public virtual Match Match { get; set; } = null!;
    }
}
