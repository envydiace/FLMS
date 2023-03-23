using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Request
{
    public class UpdateSquadRequest
    {
        public int SquadId { get; set; }
        public List<int?> Mains { get; set; } = new List<int?>();
        public List<int?> Subs { get; set; } = new List<int?>();
    }
}
