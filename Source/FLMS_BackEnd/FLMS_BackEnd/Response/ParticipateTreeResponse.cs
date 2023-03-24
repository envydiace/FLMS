using FLMS_BackEnd.DTO;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class ParticipateTreeResponse : BaseResponse
    {
        public List<ParticipateTreeNodeDTO> ListNode { get; set; } = new List<ParticipateTreeNodeDTO>();
        public int LeagueId { get; set; }
        public bool CanEdit { get; set; } = false;
        public int NumberOfNode { get; set; }
        public int TreeHeight { get; set; }
    }
}
