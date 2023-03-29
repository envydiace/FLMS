using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Request
{
    public class AddLeagueFeeRequest
    {
        public int LeagueId { get; set; }
        public bool IsActual { get; set; }
        public List<AddFeeDTO> ListFees { get; set; } = new List<AddFeeDTO>();
    }
}
