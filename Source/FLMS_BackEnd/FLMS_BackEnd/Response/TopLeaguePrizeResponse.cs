using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class TopLeaguePrizeResponse : BaseResponse
    {
        public List<TopLeaguePrizeDTO> TopLeaguePrizes { get; set; } = new List<TopLeaguePrizeDTO>();
    }
}
