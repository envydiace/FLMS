﻿using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Club
    {
        public Club()
        {
            ClubClones = new HashSet<ClubClone>();
            ClubLeagues = new HashSet<ClubLeague>();
            PlayerClubs = new HashSet<PlayerClub>();
            Requests = new HashSet<Request>();
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
        public virtual ICollection<PlayerClub> PlayerClubs { get; set; }
        public virtual ICollection<Request> Requests { get; set; }
    }
}
