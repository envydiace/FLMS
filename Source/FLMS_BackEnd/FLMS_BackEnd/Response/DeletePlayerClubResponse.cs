using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class DeletePlayerClubResponse : BaseResponse
    {
        public PlayerClubDTO PlayerClub { get; set; }
    }
}
