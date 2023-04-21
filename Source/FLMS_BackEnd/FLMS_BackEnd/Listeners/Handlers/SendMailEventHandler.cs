using FLMS_BackEnd.Services;
using MailKit;
using IMailService = FLMS_BackEnd.Services.IMailService;

namespace FLMS_BackEnd.Listeners.Events
{
    public class SendMailEventHandler
    {
        private readonly IMailService mailService;
        public SendMailEventHandler(IMailService mailService)
        {
            this.mailService = mailService ?? throw new ArgumentNullException(nameof(mailService));
        }

        public event EventHandler<SendMailEventArgs> SendMailEventArgs;
        public virtual async Task OnSendMailReached(SendMailEventArgs e)
        {
            var mailRequest = e.MailRequest;
            var sendResult = await mailService.SendEmailAsync(mailRequest, new CancellationToken());
            if (!sendResult)
            {
                Console.WriteLine($"Failed to send email: {mailRequest}");
            }
        }
    }
}
