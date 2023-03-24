using FLMS_BackEnd.Utils;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class BaseResponse
    {
        [JsonIgnore()]
        public bool Success { get; set; }

        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? MessageCode { get; set; } = null;

        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Message { get { return MessageCode != null ? Constants.SystemMessage.GetValueOrDefault(MessageCode) : null; } }
    }
}
