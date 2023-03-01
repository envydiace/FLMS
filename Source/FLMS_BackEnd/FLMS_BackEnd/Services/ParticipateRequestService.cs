using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface ParticipateRequestService
    {
        public Task<InvitationResponse> SendInvitation(InvitationRequest request, int UserId);
        public Task<RequestListResponse> GetRequestList(ListRequestFilterRequest request, int userId);
    }
}
