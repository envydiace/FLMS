using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface ParticipationService
    {
        public Task<ConfirmRegistFeeResponse> ConfirmResgistFee(ConfirmRegistFeeRequest request, int userId);
        public Task<ParticipationByLeagueResponse> GetParticipationByLeague(ParticipationByLeagueRequest request);
        public Task<RemoveClubResponse> RemoveJoinedTeam(RemoveClubRequest request, int UserId);
        public Task<List<ClubBasicInfoDTO>> ListUnpositionClub(int leagueId, int userId);
        public Task<AddClubPositionResponse> AddClubPosition(int clubCloneId, int clubId, int userId);
        public Task<List<JoinedLeagueDTO>> GetListJoinedLeague(int userId);
        public Task<ParticipateTreeResponse> GetLeagueParticipateTree(int leagueId);
    }
}
