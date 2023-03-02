using FLMS_BackEnd.Repositories;

namespace FLMS_BackEnd.Services.Impl
{
    public class FeeServiceImpl: BaseService, FeeService
    {
        private readonly FeeRepository feeRepository;

        public FeeServiceImpl(FeeRepository feeRepository)
        {
            this.feeRepository = feeRepository;
        }
    }
}
