using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Squad
    {
        public Squad()
        {
            SquadPositions = new HashSet<SquadPosition>();
        }

        public int SquadId { get; set; }
        public int MatchId { get; set; }
        public bool IsHome { get; set; }
        public int NoPlayerSquad { get; set; }

        public virtual Match Match { get; set; } = null!;
        public virtual ICollection<SquadPosition> SquadPositions { get; set; }
    }
}
