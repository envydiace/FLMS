using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class ParticipationServiceImpl: BaseService, ParticipationService
    {
        private readonly ParticipationRepository participationRepository;

        public ParticipationServiceImpl(ParticipationRepository participationRepository)
        {
            this.participationRepository = participationRepository;
        }

        public async Task<ConfirmRegistFeeResponse> ConfirmResgistFee(ConfirmRegistFeeRequest request, int userId)
        {
            var participation = await participationRepository.FindByCondition(p =>
                    p.ClubId == request.ClubId &&
                    p.LeagueId == request.LeagueId)
                .Include(p => p.League)
                .ThenInclude(l=>l.ClubClones)
                .FirstOrDefaultAsync();
            if(participation == null)
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-01"
                };
            }
            if (participation.Confirmed)
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-04"
                };
            }
            participation.Confirmed = true;
            participation.Evidence = request.Evidence;
            if (participation.League.LeagueType.Equals(Constants.LeagueType.LEAGUE.ToString()))
            {
                var clubClone = participation.League.ClubClones.Where(c => c.ClubId == null).FirstOrDefault();
                if (clubClone != null)
                {
                    clubClone.ClubId = request.ClubId;
                }
                else
                {
                    return new ConfirmRegistFeeResponse
                    {
                        Success = false,
                        MessageCode = "ER-PA-03"
                    };
                }
            }
            
            var result = await participationRepository.UpdateAsync(participation);
            if (result != null)
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = true,
                    MessageCode = "MS-PA-01"
                };
            }else
            {
                return new ConfirmRegistFeeResponse
                {
                    Success = false,
                    MessageCode = "ER-PA-02"
                };
            }
        }
    }
}
