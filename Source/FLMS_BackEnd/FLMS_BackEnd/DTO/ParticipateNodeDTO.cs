using System.Text.Json.Serialization;

namespace FLMS_BackEnd.DTO
{
    public class ParticipateNodeDTO
    {
        public int ParticipateId { get; set; }
        public int ClubId { get; set; }
        public int Deep { get; set; }
        [JsonIgnore()]
        public ParticipateNodeDTO? ParentParticipate { get; set; }
        [JsonIgnore()]
        public ParticipateNodeDTO? LeftParticipate { get; set; }
        [JsonIgnore()]
        public ParticipateNodeDTO? RightParticipate { get; set; }
        public int ParentId { get { return ParentParticipate!=null? ParentParticipate.ParticipateId:0; } }
        public int LeftId { get { return LeftParticipate != null ? LeftParticipate.ParticipateId : 0; } }
        public int RightId { get { return RightParticipate != null ? RightParticipate.ParticipateId : 0; } }
    }
}
