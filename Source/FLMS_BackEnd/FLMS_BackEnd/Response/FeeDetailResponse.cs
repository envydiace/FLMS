using DocumentFormat.OpenXml.Presentation;
using FLMS_BackEnd.DTO;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class FeeDetailResponse : BaseResponse
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public LeagueFeeDTO FeeInfo { get; set; }
    }
}
