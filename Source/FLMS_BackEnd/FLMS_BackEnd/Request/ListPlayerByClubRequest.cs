namespace FLMS_BackEnd.Request
{
    public class ListPlayerByClubRequest
    {
        public string? searchPlayerName { get; set; }
        public int? clubId { get; set; }
    }
}
