using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Club
    {
        public Club()
        {
            ClubClones = new HashSet<ClubClone>();
            ClubLeagues = new HashSet<ClubLeague>();
            ParticipateRequests = new HashSet<ParticipateRequest>();
            Participations = new HashSet<Participation>();
            PlayerClubs = new HashSet<PlayerClub>();
        }

        public int ClubId { get; set; }
        public int UserId { get; set; }
        public string ClubName { get; set; } = null!;
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public string? SocialCont { get; set; }
        public DateTime CreateAt { get; set; }
        public string? Logo { get; set; }
        public string? Kit { get; set; }

        public virtual User User { get; set; } = null!;
        public virtual ICollection<ClubClone> ClubClones { get; set; }
        public virtual ICollection<ClubLeague> ClubLeagues { get; set; }
        public virtual ICollection<ParticipateRequest> ParticipateRequests { get; set; }
        public virtual ICollection<Participation> Participations { get; set; }
        public virtual ICollection<PlayerClub> PlayerClubs { get; set; }
    }
}
