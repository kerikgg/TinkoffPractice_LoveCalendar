using ApiForProject.Services;
using Microsoft.AspNetCore.Mvc;

namespace ApiForProject.Controllers;

[Route("[controller]")]
public class ActivitiesController(IActivityService activityService): ControllerBase
{
    [HttpGet("[action]")]
    public async Task<IActionResult> RandomActivity()
    {
        var result = await activityService.GetRandomActivity();
        return Ok(result);
    }
}