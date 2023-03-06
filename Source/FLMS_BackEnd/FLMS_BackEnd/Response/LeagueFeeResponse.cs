using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class LeagueFeeResponse : BaseResponse
    {
        public List<LeagueFeeDTO> Plan { get; set; } = new List<LeagueFeeDTO>();
        public List<LeagueFeeDTO> Actual { get; set; } = new List<LeagueFeeDTO>();
    }
}
