using AutoMapper;
using FLMS_BackEnd.DTO;

namespace FLMS_BackEnd.Services.Impl
{
    public class BaseService
    {
        public IMapper mapper;
        public BaseService()
        {
            var config = new MapperConfiguration(cfg => cfg.AddProfile(new MappingProfile()));
            this.mapper = config.CreateMapper();
        }
    }
}
