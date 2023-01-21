using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class SignupResponse : BaseResponse
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string Username { get; set; }
    }
}
