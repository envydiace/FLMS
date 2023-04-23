using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class DeletePlayerResponse : BaseResponse
    {
        public PlayerInfoDTO Player { get; set; }
    }
}
