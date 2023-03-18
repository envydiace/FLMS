using FLMS_BackEnd.DTO;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class MatchSquadResponse : BaseResponse
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public SquadDTO? Home { get; set; }
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public SquadDTO? Away { get; set; }
    }
}
