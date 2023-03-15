using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class ClubClone
    {
        public ClubClone()
        {
            ParticipateNodes = new HashSet<ParticipateNode>();
        }

        public int ClubCloneId { get; set; }
        public int LeagueId { get; set; }
        public int? ClubId { get; set; }
        public string ClubCloneKey { get; set; } = null!;
        public int Won { get; set; }
        public int Draw { get; set; }
        public int Loss { get; set; }
        public int GoalsFor { get; set; }
        public int GoalsAgainst { get; set; }

        public virtual Club? Club { get; set; }
        public virtual League League { get; set; } = null!;
        public virtual ICollection<ParticipateNode> ParticipateNodes { get; set; }
    }
}
