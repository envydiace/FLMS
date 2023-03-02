using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Utils;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Options;
using MimeKit;
using Org.BouncyCastle.Asn1.Pkcs;

namespace FLMS_BackEnd.Services.Impl
{
    public class MailServiceImpl: BaseService, IMailService
    {
        private readonly MailSettings _mailSettings;
        public MailServiceImpl(IOptions<MailSettings> mailSettings)
        {
            _mailSettings = mailSettings.Value;
        }

        public async Task<bool> SendEmailAsync(MailRequest mailRequest, CancellationToken ct)
        {
            try
            {
                // Initialize a new instance of the MimeKit.MimeMessage class
                var mail = new MimeMessage();

                #region Sender / Receiver
                // Sender
                mail.From.Add(new MailboxAddress(_mailSettings.DisplayName, mailRequest.From ?? _mailSettings.From));
                mail.Sender = new MailboxAddress(mailRequest.DisplayName ?? _mailSettings.DisplayName, mailRequest.From ?? _mailSettings.From);

                // Receiver
                foreach (string mailAddress in mailRequest.To)
                    mail.To.Add(MailboxAddress.Parse(mailAddress));

                // Set Reply to if specified in mail data
                if (!string.IsNullOrEmpty(mailRequest.ReplyTo))
                    mail.ReplyTo.Add(new MailboxAddress(mailRequest.ReplyToName, mailRequest.ReplyTo));

                // BCC
                // Check if a BCC was supplied in the request
                if (mailRequest.Bcc != null)
                {
                    // Get only addresses where value is not null or with whitespace. x = value of address
                    foreach (string mailAddress in mailRequest.Bcc.Where(x => !string.IsNullOrWhiteSpace(x)))
                        mail.Bcc.Add(MailboxAddress.Parse(mailAddress.Trim()));
                }

                // CC
                // Check if a CC address was supplied in the request
                if (mailRequest.Cc != null)
                {
                    foreach (string mailAddress in mailRequest.Cc.Where(x => !string.IsNullOrWhiteSpace(x)))
                        mail.Cc.Add(MailboxAddress.Parse(mailAddress.Trim()));
                }
                #endregion

                #region Content

                // Add Content to Mime Message
                var body = new BodyBuilder();
                mail.Subject = mailRequest.Subject;
                body.HtmlBody = mailRequest.Body;
                mail.Body = body.ToMessageBody();

                // Check if we got any attachments and add the to the builder for our message
                if (mailRequest.Attachments != null)
                {
                    byte[] attachmentFileByteArray;

                    foreach (IFormFile attachment in mailRequest.Attachments)
                    {
                        // Check if length of the file in bytes is larger than 0
                        if (attachment.Length > 0)
                        {
                            // Create a new memory stream and attach attachment to mail body
                            using (MemoryStream memoryStream = new MemoryStream())
                            {
                                // Copy the attachment to the stream
                                attachment.CopyTo(memoryStream);
                                attachmentFileByteArray = memoryStream.ToArray();
                            }
                            // Add the attachment from the byte array
                            body.Attachments.Add(attachment.FileName, attachmentFileByteArray, ContentType.Parse(attachment.ContentType));
                        }
                    }
                }

                #endregion

                #region Send Mail

                using var smtp = new SmtpClient();

                if (_mailSettings.UseSSL)
                {
                    await smtp.ConnectAsync(_mailSettings.Host, _mailSettings.Port, SecureSocketOptions.SslOnConnect, ct);
                }
                else if (_mailSettings.UseStartTls)
                {
                    await smtp.ConnectAsync(_mailSettings.Host, _mailSettings.Port, SecureSocketOptions.StartTls, ct);
                }
                await smtp.AuthenticateAsync(_mailSettings.UserName, _mailSettings.Password, ct);
                await smtp.SendAsync(mail, ct);
                await smtp.DisconnectAsync(true, ct);

                #endregion

                return true;

            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
