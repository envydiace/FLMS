using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.DTO
{
    public class LeagueTotalPrizeDTO
    {
        public League League { get; set; } = new League();
        public decimal? TotalPrize { get; set; }
    }
}
