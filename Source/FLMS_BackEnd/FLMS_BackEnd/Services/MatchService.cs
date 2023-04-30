using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
namespace FLMS_BackEnd.Services
{
    public interface MatchService
    {
        Task<LeagueScheduleResponse> GetLeagueSchedule(LeagueScheduleRequest request);
        Task<ClubScheduleResponse> GetClubSchedule(int ClubId);
        Task<MatchInfoResponse> GetMatchInfo(int matchId);
        Task<FinishMatchResponse> FinishMatch(int matchId, int userId);
        Task<UpdateMatchInfoResponse> UpdateMatchInfo(UpdateMatchInfoRequest request,int UserId);
        Task<LoseJudgeResponse> LoseJudge(LoseJudgeRequest request, int userId);
    }
}
