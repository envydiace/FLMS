using FLMS_BackEnd.Request;

namespace FLMS_BackEnd.Services
{
    public interface IMailService
    {
        Task<bool> SendEmailAsync(MailRequest mailRequest, CancellationToken ct);
    }
}
