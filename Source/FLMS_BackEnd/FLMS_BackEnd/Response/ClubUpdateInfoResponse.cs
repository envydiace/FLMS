using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ClubUpdateInfoResponse : BaseResponse
    {
        public ClubUpdateInfoDTO Info { get; set; } = new ClubUpdateInfoDTO();
    }
}
