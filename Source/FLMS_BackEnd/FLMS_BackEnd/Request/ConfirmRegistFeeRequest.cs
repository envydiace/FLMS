namespace FLMS_BackEnd.Request
{
    public class ConfirmRegistFeeRequest
    {
        public int LeagueId { get; set; }
        public int ClubId { get; set; }
        public string? Evidence { get; set; }
    }
}
