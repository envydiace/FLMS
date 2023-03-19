using FLMS_BackEnd.Request;

namespace FLMS_BackEnd.Listeners
{
    public class SendMailEventArgs : EventArgs
    {
        public MailRequest MailRequest { get; set; } = null!;
    }
}
