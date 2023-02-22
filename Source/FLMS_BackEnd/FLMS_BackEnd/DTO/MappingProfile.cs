using AutoMapper;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Request;

namespace FLMS_BackEnd.DTO
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
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

            CreateMap<User,UserProfileDTO>();

            CreateMap<UpdateClubRequest, Club>();

            CreateMap<Player, PlayerDTO>();

            CreateMap<CreatePlayerRequest, Player>();

            CreateMap<PlayerClubRequest, PlayerClub>();

            CreateMap<CreateLeagueRequest, League>()
                .ForMember(league => league.CreateAt,
                map => map.MapFrom(
                    request => DateTime.Now
                    )); 

            CreateMap<LeagueFeeRequest, LeagueFee>()
                .ForMember(fee => fee.IsActual,
                map => map.MapFrom(
                    request => false
                    )); 
        }
    }
}
