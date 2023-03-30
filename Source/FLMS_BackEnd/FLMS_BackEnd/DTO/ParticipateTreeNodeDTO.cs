namespace FLMS_BackEnd.DTO
{
    public class ParticipateTreeNodeDTO
    {
        public int NodeId { get; set; }
        public int Deep { get; set; }
        public int? ParentId { get; set; }
        public int? LeftId { get; set; }
        public int? RightId { get; set; }
        public bool HasChild { get; set; } 
        public int Score { get; set; }
        public ClubBasicInfoDTO? ClubBasicInfo { get; set; }
    }
}
