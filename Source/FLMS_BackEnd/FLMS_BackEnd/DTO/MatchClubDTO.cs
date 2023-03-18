using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace FLMS_BackEnd.DTO
{
    public class MatchClubDTO
    {
        public int MatchId { get; set; }
        public int LeagueId { get; set; }
        public string LeagueName { get; set; } = null!;
        public string Against { get; set; } = null!;
        [JsonIgnore]
        public int HomeId { get; set; }
        [JsonIgnore]
        public int AwayId { get; set; }
        public string MatchDate { get; set; } = null!;
        public string MatchTime { get; set; } = null!;
        public bool IsFinish { get; set; }
        public string HA {get;set;} = null!;
        public string? Round { get; set; }
        public string? Stadium {get; set; }

    }
}
