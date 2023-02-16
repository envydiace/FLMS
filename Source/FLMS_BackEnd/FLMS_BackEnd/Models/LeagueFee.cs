using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class LeagueFee
    {
        public int LeagueFeeId { get; set; }
        public int? LeagueId { get; set; }
        public string? ExpenseKey { get; set; }
        public string? ExpenseName { get; set; }
        public double? Cost { get; set; }

        public virtual League? League { get; set; }
    }
}
