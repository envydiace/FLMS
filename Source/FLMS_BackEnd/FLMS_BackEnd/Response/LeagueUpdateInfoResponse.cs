using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class LeagueUpdateInfoResponse : BaseResponse
    {
        public LeagueUpdateInfoDTO Info { get; set; } = new LeagueUpdateInfoDTO();
    }
}
