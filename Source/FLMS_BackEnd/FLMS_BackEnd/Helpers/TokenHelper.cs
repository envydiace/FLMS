﻿using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace FLMS_BackEnd.Helpers
{
    public class TokenHelper
    {
        private readonly IConfiguration _configuration;
        private readonly UserRepository userRepository;

        public TokenHelper(IConfiguration configuration, UserRepository userRepository)
        {
            _configuration = configuration;
            this.userRepository = userRepository;
        }

        public async Task<string> GenerateAccessToken(int userId)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Convert.FromBase64String(_configuration["Jwt:Key"]);

            User user = await userRepository.FindByCondition(user => user.UserId == userId).FirstOrDefaultAsync();
            var claimsIdentity = new ClaimsIdentity(new[] {
                new Claim(ClaimTypes.NameIdentifier, userId.ToString()),
                new Claim(ClaimTypes.Role, user.Role)
                //,
                //new Claim(ClaimTypes.Email, user.Email),
                //new Claim(ClaimTypes.Name, user.Username)
            });

            var signingCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = claimsIdentity,
                Issuer = _configuration["Jwt:Issuer"],
                Audience = _configuration["Jwt:Audience"],
                Expires = DateTime.Now.AddSeconds(Convert.ToInt32(_configuration["Jwt:AccessExpire"])),
                SigningCredentials = signingCredentials,

            };
            var securityToken = tokenHandler.CreateToken(tokenDescriptor);

            return await System.Threading.Tasks.Task.Run(() => tokenHandler.WriteToken(securityToken));
        }
        public async Task<string> GenerateRefreshToken()
        {
            var secureRandomBytes = new byte[32];

            using var randomNumberGenerator = RandomNumberGenerator.Create();
            await System.Threading.Tasks.Task.Run(() => randomNumberGenerator.GetBytes(secureRandomBytes));

            var refreshToken = Convert.ToBase64String(secureRandomBytes);
            return refreshToken;
        }
        public async Task<string> HashTokenAsync(string token)
        {
            using var sha256 = SHA256.Create();
            var bytes = Encoding.UTF8.GetBytes(token);
            System.IO.Stream stream = new System.IO.MemoryStream(bytes);
            var hashBytes = await sha256.ComputeHashAsync(stream);
            var hashString = Convert.ToBase64String(hashBytes);
            return hashString;
        }
    }
}
