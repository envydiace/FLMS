using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Listeners;
using FLMS_BackEnd.Listeners.Events;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Utils;
using MailKit;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class HangfireServiceImpl : BaseService, IHangfireService
    {
        private readonly MatchRepository matchRepository;
        private readonly SendMailEventHandler sendMailEventHandler;

        public HangfireServiceImpl(MatchRepository matchRepository, IMailService mailService, SendMailEventHandler sendMailEventHandler)
        {
            this.matchRepository = matchRepository;
            this.sendMailEventHandler = sendMailEventHandler;

            sendMailEventHandler.SendMailEventArgs += async (sender, args) =>
            {
                bool sendResult = await mailService.SendEmailAsync(args.MailRequest, new CancellationToken());
                if (!sendResult)
                {
                    Console.WriteLine($"Failed to send email: {args.MailRequest}" );
                }
            };
        }
        public void AddContinuationJob()
        {
            Console.WriteLine($"{DateTime.Now.ToString()} - This is a continuation job!");
        }

        public void AddDelayedJob()
        {
            Console.WriteLine($"{DateTime.Now.ToString()} - This is a Delayed job!");
        }

        public void AddFireAndForgetJob()
        {
            Console.WriteLine($"{DateTime.Now.ToString()} - This is a Fire and Forget job!");
        }

        public async Task AnnouceMatchIncoming(string Type)
        {
            int day = 0;
            string subject = "";
            switch (Type)
            {
                case Constants.MailType.AnnounceMatch:
                    subject = Constants.MailSubject.AnnounceMatch;
                    day = 2;
                    break;
                case Constants.MailType.AnnounceSquad:
                    subject = Constants.MailSubject.AnnounceSquad;
                    day = 1;
                    break;
                default:
                    return;
            }
            var matches = await matchRepository.FindByCondition(m => !m.IsFinish && m.MatchDate.Day == DateTime.Now.AddDays(day).Day)
            .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null).ThenInclude(u => u != null ? u.User : null)
            .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null).ThenInclude(u => u != null ? u.User : null)
            .Include(m => m.League)
            .OrderBy(m => m.MatchDate)
            .ToListAsync();

            foreach (var match in matches)
            {
                if (match.Home.ClubClone != null &&
                    match.Home.ClubClone.Club != null &&
                    match.Away.ClubClone != null &&
                    match.Away.ClubClone.Club != null)
                {
                    MailDTO mailHome = new MailDTO
                    {
                        LeagueName = match.League.LeagueName,
                        ClubManagerName = match.Home.ClubClone.Club.User.FullName,
                        ClubName = match.Home.ClubClone.Club.ClubName,
                        ClubAgainst = match.Away.ClubClone.Club.ClubName,
                        Stadium = match.Stadium != null ? match.Stadium : "",
                        Round = match.Round != null ? match.Round : "",
                        MatchDate = match.MatchDate.ToString(Constants.DATE_FORMAT),
                        MatchTime = match.MatchDate.ToString(Constants.TIME_FORMAT)
                    };
                    MailDTO mailAway = new MailDTO
                    {
                        LeagueName = match.League.LeagueName,
                        ClubManagerName = match.Away.ClubClone.Club.User.FullName,
                        ClubName = match.Away.ClubClone.Club.ClubName,
                        ClubAgainst = match.Home.ClubClone.Club.ClubName,
                        Stadium = match.Stadium != null ? match.Stadium : "",
                        Round = match.Round != null ? match.Round : "",
                        MatchDate = match.MatchDate.ToString(Constants.DATE_FORMAT),
                        MatchTime = match.MatchDate.ToString(Constants.TIME_FORMAT)

                    };
                    MailRequest mailRequestHome = new MailRequest
                    {
                        To = new List<string> {
                                match.Home.ClubClone.Club.User.Email
                                },
                        Subject = subject,
                        MailType = Type,
                        MailData = mailHome,
                    };
                    MailRequest mailRequestAway = new MailRequest
                    {
                        To = new List<string> {
                                match.Away.ClubClone.Club.User.Email
                                },
                        Subject = subject,
                        MailType = Type,
                        MailData = mailAway,
                    };

                    await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequestHome });
                    await sendMailEventHandler.OnSendMailReached(new SendMailEventArgs { MailRequest = mailRequestAway });
                }
            }
        }

        public void Test()
        {
            Console.WriteLine($"{DateTime.Now.ToString()} - This is a test job!");
        }
    }
}
