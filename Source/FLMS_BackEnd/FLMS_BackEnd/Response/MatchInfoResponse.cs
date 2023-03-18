using FLMS_BackEnd.DTO;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class MatchInfoResponse : BaseResponse
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public MatchDTO? Match { get; set; }
    }
}
