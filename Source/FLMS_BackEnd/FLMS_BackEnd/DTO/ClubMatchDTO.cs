namespace FLMS_BackEnd.DTO
{
    public class ClubMatchDTO
    {
        public int ClubId { get; set; }
        public string Name { get; set; } = null!;
        public string? Logo { get; set; }
        public int Score { get; set; } = 0;
    }
}
