using ApiForProject.Entities;
using Microsoft.EntityFrameworkCore;

namespace ApiForProject.Repositories;

public class ActivityRepository(AppDbContext appDbContext): IActivityRepository
{
    public async Task<Activity> AddAsync(Activity activity)
    {
        var set = appDbContext.Set<Activity>();
        var result = await set.AddAsync(activity);
        
        await appDbContext.SaveChangesAsync();
        return result.Entity;
    }

    public Activity Update(Activity activity)
    {
        var set = appDbContext.Set<Activity>();
        var found = set.FirstOrDefault(e => e.Id == activity.Id);
        if (found is null)
            throw new Exception();
        
        var result = set.Update(activity);
        
        appDbContext.SaveChangesAsync();
        return result.Entity;
    }

    public Activity Delete(Activity activity)
    {
        var set = appDbContext.Set<Activity>();
        var found = set.FirstOrDefault(e => e.Id == activity.Id);
        if (found is null)
            throw new Exception();
        
        var result = set.Remove(activity);
        
        appDbContext.SaveChangesAsync();
        return result.Entity;
    }

    public async Task<Activity> GetByIdAsync(long activityId)
    {
        var set = appDbContext.Set<Activity>();
        var result = await set.FirstOrDefaultAsync(e => e.Id == activityId);
        if (result is null)
            throw new Exception();
        
        return result;
    }

    public async Task<Activity> GetRandomActivity()
    {
        var activity = await appDbContext.Activities.OrderBy(m =>
            EF.Functions.Random()).FirstAsync();
        if (activity is null)
            throw new Exception();
        
        return activity;
    }
}