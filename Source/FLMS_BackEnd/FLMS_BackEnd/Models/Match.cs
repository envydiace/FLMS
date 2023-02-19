using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Match
    {
        public Match()
        {
            MatchEvents = new HashSet<MatchEvent>();
            MatchStats = new HashSet<MatchStat>();
        }

        public int MatchId { get; set; }
        public int LeagueId { get; set; }
        public int HomeId { get; set; }
        public int AwayId { get; set; }

        public virtual Club Away { get; set; } = null!;
        public virtual Club Home { get; set; } = null!;
        public virtual League League { get; set; } = null!;
        public virtual ICollection<MatchEvent> MatchEvents { get; set; }
        public virtual ICollection<MatchStat> MatchStats { get; set; }
    }
}
