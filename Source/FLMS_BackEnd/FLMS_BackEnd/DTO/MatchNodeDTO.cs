namespace FLMS_BackEnd.DTO
{
    public class MatchNodeDTO
    {
        public int Deep { get; set; }
        public int? ParentId { get; set; }
        public List<ParticipationNodeTreeDTO> Participation { get; set; } = new List<ParticipationNodeTreeDTO>();
    }
}
