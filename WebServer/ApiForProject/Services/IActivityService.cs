using ApiForProject.Entities;

namespace ApiForProject.Services;

public interface IActivityService
{
    public Task<Activity> GetRandomActivity();
}