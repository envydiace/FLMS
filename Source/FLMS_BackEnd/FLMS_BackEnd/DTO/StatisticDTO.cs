namespace FLMS_BackEnd.DTO
{
    public class StatisticDTO
    {
        public int MatchId { get; set; }
        public bool IsHome { get; set; }
        public int Shot { get; set; }
        public int ShotOnTarget { get; set; }
        public int Conner { get; set; }
        public int Foul { get; set; }
        public int Offside { get; set; }
        public int YellowCard { get; set; }
        public int RedCard { get; set; }
    }
}
