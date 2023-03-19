using DocumentFormat.OpenXml.Presentation;
using FLMS_BackEnd.Utils;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class BaseMailResponse : BaseResponse
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]

        public string? MessageMailCode { get; set; } = null;
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string MailMessage { get { return MessageMailCode != null ? Constants.SystemMessage.GetValueOrDefault(MessageMailCode) : null; } }
    }
}
