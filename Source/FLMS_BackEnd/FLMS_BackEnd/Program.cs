using DocumentFormat.OpenXml.Office2016.Drawing.ChartDrawing;
using FLMS_BackEnd.Helpers;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Repositories.Impl;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Services.Impl;
using FLMS_BackEnd.Utils;
using MailKit;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using IMailService = FLMS_BackEnd.Services.IMailService;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();

builder.Services.Configure<MailSettings>(builder.Configuration.GetSection("MailSettings"));
builder.Services.AddTransient<IMailService, MailServiceImpl>();
builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new OpenApiInfo { Title = "Project API", Version = "v1" });
    option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    option.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            new string[]{}
        }
    });
});


builder.Services.Configure<KestrelServerOptions>(options =>
{
    options.AllowSynchronousIO = true;
});

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
                ValidIssuer = builder.Configuration["Jwt:Issuer"],
                ValidAudience = builder.Configuration["Jwt:Audience"],
                IssuerSigningKey = new SymmetricSecurityKey(Convert.FromBase64String(builder.Configuration["Jwt:Key"])),
                ValidateLifetime = true,
                ClockSkew = TimeSpan.Zero
            };
        });

//Map service
builder.Services.AddScoped<UserService, UserServiceImpl>();
builder.Services.AddScoped<TokenService, TokenServiceImpl>();
builder.Services.AddScoped<ClubService, ClubServiceImpl>();
builder.Services.AddScoped<PlayerService, PlayerServiceImpl>();
builder.Services.AddScoped<LeagueService, LeagueServiceImpl>();
builder.Services.AddScoped<MatchService, MatchServiceImpl>();
builder.Services.AddScoped<ParticipateRequestService, ParticipateRequestServiceImpl>();
builder.Services.AddScoped<FeeService, FeeServiceImpl>();
builder.Services.AddScoped<ParticipationService, ParticipationServiceImpl>();
builder.Services.AddScoped<SquadService, SquadServiceImpl>();

//Map repository
builder.Services.AddScoped<UserRepository, UserRepositoryImpl>();
builder.Services.AddScoped<TokenRepository, TokenRepositoryImpl>();
builder.Services.AddScoped<ClubRepository, ClubRepositoryImpl>();
builder.Services.AddScoped<PlayerRepository, PlayerRepositoryImpl>();
builder.Services.AddScoped<PlayerClubRepository, PlayerClubRepositoryImpl>();
builder.Services.AddScoped<LeagueRepository, LeagueRepositoryImpl>();
builder.Services.AddScoped<ParticipateNodeRepository, ParticipateNodeRepositoryImpl>();
builder.Services.AddScoped<MatchRepository, MatchRepositoryImpl>();
builder.Services.AddScoped<ParticipateRequestRepository, ParticipateRequestRepositoryImpl>();
builder.Services.AddScoped<FeeRepository, FeeRepositoryImpl>();
builder.Services.AddScoped<ParticipationRepository, ParticipationRepositoryImpl>();
builder.Services.AddScoped<SquadRepository, SquadRepositoryImpl>();
builder.Services.AddScoped<SquadPositionRepository, SquadPositionRepositoryImpl>();

builder.Services.AddScoped<TokenHelper>();

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
