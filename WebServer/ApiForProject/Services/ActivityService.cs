using ApiForProject.Entities;
using ApiForProject.Repositories;

namespace ApiForProject.Services;

public class ActivityService(IActivityRepository activityRepository) : IActivityService
{
    public async Task<Activity> GetRandomActivity()
    {
        var activity = await activityRepository.GetRandomActivity();
        return activity;
    }
}