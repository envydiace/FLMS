using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class RequestListResponse: BaseResponse
    {
        public List<RequestDTO> requests { get; set; } 
    }
}
