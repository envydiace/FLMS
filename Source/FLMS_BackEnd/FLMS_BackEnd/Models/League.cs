using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class League
    {
        public League()
        {
            LeagueFees = new HashSet<LeagueFee>();
            Matches = new HashSet<Match>();
            Requests = new HashSet<Request>();
        }

        public int LeagueId { get; set; }
        public int UserId { get; set; }
        public string LeagueName { get; set; } = null!;
        public int NoParticipate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int MaxNoPlayer { get; set; }
        public int NoPlayerSquad { get; set; }
        public string? Location { get; set; }
        public string? Fanpage { get; set; }
        public DateTime CreateAt { get; set; }
        public string? Description { get; set; }
        public string LeagueType { get; set; } = null!;
        public int? NoRound { get; set; }

        public virtual User User { get; set; } = null!;
        public virtual ICollection<LeagueFee> LeagueFees { get; set; }
        public virtual ICollection<Match> Matches { get; set; }
        public virtual ICollection<Request> Requests { get; set; }
    }
}
