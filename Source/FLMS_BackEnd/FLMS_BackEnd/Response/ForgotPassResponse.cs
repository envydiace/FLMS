using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Response
{
    public class ForgotPassResponse : BaseMailResponse
    {
        public MailDTO MailData { get; set; }
    }
}
