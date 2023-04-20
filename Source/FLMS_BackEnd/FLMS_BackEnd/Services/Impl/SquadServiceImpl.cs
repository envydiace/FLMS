using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class SquadServiceImpl : BaseService, SquadService
    {
        private readonly SquadRepository squadRepository;
        private readonly SquadPositionRepository squadPositionRepository;
        private readonly PlayerRepository playerRepository;

        public SquadServiceImpl(SquadRepository squadRepository, SquadPositionRepository squadPositionRepository, PlayerRepository playerRepository)
        {
            this.squadRepository = squadRepository;
            this.squadPositionRepository = squadPositionRepository;
            this.playerRepository = playerRepository;
        }
        public async Task<MatchSquadResponse> GetMatchSquad(int matchId)
        {
            var matchSquad = await squadRepository.FindByCondition(s => s.MatchId == matchId)
                                    .Include(s => s.Match).ThenInclude(m => m.League)
                                    .Include(s => s.SquadPositions).ThenInclude(p => p.Player)
                                        .ToListAsync();
            return new MatchSquadResponse
            {
                Success = true,
                Home = mapper.Map<SquadDTO>(matchSquad.FirstOrDefault(s => s.IsHome)),
                Away = mapper.Map<SquadDTO>(matchSquad.FirstOrDefault(s => !s.IsHome))
            };
        }
        public async Task<SquadResponse> GetSquadById(int squadId)
        {
            var squad = await squadRepository.FindByCondition(s => s.SquadId == squadId)
                    .Include(s => s.Match).ThenInclude(m => m.League)
                    .Include(s => s.SquadPositions)
                    .ThenInclude(p => p.Player)
                    .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new SquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-01"
                };
            }
            return new SquadResponse
            {
                Success = true,
                Squad = mapper.Map<SquadDTO>(squad)
            };
        }

        public async Task<SquadResponse> GetSquadInMatch(SquadInMatchRequest request)
        {
            var squad = await squadRepository.FindByCondition(s => s.MatchId == request.MatchId && s.IsHome == request.IsHome)
                        .Include(s => s.SquadPositions)
                        .ThenInclude(p => p.Player)
                        .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new SquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-01"
                };
            }
            return new SquadResponse
            {
                Success = true,
                Squad = mapper.Map<SquadDTO>(squad)
            };
        }

        public async Task<List<PlayerSquadPositionDTO>> GetUnsquadPlayer(int squadId)
        {
            var result = new List<PlayerSquadPositionDTO>();
            var checkSquad = await squadRepository.FindByCondition(s => s.SquadId == squadId)
                            .Include(s => s.Match)
                                .ThenInclude(m => m.Home)
                                    .ThenInclude(h => h.ClubClone)
                            .Include(s => s.Match)
                                .ThenInclude(m => m.Away)
                                    .ThenInclude(a => a.ClubClone)
                            .FirstOrDefaultAsync();
            if (checkSquad != null)
            {
                List<Player> players = await playerRepository.FindByCondition(p =>
                            p.SquadPositions.FirstOrDefault(sp => sp.SquadId == squadId) == null &&
                            p.PlayerClubs.FirstOrDefault(pc =>
                                (checkSquad.IsHome ? checkSquad.Match.Home : checkSquad.Match.Away).ClubClone != null ?
                                pc.ClubId == (checkSquad.IsHome ? checkSquad.Match.Home : checkSquad.Match.Away).ClubClone.ClubId :
                                false
                            ) != null
                            ).ToListAsync();
                result = mapper.Map<List<PlayerSquadPositionDTO>>(players);
            }
            return result;
        }
        public async Task<List<PlayerSquadPositionDTO>> GetMatchPlayers(int matchId)
        {
            var players = await squadPositionRepository.FindByCondition(sp => sp.Squad.MatchId == matchId && sp.PlayerId != null)
                            .Include(sp => sp.Squad)
                            .Include(sp => sp.Player)
                                .Select(sp => sp.Player)
                                    .ToListAsync();
            return mapper.Map<List<PlayerSquadPositionDTO>>(players);
        }
        public async Task<List<PlayerSquadPositionDTO>> GetPlayerForEvent(PlayerForEventRequest request)
        {
            var squad = await squadRepository.FindByCondition(s =>
                            s.MatchId == request.MatchId &&
                            s.Match.Home.ClubClone != null &&
                            s.Match.Away.ClubClone != null &&
                            (
                                (s.Match.Home.ClubClone != null && s.Match.Home.ClubClone.ClubId == request.ClubId) ||
                                (s.Match.Away.ClubClone != null && s.Match.Away.ClubClone.ClubId == request.ClubId)
                            )
                        )
                        .Include(s => s.Match).ThenInclude(m => m.Home).ThenInclude(h => h.ClubClone)
                        .Include(s => s.Match).ThenInclude(m => m.Away).ThenInclude(h => h.ClubClone)
                        .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new List<PlayerSquadPositionDTO>();
            }
            bool isHome = false;
            if (squad.Match.Home.ClubClone.ClubId == request.ClubId)
            {
                isHome = true;
            }
            else if (squad.Match.Away.ClubClone.ClubId == request.ClubId)
            {
                isHome = false;
            }
            else
            {
                return new List<PlayerSquadPositionDTO>();
            }
            var players = new List<Player?>();
            switch (MethodUtils.GetMatchEventTypeByName(request.EventType))
            {
                case Constants.MatchEventType.Goal:
                case Constants.MatchEventType.YellowCard:
                case Constants.MatchEventType.RedCard:
                    players = await squadPositionRepository.FindByCondition(sp =>
                        sp.Squad.MatchId == request.MatchId &&
                        sp.Squad.IsHome == isHome &&
                        sp.PlayerId != null)
                            .Include(sp => sp.Squad)
                            .Include(sp => sp.Player)
                                .Select(sp => sp.Player)
                                    .ToListAsync();
                    break;
                case Constants.MatchEventType.OwnGoal:
                    players = await squadPositionRepository.FindByCondition(sp =>
                        sp.Squad.MatchId == request.MatchId &&
                        sp.Squad.IsHome == !isHome &&
                        sp.PlayerId != null)
                            .Include(sp => sp.Squad)
                            .Include(sp => sp.Player)
                                .Select(sp => sp.Player)
                                    .ToListAsync();
                    break;
                default:
                    return new List<PlayerSquadPositionDTO>();
            }
            return mapper.Map<List<PlayerSquadPositionDTO>>(players);
        }
        public async Task<AddPositionResponse> AddSquadPosition(AddPositionRequest request, int userId)
        {
            var position = await squadPositionRepository.FindByCondition(p =>
                        p.SquadPositionId == request.SquadPositionId)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Home)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Away)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                .FirstOrDefaultAsync();
            if (position == null)
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-02"
                };
            }

            if (!this.CheckManagePermission(position, userId))
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-08"
                };
            }

            if (position.PlayerId != null)
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-03"
                };
            }
            var checkValidPlayer = this.GetUnsquadPlayer(position.SquadId).Result.Where(p => p.PlayerId == request.PlayerId).FirstOrDefault();
            if (checkValidPlayer == null)
            {
                return new AddPositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-04"
                };
            }
            position.PlayerId = request.PlayerId;
            var result = await squadPositionRepository.UpdateAsync(position);
            if (result != null)
            {
                return new AddPositionResponse
                {
                    Success = true,
                    MessageCode = "MS-SQ-01"
                };
            }
            else
            {
                return new AddPositionResponse
                {
                    Success = true,
                    MessageCode = "ER-SQ-05"
                };
            }
        }
        private bool CheckManagePermission(SquadPosition position, int userId)
        {
            bool isHome = position.Squad.IsHome;
            var clubClone = isHome ? position.Squad.Match.Home.ClubClone : position.Squad.Match.Away.ClubClone;

            if (clubClone == null || clubClone.Club == null || clubClone.Club.UserId != userId)
            {
                return false;
            }
            return true;
        }
        public async Task<RemovePositionResponse> RemoveSquadPosition(int squadPositionId, int userId)
        {
            var position = await squadPositionRepository.FindByCondition(p =>
                    p.SquadPositionId == squadPositionId)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Home)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                        .Include(p => p.Squad)
                            .ThenInclude(s => s.Match)
                                .ThenInclude(m => m.Away)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                .FirstOrDefaultAsync();
            if (position == null)
            {
                return new RemovePositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-02"
                };
            }

            if (!this.CheckManagePermission(position, userId))
            {
                return new RemovePositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-09"
                };
            }
            if (position.PlayerId == null)
            {
                return new RemovePositionResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-06"
                };
            }
            position.PlayerId = null;
            var result = await squadPositionRepository.UpdateAsync(position);
            if (result != null)
            {
                return new RemovePositionResponse
                {
                    Success = true,
                    MessageCode = "MS-SQ-02"
                };
            }
            else
            {
                return new RemovePositionResponse
                {
                    Success = true,
                    MessageCode = "ER-SQ-07"
                };
            }
        }

        public async Task<UpdateSquadResponse> UpdateSquad(UpdateSquadRequest request, int userId)
        {
            var squad = await squadRepository.FindByCondition(s => s.SquadId == request.SquadId)
                                .Include(s => s.Match).ThenInclude(m => m.League)
                                .Include(s => s.SquadPositions)
                                .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new UpdateSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-01"
                };
            }
            if (request.Mains.Count != squad.Match.League.NoPlayerSquad)
            {
                return new UpdateSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-10"
                };
            }
            squad.SquadPositions.ToList().ForEach(sp => sp.PlayerId = null);
            var mainSquadPositions = squad.SquadPositions.Where(sp => !sp.PositionKey.Equals("P0")).OrderBy(sp => sp.PositionKey).ToList();
            int mainIndex = 0;
            mainSquadPositions.ForEach(sp =>
            {
                int? playerId = request.Mains.ElementAt(mainIndex++);
                if (playerId != null && playerId != 0)
                {
                    sp.PlayerId = playerId;
                }
            });
            int subIndex = 0;
            var subSquadPositions = squad.SquadPositions.Where(sp => sp.PositionKey.Equals("P0")).ToList();
            request.Subs.ForEach(s =>
            {
                if (s != null && s != 0)
                {
                    subSquadPositions.ElementAt(subIndex++).PlayerId = s;
                }
            });
            var result = await squadRepository.UpdateAsync(squad);

            if (result != null)
            {
                return new UpdateSquadResponse
                {
                    Success = true,
                    MessageCode = "MS-SQ-03"
                };
            }
            else
            {
                return new UpdateSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-11"
                };
            }
        }

        public async Task<UpdateSquadResponse> UpdateSquadPosition(UpdateSquadPositionRequest request, int userId)
        {
            var squad = await squadRepository.FindByCondition(s => s.SquadId == request.SquadId)
                                .Include(s => s.Match).ThenInclude(m => m.League)
                                .Include(s => s.SquadPositions)
                                .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new UpdateSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-01"
                };
            }
            if (request.Mains.Count != squad.Match.League.NoPlayerSquad)
            {
                return new UpdateSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-10"
                };
            }
            var mainSquadPositions = squad.SquadPositions.Where(sp => !sp.PositionKey.Equals("P0")).OrderBy(sp => sp.PositionKey).ToList();
            int mainIndex = 0;
            mainSquadPositions.ForEach(sp =>
            {
                var position = request.Mains.ElementAt(mainIndex);
               
                if (position != null)
                {
                    sp.PlayerId = position.PlayerId;
                    sp.CoordinateX = position.X;
                    sp.CoordinateY = position.Y;
                }
                else
                {
                    sp.PlayerId = null;
                    sp.CoordinateX = 0;
                    sp.CoordinateY = 0;
                }
                mainIndex++;
            });
            int subIndex = 0;
            var subSquadPositions = squad.SquadPositions.Where(sp => sp.PositionKey.Equals("P0")).ToList();
            request.Subs.ForEach(s =>
            {
                if (s != null && s.PlayerId != 0)
                {
                    subSquadPositions.ElementAt(subIndex++).PlayerId = s.PlayerId;
                }
            });
            var result = await squadRepository.UpdateAsync(squad);

            if (result != null)
            {
                return new UpdateSquadResponse
                {
                    Success = true,
                    MessageCode = "MS-SQ-03"
                };
            }
            else
            {
                return new UpdateSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-11"
                };
            }
        }
        public async Task<ManagerSquadResponse> GetSquadByManager(int squadId, int userId)
        {
            var UnsquadPlayers = new List<SquadPositionDTO>();
            var squad = await squadRepository.FindByCondition(s => s.SquadId == squadId)
                            .Include(s => s.Match)
                                .ThenInclude(m => m.League)
                            .Include(s => s.Match)
                                .ThenInclude(m => m.Home)
                                    .ThenInclude(h => h.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                            .Include(s => s.Match)
                                .ThenInclude(m => m.Away)
                                    .ThenInclude(a => a.ClubClone)
                                        .ThenInclude(cl => cl != null ? cl.Club : null)
                            .Include(s => s.SquadPositions)
                                .ThenInclude(sp => sp.Player)
                                    .ThenInclude(p => p.PlayerClubs)
                            .FirstOrDefaultAsync();
            if (squad == null)
            {
                return new ManagerSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-SQ-01"
                };
            }
            if (squad.Match.Home.ClubClone == null ||
                squad.Match.Home.ClubClone.Club == null ||
                squad.Match.Away.ClubClone == null ||
                squad.Match.Away.ClubClone.Club == null)
            {
                return new ManagerSquadResponse
                {
                    Success = false,
                    MessageCode = "ER-MA-06"
                };
            }
            List<Player> players = await playerRepository.FindByCondition(p =>
                            p.SquadPositions.FirstOrDefault(sp => sp.SquadId == squadId) == null &&
                            p.PlayerClubs.FirstOrDefault(pc =>
                                (squad.IsHome ? squad.Match.Home : squad.Match.Away).ClubClone != null && pc.ClubId == (squad.IsHome ? squad.Match.Home : squad.Match.Away).ClubClone.ClubId
                            ) != null)
                            .Include(p => p.PlayerClubs.Where(pc => pc.ClubId == (squad.IsHome ? squad.Match.Home : squad.Match.Away).ClubClone.ClubId))
                            .ToListAsync();
            UnsquadPlayers = mapper.Map<List<SquadPositionDTO>>(players);
            Match match = squad.Match;
            return new ManagerSquadResponse
            {
                Success = true,
                MatchId = squad.MatchId,
                IsHome = squad.IsHome,
                LeagueName = match.League.LeagueName,
                OwnClub = mapper.Map<ClubBasicInfoDTO>(squad.IsHome ? match.Home.ClubClone.Club : match.Away.ClubClone.Club),
                Against = mapper.Map<ClubBasicInfoDTO>(squad.IsHome ? match.Away.ClubClone.Club : match.Home.ClubClone.Club),
                MatchDate = match.MatchDate.ToString(Constants.DATE_FORMAT),
                MatchTime = match.MatchDate.ToString(Constants.TIME_FORMAT),
                UnSquadPositions = UnsquadPlayers,
                SquadPositions = squad.SquadPositions != null ? mapper.Map<List<SquadPositionDTO>>(squad.SquadPositions) : new List<SquadPositionDTO>(),
                Round = match.Round,
                Stadium = match.Stadium,
                NoPlayerSquad = squad.NoPlayerSquad,
                MaxNoPlayerSub = match.League.MaxNoPlayer - match.League.NoPlayerSquad,
                SquadId = squad.SquadId
            };
        }
        public async Task<List<PlayerSquadPositionDTO>> GetListPlayerJoinMatch(ListPlayerJoinMatchRequest request)
        {
            var result = new List<PlayerSquadPositionDTO>();
            var squad = await squadRepository.FindByCondition(s =>
                        s.MatchId == request.MatchId &&
                        (
                            (s.IsHome && s.Match.Home.ClubClone != null && s.Match.Home.ClubClone.ClubId == request.ClubId) ||
                            (!s.IsHome && s.Match.Away.ClubClone != null && s.Match.Away.ClubClone.ClubId == request.ClubId)
                        ))
                    .Include(s => s.Match).ThenInclude(m => m.Home).ThenInclude(h => h.ClubClone)
                    .Include(s => s.Match).ThenInclude(m => m.Away).ThenInclude(h => h.ClubClone)
                    .Include(s => s.SquadPositions).ThenInclude(sp => sp.Player)
                    .FirstOrDefaultAsync();
            if (squad != null)
            {
                var players = squad.SquadPositions.Where(sp => sp.Player != null).Select(sp => sp.Player).ToList();
                if (players != null && players.Count > 0)
                {
                    result = mapper.Map<List<PlayerSquadPositionDTO>>(players);
                }
            }
            return result;
        }
    }
}
