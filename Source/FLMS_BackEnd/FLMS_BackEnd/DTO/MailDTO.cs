namespace FLMS_BackEnd.DTO
{
    public class MailDTO
    {
        public string Email { get; set; } = null!;
        public string LeagueManagerName { get; set; } = null!;
        public string ClubManagerName { get; set; } = null!;
        public string ClubName { get; set; } = null!;
        public string LeagueName { get; set; } = null!;
        public string MailMessageCode { get; set; } = null!;
        public string ReceiverRole { get; set; } = null!;
    }
}
