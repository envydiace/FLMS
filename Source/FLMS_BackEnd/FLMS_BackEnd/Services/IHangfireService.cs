namespace FLMS_BackEnd.Services
{
    public interface IHangfireService
    {
        void AddFireAndForgetJob();
        Task AnnouceMatchIncoming(string Type);
        void AddDelayedJob();
        void AddContinuationJob();
        void Test();
    }
}
