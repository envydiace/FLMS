using System;
using System.Collections.Generic;

namespace FLMS_BackEnd.Models
{
    public partial class SquadPosition
    {
        public int SquadPositionId { get; set; }
        public int SquadId { get; set; }
        public string PositionKey { get; set; } = null!;
        public int? PlayerId { get; set; }
        public double? CoordinateX { get; set; }
        public double? CoordinateY { get; set; }

        public virtual Player? Player { get; set; }
        public virtual Squad Squad { get; set; } = null!;
    }
}
