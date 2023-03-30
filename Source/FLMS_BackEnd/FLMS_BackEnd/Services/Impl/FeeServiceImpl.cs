using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Asn1.Ocsp;

namespace FLMS_BackEnd.Services.Impl
{
    public class FeeServiceImpl : BaseService, FeeService
    {
        private readonly FeeRepository feeRepository;
        private readonly LeagueRepository leagueRepository;
        private readonly ClubRepository clubRepository;

        public FeeServiceImpl(FeeRepository feeRepository, LeagueRepository leagueRepository, ClubRepository clubRepository)
        {
            this.feeRepository = feeRepository;
            this.leagueRepository = leagueRepository;
            this.clubRepository = clubRepository;
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
                leagueFeeResponse.Actual.AddRange(result.Where(f => f.IsActual).ToList());
                leagueFeeResponse.Plan.AddRange(result.Where(f => !f.IsActual).ToList());
                leagueFeeResponse.TotalPlanFee = MethodUtils.SumTotalLeagueFee(leagueFeeResponse.Plan);
                leagueFeeResponse.TotalActualFee = MethodUtils.SumTotalLeagueFee(leagueFeeResponse.Actual);
                leagueFeeResponse.Success = true;
                return leagueFeeResponse;
            }
            return new LeagueFeeResponse
            {
                Success = false,
                MessageCode = "ER-FE-01"
            };
        }

        public async Task<LeagueFeeClubResponse> GetListLeagueFeeEachClub(int leagueId, int clubId)
        {
            var leaguefees = await feeRepository.FindByCondition(lf => lf.LeagueId == leagueId && lf.IsActual == false).ToListAsync();
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId).FirstOrDefaultAsync();
            var club = await clubRepository.FindByCondition(c => c.ClubId == clubId).FirstOrDefaultAsync();
            var result = mapper.Map<List<LeagueFeeClubDTO>>(leaguefees.ToList());
            if (league == null)
            {
                return new LeagueFeeClubResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            if (club == null)
            {
                return new LeagueFeeClubResponse
                {
                    Success = false,
                    MessageCode = "ER-CL-02"
                };
            }
            if (result == null)
            {
                return new LeagueFeeClubResponse
                {
                    Success = false,
                    MessageCode = "ER-FE-02"
                };
            }
            var total = Math.Round((MethodUtils.SumTotalLeagueFee(mapper.Map<List<LeagueFeeDTO>>(result))/ league.NoParticipate) / 100, 0) * 100;
            return new LeagueFeeClubResponse
            {
                Success = true,
                Plan = result,
                Total = total,
                NoParticipate = league.NoParticipate,
                ClubName = club.ClubName,
                Logo = club.Logo,
                LeagueName = league.LeagueName
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
            if (fd.League.UserId != UserID)
            {
                return new FeeDetailResponse { Success = false, MessageCode = "ER-LE-06" };
            }
            if (!MethodUtils.CheckFeeType(request.FeeType))
            {
                return new FeeDetailResponse { Success = false, MessageCode = "ER-FE-04" };
            }
            if (!fd.IsActual && fd.League.StartDate.CompareTo(DateTime.Now) < 0)
            {
                return new FeeDetailResponse { Success = false, MessageCode = "ER-FE-05" };
            }
            if (MethodUtils.CheckEditableFeeKey(request.FeeKey))
            {
                fd.ExpenseName = request.ExpenseName;
                fd.FeeType = request.FeeType;
            }
            fd.Cost = request.Cost;

            LeagueFee result = await feeRepository.UpdateAsync(fd);
            if (result != null)
            {
                return new FeeDetailResponse { Success = true, FeeInfo = this.GetLeagueFeeDetail(result.LeagueFeeId).Result.FeeInfo };
            }
            return new FeeDetailResponse { Success = false, MessageCode = "ER-FE-03" };
        }
        public async Task<AddLeagueFeeResponse> AddListLeagueFee(AddLeagueFeeRequest request, int userId)
        {
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == request.LeagueId)
                    .Include(l => l.LeagueFees)
                    .FirstOrDefaultAsync();
            if (league == null)
            {
                return new AddLeagueFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-05"
                };
            }
            if (league.UserId != userId)
            {
                return new AddLeagueFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (!request.IsActual && league.StartDate.CompareTo(DateTime.Now) < 0)
            {
                return new AddLeagueFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-FE-06"
                };
            }
            request.ListFees.ForEach(fee =>
            {
                if (MethodUtils.CheckFeeType(fee.FeeType))
                {
                    league.LeagueFees.Add(new LeagueFee
                    {
                        Cost = fee.Cost,
                        ExpenseName = fee.ExpenseName,
                        FeeType = fee.FeeType,
                        IsActual = request.IsActual,
                        ExpenseKey = Constants.Fee.DefaultFeeKey
                    });
                }
            });
            var result = await leagueRepository.UpdateAsync(league);
            if (result != null)
            {
                return new AddLeagueFeeResponse
                {
                    Success = true,
                    MessageCode = "MS-FE-01"
                };
            }
            else
            {
                return new AddLeagueFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-FE-07"
                };
            }
        }

        public async Task<DeleteLeagueFeeResponse> DeleteLeagueFee(int LeagueFeeId, int UserId)
        {
            var feedetail = await feeRepository.FindByCondition(fd => fd.LeagueFeeId == LeagueFeeId)
                .Include(fd => fd.League).FirstOrDefaultAsync();
            if(feedetail == null)
            {
                return new DeleteLeagueFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-FE-02"
                };
            }
            if(feedetail.League.UserId != UserId)
            {
                return new DeleteLeagueFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-06"
                };
            }
            if (!feedetail.IsActual && feedetail.League.StartDate.CompareTo(DateTime.Now) < 0)
            {
                return new DeleteLeagueFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-FE-06"
                };
            }
            LeagueFee result = await feeRepository.DeleteAsync(feedetail);
            if (result != null)
            {
                return new DeleteLeagueFeeResponse
                {
                    Success = true,
                    MessageCode = "MS-FE-02"
                };
            }
            return new DeleteLeagueFeeResponse { Success = false, MessageCode = "ER-FE-08" };
        }
    }
}
