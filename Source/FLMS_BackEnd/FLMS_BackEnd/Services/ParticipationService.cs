using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface ParticipationService
    {
        public Task<ConfirmRegistFeeResponse> ConfirmResgistFee(ConfirmRegistFeeRequest request, int userId);
        public Task<ParticipationByLeagueResponse> GetParticipationByLeague(ParticipationByLeagueRequest request);
        public Task<RemoveClubResponse> RemoveJoinedTeam(RemoveClubRequest request, int UserId);
    }
}
