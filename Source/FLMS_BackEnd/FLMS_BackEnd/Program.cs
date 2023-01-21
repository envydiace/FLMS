using FLMS_BackEnd.Helpers;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Repositories.Impl;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Services.Impl;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddSwaggerGen();
builder.Services.AddAuthorization();
builder.Services.AddDbContext<FLMS_DBContext>(
    options => options.UseSqlServer(builder.Configuration.GetConnectionString("dbUrl")));
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddJwtBearer(options =>
        {
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = TokenHelper.Issuer,
                ValidAudience = TokenHelper.Audience,
                IssuerSigningKey = new SymmetricSecurityKey(Convert.FromBase64String(TokenHelper.Secret)),
                ValidateLifetime = true,
                ClockSkew = TimeSpan.Zero
            };
        });
builder.Services.AddScoped<UserService, UserServiceImpl>();

builder.Services.AddScoped<UserRepository, UserRepositoryImpl>();

var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.UseCors(option => option.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

app.MapControllers();

app.UseAuthentication();

app.UseAuthorization();

app.UseSwagger();

app.UseSwaggerUI(options =>
{
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "v1");
    options.RoutePrefix = string.Empty;
});

app.Run();
