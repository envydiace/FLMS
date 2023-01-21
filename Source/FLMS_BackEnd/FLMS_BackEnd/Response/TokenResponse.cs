namespace FLMS_BackEnd.Response
{
    public class TokenResponse : BaseResponse
    {
        public string AccessToken { get; set; }
        public string RefreshToken { get; set; }
    }
}
