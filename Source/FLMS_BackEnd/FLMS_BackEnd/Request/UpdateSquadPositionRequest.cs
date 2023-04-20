using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Request
{
    public class UpdateSquadPositionRequest
    {
        public int SquadId { get; set; }
        public List<PositionCoordinateUpdateDTO?> Mains { get; set; } = new List<PositionCoordinateUpdateDTO?>();
        public List<PositionCoordinateUpdateDTO?> Subs { get; set; } = new List<PositionCoordinateUpdateDTO?>();
    }
}
