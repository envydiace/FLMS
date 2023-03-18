using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ListPlayerSearchResponse : BaseResponse
    {
        public List<PlayerSearchDTO> Players { get; set; }
    }
}
