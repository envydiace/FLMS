using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ClubHistoryResponse : BaseResponse
    {
        public List<MatchDTO> listMatch { get; set; }
    }
}
