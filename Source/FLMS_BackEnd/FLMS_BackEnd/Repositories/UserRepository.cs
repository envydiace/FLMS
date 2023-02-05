using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface UserRepository
    {
        Task<User> GetByEmail(string email);
        Task<bool> CreateAsync(User user);
        Task<User> GetUserByUserId(int userId);
        Task<User> GetUserByUserIdIncludeRefreshToken(int userId);
    }
}
