using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface UserRepository
    {
        Task<User> GetByEmail(string email);
        Task<User> GetByUserName(string username);
        Task<bool> CreateAsync(User user);
    }
}
