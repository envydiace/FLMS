using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Request
{
    public class SaveLeagueTreeRequest
    {
        public int LeagueId { get; set; }
        public List<TreeNodeSaveDTO> ListNode { get; set; } = new List<TreeNodeSaveDTO>();
    }
}
