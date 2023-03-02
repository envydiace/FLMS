using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ParticipationByLeagueResponse : BaseResponse
    {
        public List<ParticipationClubDTO> Clubs { get; set; } = new List<ParticipationClubDTO>();
    }
}
