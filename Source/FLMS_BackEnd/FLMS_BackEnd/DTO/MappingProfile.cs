using AutoMapper;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Utils;

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

            //User
            CreateMap<User, UserProfileDTO>();

            //Player
            CreateMap<Player, PlayerDTO>();

            CreateMap<PlayerClub, PlayerClubDTO>();

            CreateMap<CreatePlayerRequest, Player>();

            CreateMap<UpdatePlayerRequest, Player>();

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
                )
                ;

            CreateMap<Match, MatchDTO>();

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
                    ))
                ;
        }
    }
}
