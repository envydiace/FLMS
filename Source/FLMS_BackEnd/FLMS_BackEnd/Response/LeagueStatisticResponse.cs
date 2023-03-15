using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class LeagueStatisticResponse : BaseResponse
    {
        int LeagueId { get; set; }
        string LeagueType { get; set; } = null!;
        public List<LeagueStandingDTO> LeagueStanding { get; set; } = new List<LeagueStandingDTO>();
        public List<TopRecordPlayerDTO> TopScore { get; set; } = new List<TopRecordPlayerDTO>();
        public List<TopRecordPlayerDTO> TopAssist { get; set; } = new List<TopRecordPlayerDTO>();

    }
}
