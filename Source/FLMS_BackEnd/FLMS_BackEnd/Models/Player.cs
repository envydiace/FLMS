using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Player
    {
        public Player()
        {
            MatchEventMains = new HashSet<MatchEvent>();
            MatchEventSupports = new HashSet<MatchEvent>();
            PlayerClubs = new HashSet<PlayerClub>();
            SquadPositions = new HashSet<SquadPosition>();
        }

        public int PlayerId { get; set; }
        public string Name { get; set; } = null!;
        public string NickName { get; set; } = null!;
        public DateTime? Dob { get; set; }
        public string? Height { get; set; }
        public string? Weight { get; set; }
        public string? Address { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }
        public string? SocialCont { get; set; }
        public string? Avatar { get; set; }

        public virtual ICollection<MatchEvent> MatchEventMains { get; set; }
        public virtual ICollection<MatchEvent> MatchEventSupports { get; set; }
        public virtual ICollection<PlayerClub> PlayerClubs { get; set; }
        public virtual ICollection<SquadPosition> SquadPositions { get; set; }
    }
}
