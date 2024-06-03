using ApiForProject.Entities;
using Microsoft.EntityFrameworkCore;

namespace ApiForProject;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<Activity> Activities => Set<Activity>();
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        SeedingStartedActivities(modelBuilder);
        base.OnModelCreating(modelBuilder);
    }

    private static void SeedingStartedActivities(ModelBuilder modelBuilder)
    {
        var l = new List<Activity>
        {
            new()
            {
                Id = 1,
                Title = "Торговый центр",
                Description = "Примерьте странные наряды, зайдите в ту самую сувенирную лавочку, купите попкорн и съешьте его на диванчиках.",
                ImageUrl = "https://i.ibb.co/wwjG5vx/image.webp"
            },
            new()
            {
                Id = 2,
                Title = "Арт-вечеринки",
                Description = "Это такой мастер-класс, где участники рисуют изображение под руководством художника. Микс обучения и элементов творчества. А еще у вас останутся готовые картины, которыми можно обменяться в конце.",
                ImageUrl = "https://i.ibb.co/0swd2bL/image.webp"
            },
            new()
            {
                Id = 3,
                Title = "Квесты",
                Description = "Сходите вместе на квест, это подарит вам кучу незабываемых эмоций. Квесты можно подобрать под любое настроение.",
                ImageUrl = "https://i.ibb.co/YR6RPZg/image.webp"
            },
            new()
            {
                Id = 4,
                Title = "Кулинарный мастер-класс",
                Description = "Это такой мастер-класс, где участники готовят под руководством поваров, поэтому голодными вы точно не останетесь.",
                ImageUrl = "https://i.ibb.co/djMcRh7/image.webp",
            },
            new()
            {
                Id = 5,
                Title = "Живая музыка",
                Description = "В переходах, на улице или в амфитеатрах — такие выступления обладают особой атмосферой, которая добавляет свиданиям романтики.",
                ImageUrl = "https://i.ibb.co/bvt6F97/image.jpg"
            },
            new()
            {
                Id = 6,
                Title = "СПА для двоих",
                Description = "Романтический вечер и полный релакс. И пусть весь мир подождет!",
                ImageUrl = "https://i.ibb.co/BZqfpWT/image.jpg",

            },
            new ()
            {
                Id = 7,
                Title = "Посетите зоопарк",
                Description = "Для тех кто любит животных.",
                ImageUrl = "https://i.ibb.co/0BQ44NC/image.webp"
            },
            new()
            {
                Id = 8,
                Title = "Пикник на крыше",
                Description = "Неустаревающая классика. Но свиданию может помешать плохая погода.",
                ImageUrl = "https://i.ibb.co/BnRKWfM/image.webp"
            },
            new()
            {
                Id = 9,
                Title = "Вечер караоке",
                Description = "Без стеснения пойте любимые песни.",
                ImageUrl = "https://i.ibb.co/5KpzG7L/image.webp"
            },
            new()
            {
                Id = 10,
                Title = "Покупайте новые наряды",
                Description = "В том, чтобы выбрать партнеру одежду, действительно есть что-то трогательное. Важно вдумчиво и внимательно подойти к процессу и, конечно, повеселиться.",
                ImageUrl = "https://i.ibb.co/ZXFZvwM/image.webp"
            }
        };
        modelBuilder.Entity<Activity>().HasData(l);
    }
}