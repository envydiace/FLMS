using AutoMapper;
using DocumentFormat.OpenXml.EMMA;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Utils;
using System.Numerics;

namespace FLMS_BackEnd.DTO
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            //Club
            CreateMap<CreateClubRequest, Club>()
                .ForMember(club => club.CreateAt,
                map => map.MapFrom(
                    request => DateTime.Now
                    ));

            CreateMap<Club, ClubDTO>()
                .ForMember(dto => dto.ManagerName,
                map => map.MapFrom(
                    club => club.User.FullName
                    ));

            CreateMap<UpdateClubRequest, Club>();

            CreateMap<Club, ClubByUserDTO>();

            CreateMap<ClubClone, ClubHistoryDTO>()
                .ForMember(history => history.LeagueName,
                map => map.MapFrom(
                    clubClone => clubClone.League.LeagueName))
                .ForMember(history => history.JoinedDate,
                map => map.MapFrom(
                    clubClone => clubClone.League.Participations.Where(p =>
                                p.ClubId == clubClone.ClubId &&
                                p.LeagueId == clubClone.LeagueId)
                        .Select(p => p.JoinDate)
                            .FirstOrDefault()))
                ;
            CreateMap<Club, UnpositionClubDTO>();
            //User
            CreateMap<User, UserProfileDTO>()
                .ForMember(dto => dto.Role,
                map => map.MapFrom(
                    user => user.Role.Replace('_', ' ')
                    ));

            //Player
            CreateMap<Player, PlayerDTO>();

            CreateMap<PlayerClub, PlayerClubDTO>();

            CreateMap<CreatePlayerRequest, Player>();

            CreateMap<UpdatePlayerRequest, Player>();

            CreateMap<Player, PlayerSquadPositionDTO>();

            CreateMap<PlayerClub, PlayerSearchDTO>()
                .ForMember(dto => dto.Avatar,
                map => map.MapFrom(
                    pclub => pclub.Player.Avatar
                    ))
                .ForMember(dto => dto.Name,
                map => map.MapFrom(
                    pclub => pclub.Player.Name
                    ));

            //League
            CreateMap<CreateLeagueRequest, League>()
                .ForMember(league => league.CreateAt,
                map => map.MapFrom(
                    request => DateTime.Now
                    ))
                .ForMember(league => league.LeagueName,
                map => map.MapFrom(
                    request => request.LeagueName.Trim()
                    ));

            CreateMap<LeagueFeeRequest, LeagueFee>()
                .ForMember(fee => fee.IsActual,
                map => map.MapFrom(
                    request => false
                    ))
                .ForMember(fee => fee.FeeType,
                map => map.MapFrom(
                    request => Constants.FeeType.Fee.ToString()
                    ))
                .ForMember(fee => fee.ExpenseKey,
                map => map.MapFrom(
                    request => Constants.Fee.FeeKey
                    ));
            CreateMap<LeaguePrizeRequest, LeagueFee>()
                .ForMember(fee => fee.IsActual,
                map => map.MapFrom(
                    request => false
                    ))
                .ForMember(fee => fee.FeeType,
                map => map.MapFrom(
                    request => Constants.FeeType.Prize.ToString()
                    ));

            CreateMap<ParticipateNodeDTO, ParticipateNode>();

            CreateMap<ClubCloneDTO, ClubClone>();

            CreateMap<League, LeagueDTO>();

            CreateMap<League, LeagueInfoDTO>()
                .ForMember(dto => dto.ManagerName,
                map => map.MapFrom(
                    league => league.User.FullName
                    ))
                .ForMember(dto => dto.TotalPrize,
                map => map.MapFrom(
                    league => league.LeagueFees.Sum(fee => fee.Cost)));

            CreateMap<LeagueFee, LeagueFeeDTO>();

            CreateMap<LeagueFee, LeagueFeeClubDTO>();

            CreateMap<League, LeagueByUserDTO>();

            CreateMap<ClubClone, LeagueStandingDTO>()
                .ForMember(standing => standing.ClubName,
                map => map.MapFrom(
                    clubClone => clubClone.Club != null ? clubClone.Club.ClubName : clubClone.ClubCloneKey.Trim()));

            CreateMap<League, JoinedLeagueDTO>();

            //Match
            CreateMap<ParticipateNode, ClubMatchDTO>()
                .ForMember(dto => dto.ClubId,
                map => map.MapFrom(
                    node => (node.ClubClone != null && node.ClubClone.Club != null) ? node.ClubClone.Club.ClubId : 0)
                )
                .ForMember(dto => dto.Name,
                map => map.MapFrom(
                    node => node.ClubClone != null ?
                        (node.ClubClone.Club != null ?
                            node.ClubClone.Club.ClubName.Trim() :
                            node.ClubClone.ClubCloneKey.Trim()) :
                        "Not Yet"
                    ))
                .ForMember(dto => dto.Logo,
                map => map.MapFrom(
                    node => (node.ClubClone != null && node.ClubClone.Club != null) ? node.ClubClone.Club.Logo : null)
                );
            CreateMap<Match, MatchClubDTO>()
                .ForMember(dto => dto.MatchDate,
                map => map.MapFrom(
                    match => match.MatchDate.ToString(Constants.DATE_FORMAT)))
                .ForMember(dto => dto.MatchTime,
                map => map.MapFrom(
                    match => match.MatchDate.ToString(Constants.TIME_FORMAT)))
                .ForMember(dto => dto.LeagueName,
                map => map.MapFrom(
                    match => match.League.LeagueName));
            CreateMap<Match, MatchDTO>()
                .ForMember(dto => dto.MatchDate,
                map => map.MapFrom(
                    match => match.MatchDate.ToString(Constants.DATE_FORMAT)))
                .ForMember(dto => dto.MatchTime,
                map => map.MapFrom(
                    match => match.MatchDate.ToString(Constants.TIME_FORMAT)))
                .ForMember(dto => dto.LeagueName,
                map => map.MapFrom(
                    match => match.League.LeagueName));

            //Squad
            CreateMap<SquadPosition, SquadPositionDTO>()
                .ForMember(dto => dto.PlayerName,
                map => map.MapFrom(
                    squadPosition => squadPosition.Player != null ? squadPosition.Player.Name : null))
                .ForMember(dto => dto.PlayerAvatar,
                map => map.MapFrom(
                    squadPosition => squadPosition.Player != null ? squadPosition.Player.Avatar : null));

            CreateMap<Squad, SquadDTO>()
                .ForMember(dto => dto.NoPlayerSquad,
                map => map.MapFrom(
                    squad => squad.Match.League.NoPlayerSquad ))
                .ForMember(dto => dto.MaxNoPlayerSub,
                map => map.MapFrom(
                    squad => squad.Match.League.MaxNoPlayer - squad.Match.League.NoPlayerSquad))
                .ForMember(dto => dto.StartingSquad,
                map => map.MapFrom(
                    squad => squad.SquadPositions.Where(p => !p.PositionKey.Equals("P0"))))
                .ForMember(dto => dto.Substitution,
                map => map.MapFrom(
                    squad => squad.SquadPositions.Where(p => p.PositionKey.Equals("P0"))));

            //Request
            CreateMap<JoinRequest, ParticipateRequest>()
                .ForMember(request => request.RequestDate,
                map => map.MapFrom(
                    r => DateTime.Now
                    ))
                .ForMember(request => request.RequestStatus,
                map => map.MapFrom(
                    r => Constants.RequestStatus.Pending.ToString()
                    ));

            CreateMap<ParticipateRequest, RequestDTO>()
                .ForMember(dto => dto.ClubName,
                map => map.MapFrom(
                    request => request.Club.ClubName
                    ))
                .ForMember(dto => dto.LeagueName,
                map => map.MapFrom(
                    request => request.League.LeagueName
                    ));

            //Participation
            CreateMap<Participation, ParticipationClubDTO>()
                .ForMember(dto => dto.ClubName,
                map => map.MapFrom(
                    pa => pa.Club.ClubName
                    ));

            //MatchEvent
            CreateMap<MatchEvent, MatchEventDTO>();

            CreateMap<Player, MatchEventPlayerDTO>();

            //MatchStatistic
            CreateMap<MatchStat, StatisticDTO>();

            CreateMap<StatInfoDTO, MatchStat>();
        }
    }
}
