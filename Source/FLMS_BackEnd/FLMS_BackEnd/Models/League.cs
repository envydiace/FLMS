using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class League
    {
        public League()
        {
            ClubClones = new HashSet<ClubClone>();
            LeagueFees = new HashSet<LeagueFee>();
            Matches = new HashSet<Match>();
            ParticipateNodes = new HashSet<ParticipateNode>();
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
        public string? Logo { get; set; }

        public virtual User User { get; set; } = null!;
        public virtual ICollection<ClubClone> ClubClones { get; set; }
        public virtual ICollection<LeagueFee> LeagueFees { get; set; }
        public virtual ICollection<Match> Matches { get; set; }
        public virtual ICollection<ParticipateNode> ParticipateNodes { get; set; }
        public virtual ICollection<Request> Requests { get; set; }
    }
}
