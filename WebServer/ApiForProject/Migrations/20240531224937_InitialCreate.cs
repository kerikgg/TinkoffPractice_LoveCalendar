using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace ApiForProject.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Activities",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Title = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: false),
                    ImageUrl = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Activities", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "Activities",
                columns: new[] { "Id", "Description", "ImageUrl", "Title" },
                values: new object[,]
                {
                    { 1L, "Примерьте странные наряды, зайдите в ту самую сувенирную лавочку, купите попкорн и съешьте его на диванчиках.", "https://i.ibb.co/wwjG5vx/image.webp", "Торговый центр" },
                    { 2L, "Это такой мастер-класс, где участники рисуют изображение под руководством художника. Микс обучения и элементов творчества. А еще у вас останутся готовые картины, которыми можно обменяться в конце.", "https://i.ibb.co/0swd2bL/image.webp", "Арт-вечеринки" },
                    { 3L, "Сходите вместе на квест, это подарит вам кучу незабываемых эмоций. Квесты можно подобрать под любое настроение.", "https://i.ibb.co/YR6RPZg/image.webp", "Квесты" },
                    { 4L, "Это такой мастер-класс, где участники готовят под руководством поваров, поэтому голодными вы точно не останетесь.", "https://i.ibb.co/djMcRh7/image.webp", "Кулинарный мастер-класс" },
                    { 5L, "В переходах, на улице или в амфитеатрах — такие выступления обладают особой атмосферой, которая добавляет свиданиям романтики.", "https://i.ibb.co/bvt6F97/image.jpg", "Живая музыка" },
                    { 6L, "Романтический вечер и полный релакс. И пусть весь мир подождет!", "https://i.ibb.co/BZqfpWT/image.jpg", "СПА для двоих" },
                    { 7L, "Для тех кто любит животных.", "https://i.ibb.co/0BQ44NC/image.webp", "Посетите зоопарк" },
                    { 8L, "Неустаревающая классика. Но свиданию может помешать плохая погода.", "https://i.ibb.co/BnRKWfM/image.webp", "Пикник на крыше" },
                    { 9L, "Без стеснения пойте любимые песни.", "https://i.ibb.co/5KpzG7L/image.webp", "Вечер караоке" },
                    { 10L, "В том, чтобы выбрать партнеру одежду, действительно есть что-то трогательное. Важно вдумчиво и внимательно подойти к процессу и, конечно, повеселиться.", "https://i.ibb.co/ZXFZvwM/image.webp", "Покупайте новые наряды" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Activities");
        }
    }
}
