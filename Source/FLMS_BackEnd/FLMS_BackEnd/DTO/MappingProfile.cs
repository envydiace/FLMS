using AutoMapper;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;

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

            CreateMap<PlayerClubRequest, PlayerClub>();

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

            CreateMap<Match, MatchDTO>()
                //.ForMember(dto => dto.HomeName,
                //map => map.MapFrom(
                //    match => match.Home.ClubClone!=null? 
                //        (match.Home.ClubClone.Club!=null? 
                //            match.Home.ClubClone.Club.ClubName.Trim() : 
                //            match.Home.ClubClone.ClubCloneKey.Trim()) :
                //        "Not Yet"
                //    ))
                //.ForMember(dto => dto.AwayName,
                //map => map.MapFrom(
                //    match => match.Away.ClubClone != null ?
                //        (match.Away.ClubClone.Club != null ?
                //            match.Away.ClubClone.Club.ClubName.Trim() :
                //            match.Away.ClubClone.ClubCloneKey.Trim()) :
                //        "Not Yet"
                //    ))
                ;
        }
    }
}
