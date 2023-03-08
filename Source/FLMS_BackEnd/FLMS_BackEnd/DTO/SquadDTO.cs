namespace FLMS_BackEnd.DTO
{
    public class SquadDTO
    {
        public int SquadId { get; set; }
        public int MatchId { get; set; }
        public bool IsHome { get; set; }
        public int NoPlayerSquad { get; set; }
        public virtual List<SquadPositionDTO> StartingSquad { get; set; } = new List<SquadPositionDTO>();
        public virtual List<SquadPositionDTO> Substitution { get; set; } = new List<SquadPositionDTO>();
    }
}
