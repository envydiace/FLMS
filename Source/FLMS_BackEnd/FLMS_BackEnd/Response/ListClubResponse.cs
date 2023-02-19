using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ListClubResponse : BaseResponse
    {
        public List<ClubDTO> Clubs { get; set; }
        public int Total { get; set; }
    }
}
