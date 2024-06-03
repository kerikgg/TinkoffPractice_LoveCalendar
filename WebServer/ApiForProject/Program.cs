using ApiForProject;
using ApiForProject.Repositories;
using ApiForProject.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Configuration
    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", true, true);

builder.Services.AddDbContext<AppDbContext>(opt =>
{ 
    opt
        .UseNpgsql(builder.Configuration["Database:ConnectionString"],
            x => x.MigrationsAssembly("ApiForProject"));
});

builder.Services.AddScoped<IActivityRepository, ActivityRepository>();
builder.Services.AddScoped<IActivityService, ActivityService>();
builder.Services.AddControllers();

var app = builder.Build();
app.MapControllers();
app.Run();