using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class ParticipateNode
    {
        public ParticipateNode()
        {
            MatchAways = new HashSet<Match>();
            MatchHomes = new HashSet<Match>();
        }

        public int ParticipateNodeId { get; set; }
        public int ParticipateId { get; set; }
        public int? ClubCloneId { get; set; }
        public int Deep { get; set; }
        public int? ParentId { get; set; }
        public int? LeftId { get; set; }
        public int? RightId { get; set; }
        public int LeagueId { get; set; }

        public virtual ClubClone? ClubClone { get; set; }
        public virtual League League { get; set; } = null!;
        public virtual ICollection<Match> MatchAways { get; set; }
        public virtual ICollection<Match> MatchHomes { get; set; }
    }
}
