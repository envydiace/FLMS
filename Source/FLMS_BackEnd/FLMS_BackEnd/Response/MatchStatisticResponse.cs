using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class MatchStatisticResponse : BaseResponse
    {
        public StatisticDTO Home { get; set; }
        public StatisticDTO Away { get; set; }
    }
}
