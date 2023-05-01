using FLMS_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class MatchRepositoryImpl : BaseRepositoryImpl<Match>, MatchRepository
    {
        public MatchRepositoryImpl(FLMS_DBContext dbContext) : base(dbContext)
        {
        }

        public async Task<Match> UpdateMatchAsync(Match match)
        {
            try
            {
                if (match != null)
                {
                    if (match.Home.ClubClone != null)
                    {
                        _dbContext.Entry(match.Home.ClubClone).State = EntityState.Modified;
                    }
                    if (match.Away.ClubClone != null)
                    {
                        _dbContext.Entry(match.Away.ClubClone).State = EntityState.Modified;
                    }
                    if (match.MatchStats.Count > 0)
                    {
                        _dbContext.MatchStats.UpdateRange(match.MatchStats);
                        _dbContext.SaveChanges();
                    }
                    _dbContext.Matches.Update(match);
                    int savechanges = await _dbContext.SaveChangesAsync();
                    if (savechanges > 0)
                    {
                        return match;
                    }
                }
            }
            catch (Exception) { }
            return null;
        }
    }
}
