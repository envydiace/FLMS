using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ClubScheduleResponse : BaseResponse
    {
        public List<MatchClubDTO> listMatch { get; set; }
    }
}
