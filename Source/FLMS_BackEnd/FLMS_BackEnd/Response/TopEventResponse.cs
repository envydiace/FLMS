using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class TopEventResponse
    {
        public List<TopRecordPlayerDTO> TopScore { get; set; } = new List<TopRecordPlayerDTO>();
        public List<TopRecordPlayerDTO> TopAssist { get; set; } = new List<TopRecordPlayerDTO>();
    }
}
