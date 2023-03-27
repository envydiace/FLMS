using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class LeagueKnockOutStatisticResponse : BaseResponse
    {
        public int LeagueId { get; set; }
        public string LeagueType { get; set; } = null!;
        public List<MatchNodeDTO> ListNode { get; set; } = new List<MatchNodeDTO>();
        public List<TopRecordPlayerDTO> TopScore { get; set; } = new List<TopRecordPlayerDTO>();
        public List<TopRecordPlayerDTO> TopAssist { get; set; } = new List<TopRecordPlayerDTO>();
    }
}
