using FLMS_BackEnd.Repositories;

namespace FLMS_BackEnd.Services.Impl
{
    public class HangfireServiceImpl : BaseService, IHangfireService
    {
        private readonly MatchRepository matchRepository;

        public HangfireServiceImpl(MatchRepository matchRepository)
        {
            this.matchRepository = matchRepository;
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

        public void AddReccuringJob()
        {
            Console.WriteLine($"{DateTime.Now.ToString()} - This is a recurring job!");
        }

        public void Test()
        {
            Console.WriteLine($"{DateTime.Now.ToString()} - This is a test job!");
        }
    }
}
