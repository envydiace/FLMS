using FLMS_BackEnd.Models;

namespace FLMS_BackEnd.Repositories
{
    public interface MatchRepository: BaseRepository<Match>
    {
        Task<Match> UpdateMatchAsync(Match match);
    }
}
