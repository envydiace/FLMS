using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class BaseResponse
    {
        [JsonIgnore()]
        public bool Success { get; set; }
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string ErrorCode { get; set; }
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string Message { get; set; }
    }
}
