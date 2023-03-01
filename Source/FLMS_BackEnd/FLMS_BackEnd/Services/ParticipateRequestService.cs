using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;

namespace FLMS_BackEnd.Services
{
    public interface ParticipateRequestService
    {
        public Task<JoinResponse> SendJoinRequest(JoinRequest request, int UserId, Constants.RequestType type);
        public Task<RequestListResponse> GetRequestList(ListRequestFilterRequest request, int userId);
    }
}
