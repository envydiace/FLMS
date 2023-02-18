using System.Linq.Expressions;

namespace FLMS_BackEnd.Repositories
{
    public interface BaseRepository<T> where T : class
    {
        public IQueryable<T> FindAll();
        public IQueryable<T> FindByCondition(Expression<Func<T, bool>> expression);
        public Task<bool> CreateAsync(T entity);
        public Task<T> UpdateAsync(T entity);
        public Task<T> DeleteAsync(T entity);
    }
}
