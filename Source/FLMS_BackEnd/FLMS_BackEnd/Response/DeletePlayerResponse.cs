using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class DeletePlayerResponse : BaseResponse
    {
        public PlayerDTO Player { get; set; }
    }
}
