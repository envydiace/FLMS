using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Asn1.Ocsp;

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

        public async Task<FeeDetailResponse> UpdateFeeDetail(FeeDetailRequest request, int UserID)
        {
            var fd = await feeRepository.FindByCondition(fd => fd.LeagueFeeId == request.LeagueFeeId)
                .Include(fd => fd.League).FirstOrDefaultAsync();
            if (fd == null)
            {
                return new FeeDetailResponse { Success = false, MessageCode = "ER-FE-02" };
            }
            if(fd.League.UserId != UserID)
            {
                return new FeeDetailResponse { Success = false, MessageCode = "ER-LE-06" };
            }
            fd.Cost = request.Cost;
            fd.ExpenseName = request.ExpenseName;
            LeagueFee result = await feeRepository.UpdateAsync(fd);
            if (result != null)
            {
                return new FeeDetailResponse { Success = true, FeeInfo = this.GetLeagueFeeDetail(result.LeagueFeeId).Result.FeeInfo };
            }
            return new FeeDetailResponse { Success = false, MessageCode = "ER-FE-03" };
        }
    }
}
