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
            Squads = new HashSet<Squad>();
        }

        public int MatchId { get; set; }
        public int LeagueId { get; set; }
        public int HomeId { get; set; }
        public int AwayId { get; set; }
        public DateTime MatchDate { get; set; }
        public bool IsFinish { get; set; }
        public string? Round { get; set; }
        public string? Stadium { get; set; }

        public virtual ParticipateNode Away { get; set; } = null!;
        public virtual ParticipateNode Home { get; set; } = null!;
        public virtual League League { get; set; } = null!;
        public virtual ICollection<MatchEvent> MatchEvents { get; set; }
        public virtual ICollection<MatchStat> MatchStats { get; set; }
        public virtual ICollection<Squad> Squads { get; set; }
    }
}
