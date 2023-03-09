using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Request
{
    public class UpdateMatchStatRequest
    {
        public int MatchId { get; set; }
        public StatInfoDTO Home { get; set; } = new StatInfoDTO();
        public StatInfoDTO Away { get; set; } = new StatInfoDTO();
    }
}
