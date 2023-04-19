namespace FLMS_BackEnd.DTO
{
    public class SquadPositionDTO
    {
        public int SquadPositionId { get; set; }
        public int SquadId { get; set; }
        public string PositionKey { get; set; } = null!;
        public int? PlayerId { get; set; }
        public string? PlayerName { get; set; }
        public string? PlayerAvatar { get; set; }
        public int Number { get; set; }
        public CoordinateDTO Coordinate { get; set; } = new CoordinateDTO();
    }
}
