namespace FLMS_BackEnd.Request
{
    public class ChangeNewPassRequest
    {
        public string NewPassword { get; set; } = null!;
        public string RePassword { get; set; } = null!;
        public string Token { get; set; } = null!;
    }
}
