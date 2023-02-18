using FLMS_BackEnd.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace FLMS_BackEnd.Repositories.Impl
{
    public class BaseRepositoryImpl<T> : BaseRepository<T> where T : class
    {
        public readonly FLMS_DBContext _dbContext;
        public BaseRepositoryImpl(FLMS_DBContext dbContext)
        {
            _dbContext = dbContext;
        }
        public IQueryable<T> FindAll() => _dbContext.Set<T>().AsNoTracking();

        public IQueryable<T> FindByCondition(Expression<Func<T, bool>> expression) =>
            _dbContext.Set<T>().Where(expression).AsNoTracking();

        public async Task<bool> CreateAsync(T entity)
        {
            try
            {
                if (entity == null)
                {
                    return false;
                }
                _dbContext.Add(entity);
                int savechanges = await _dbContext.SaveChangesAsync();
                return savechanges > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public async Task<T> UpdateAsync(T entity)
        {
            try
            {

                if (entity != null)
                {
                    _dbContext.Update(entity);
                    int savechanges = await _dbContext.SaveChangesAsync();
                    if (savechanges > 0)
                    {
                        return entity;
                    }
                }
            }
            catch (Exception) { }
            return null;
        }

        public async Task<T> DeleteAsync(T entity)
        {
                
            try
            {
                if (entity != null)
                {
                    _dbContext.Remove(entity);
                    int savechanges = await _dbContext.SaveChangesAsync();
                    if (savechanges > 0)
                    {
                        return entity;
                    }
                }
            }
            catch (Exception) { }
            return null;
        }
    }
}
