using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class Request
    {
        public int RequestId { get; set; }
        public int LeagueId { get; set; }
        public int ClubId { get; set; }
        public string RequestType { get; set; } = null!;

        public virtual Club Club { get; set; } = null!;
        public virtual League League { get; set; } = null!;
    }
}
