using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class LeagueFee
    {
        public int LeagueFeeId { get; set; }
        public int LeagueId { get; set; }
        public string ExpenseKey { get; set; } = null!;
        public string ExpenseName { get; set; } = null!;
        public decimal Cost { get; set; }
        public bool IsActual { get; set; }
        public string FeeType { get; set; } = null!;

        public virtual League League { get; set; } = null!;
    }
}
