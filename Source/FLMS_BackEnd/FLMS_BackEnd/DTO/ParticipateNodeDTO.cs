namespace FLMS_BackEnd.DTO
{
    public class ParticipateNodeDTO
    {
        public int ParticipateId { get; set; }
        public int ClubId { get; set; }
        public int ParentParticipate { get; set; }
        public int LeftParticipate { get; set; }
        public int RightParticipate { get; set; }
    }
}
