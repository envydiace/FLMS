using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class MatchEvent
    {
        public int MatchEventId { get; set; }
        public int MainId { get; set; }
        public int? SupportId { get; set; }
        public int MatchId { get; set; }
        public string EventType { get; set; } = null!;

        public virtual Player Main { get; set; } = null!;
        public virtual Match Match { get; set; } = null!;
        public virtual Player? Support { get; set; }
    }
}
