using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ListLeagueResponse : BaseResponse
    {
        public List<LeagueDTO> Leagues { get; set; }
        public int Total { get; set; }
    }
}
