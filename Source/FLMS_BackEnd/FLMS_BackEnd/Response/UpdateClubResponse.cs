using FLMS_BackEnd.DTO;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class UpdateClubResponse : BaseResponse
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public ClubDTO ClubInfo { get; set; }
    }
}
