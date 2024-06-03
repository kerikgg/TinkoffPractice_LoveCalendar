using ApiForProject.Entities;

namespace ApiForProject.Repositories;

public interface IActivityRepository
{
    public Task<Activity> AddAsync(Activity activity);
    public Activity Update(Activity activity);
    public Activity Delete(Activity activity);
    public Task<Activity> GetByIdAsync(long activityId);
    public Task<Activity> GetRandomActivity();
}