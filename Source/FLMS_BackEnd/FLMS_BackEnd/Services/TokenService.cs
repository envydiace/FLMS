using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Services
{
    public interface TokenService
    {
        Task<Tuple<string, string>> GenerateTokensAsync(int userId);
    }
}
