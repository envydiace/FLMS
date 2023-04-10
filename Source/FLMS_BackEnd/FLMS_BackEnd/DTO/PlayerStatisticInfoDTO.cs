namespace FLMS_BackEnd.DTO
{
    public class PlayerStatisticInfoDTO
    {
        public int PlayerId { get; set; }
        public string Name { get; set; } = null!;
        public int Goal { get; set; }
        public int Assistant { get; set; }
        public int RedCard { get; set; }
        public int YellowCard { get; set; }
        public string? Avatar { get; set; }
        public int Number { get; set; }
    }
}
