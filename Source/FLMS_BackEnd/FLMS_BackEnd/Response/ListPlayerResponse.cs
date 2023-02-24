using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ListPlayerResponse : BaseResponse
    {
        public List<PlayerDTO> Players { get; set; }
    }
}
