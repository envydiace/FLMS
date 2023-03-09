namespace FLMS_BackEnd.Services
{
    public interface IHangfireService
    {
        void AddFireAndForgetJob();
        void AddReccuringJob();
        void AddDelayedJob();
        void AddContinuationJob();
        void Test();
    }
}
