using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class FeeServiceImpl: BaseService, FeeService
    {
        private readonly FeeRepository feeRepository;

        public FeeServiceImpl(FeeRepository feeRepository)
        {
            this.feeRepository = feeRepository;
        }

        public async Task<FeeDetailResponse> GetLeagueFeeDetail(int LeagueFeeId)
        {
            var feedetail = await feeRepository.FindByCondition(fd => fd.LeagueFeeId == LeagueFeeId).FirstOrDefaultAsync();
            if (feedetail == null)
            {
                return new FeeDetailResponse
                {
                    Success = false,
                    MessageCode = "ER-FE-02"
                };
            }
            return new FeeDetailResponse
            {
                Success = true,
                FeeInfo = mapper.Map<LeagueFeeDTO>(feedetail)
            };
        }

        public async Task<LeagueFeeResponse> GetListLeagueFee(int LeagueId)
        {
            var leaguefees = await feeRepository.FindByCondition(lf => lf.LeagueId == LeagueId).ToListAsync();
            var result = mapper.Map<List<LeagueFeeDTO>>(leaguefees.ToList());
            if (result != null)
            {
                LeagueFeeResponse leagueFeeResponse = new LeagueFeeResponse();
                foreach(var leaguefee in result)
                {
                    if (leaguefee.IsActual)
                    {
                        leagueFeeResponse.Actual.Add(leaguefee);
                    }
                    else
                    {
                        leagueFeeResponse.Plan.Add(leaguefee);
                    }
                }
                leagueFeeResponse.Success = true;
                return leagueFeeResponse;
            }
            return new LeagueFeeResponse
            {
                Success = false,
                MessageCode = "ER-FE-01"
            };
            
        }
    }
}
