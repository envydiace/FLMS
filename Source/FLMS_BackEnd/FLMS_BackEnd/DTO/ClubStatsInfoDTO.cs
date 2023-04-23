namespace FLMS_BackEnd.DTO
{
    public class ClubStatsInfoDTO
    {
        public int ClubId { get; set; }
        public int UserId { get; set; }
        public string ClubName { get; set; } = null!;
        public string ManagerName { get; set; } = null!;
        public string? Logo { get; set; }
        public int Win { get; set; }
        public int Draw { get; set; }
        public int Lose { get; set; }
    }
}
