using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class LeagueFeeClubResponse : BaseResponse
    {
        public List<LeagueFeeClubDTO> Plan { get; set; } = new List<LeagueFeeClubDTO>();
        public decimal Total { get; set; }
        public int NoParticipate { get; set; }
        public string LeagueName { get; set; } = null!;
        public string ClubName { get; set; } = null!;
        public string? Logo { get; set; }
    }
}
