using FLMS_BackEnd.DTO;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.Response
{
    public class GetPlayerByClubManagerResponse : BaseResponse
    {

        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public PlayerByManagerDTO? PlayerInfo { get; set; }
    }
}
