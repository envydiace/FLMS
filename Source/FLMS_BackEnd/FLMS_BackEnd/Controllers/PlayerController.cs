using FLMS_BackEnd.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FLMS_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlayerController : BaseApiController
    {
        private readonly PlayerService playerService;
        public PlayerController(PlayerService playerService)
        {
            this.playerService = playerService;
        }
    }
}
