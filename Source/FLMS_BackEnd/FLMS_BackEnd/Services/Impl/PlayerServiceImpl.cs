using FLMS_BackEnd.Repositories;

namespace FLMS_BackEnd.Services.Impl
{
    public class PlayerServiceImpl : BaseService, PlayerService
    {
        private readonly PlayerRepository playerRepository;
        private readonly PlayerClubRepository playerClubRepository;

        public PlayerServiceImpl(PlayerRepository playerRepository, PlayerClubRepository playerClubRepository)
        {
            this.playerRepository = playerRepository;
            this.playerClubRepository = playerClubRepository;
        }
    }
}
