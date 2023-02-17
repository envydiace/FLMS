using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface UserRepository : BaseRepository<User> 
    {
        Task<User> GetByEmail(string email);
        Task<User> GetUserByUserId(int userId);
        Task<User> GetUserByUserIdIncludeRefreshToken(int userId);
    }
}
