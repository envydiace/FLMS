using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ListClubResponse : BasePagingResponse
    {
        public List<ClubDTO> Clubs { get; set; }
    }
}
