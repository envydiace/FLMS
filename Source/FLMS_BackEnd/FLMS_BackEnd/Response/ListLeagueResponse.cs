using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ListLeagueResponse : BasePagingResponse
    {
        public List<LeagueDTO> Leagues { get; set; }
    }
}
