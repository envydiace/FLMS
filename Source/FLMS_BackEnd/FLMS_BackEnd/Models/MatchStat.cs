using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class MatchStat
    {
        public int MatchStatId { get; set; }
        public int MatchId { get; set; }
        public bool IsHome { get; set; }
        public int Shot { get; set; }
        public int ShotOnTarget { get; set; }
        public int Conner { get; set; }
        public int Foul { get; set; }
        public int Offside { get; set; }
        public int YellowCard { get; set; }
        public int RedCard { get; set; }

        public virtual Match Match { get; set; } = null!;
    }
}
