using FLMS_BackEnd.DTO;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class PlayerResponse :BaseResponse
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public PlayerDTO PlayerInfo { get; set; }
    }
}
