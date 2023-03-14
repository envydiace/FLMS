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

        public async Task<LeagueFeeClubResponse> GetListLeagueFeeEachClub(int leagueId, int clubId)
        {
            var leaguefees = await feeRepository.FindByCondition(lf => lf.LeagueId == leagueId && lf.IsActual == false).ToListAsync();
            var league = await leagueRepository.FindByCondition(l => l.LeagueId == leagueId).FirstOrDefaultAsync();
            var club = await clubRepository.FindByCondition(c => c.ClubId == clubId).FirstOrDefaultAsync();
            var result = mapper.Map<List<LeagueFeeClubDTO>>(leaguefees.ToList());
            if(league == null)
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
            var total = Math.Round(((from e in result where e.FeeType.Equals("Prize") select e.Cost).Sum() +
                (from e in result where e.FeeType.Equals("Fee") select e.Cost).Sum() -
                (from e in result where e.FeeType.Equals("Sponsored") select e.Cost).Sum()) / league.NoParticipate,0)*100;
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
