namespace FLMS_BackEnd.DTO
{
    public class RequestDTO
    {
        public int RequestId { get; set; }
        public int LeagueId { get; set; }
        public int ClubId { get; set; }
        public string LeagueName { get; set; } = null!;
        public string ClubName { get; set; } = null!;
        public string RequestType { get; set; } = null!;
        public string RequestStatus { get; set; } = null!;
        public DateTime RequestDate { get; set; }
    }
}
