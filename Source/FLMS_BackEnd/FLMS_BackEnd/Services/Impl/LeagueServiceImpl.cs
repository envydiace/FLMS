
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;

namespace FLMS_BackEnd.Services.Impl
{
    public class LeagueServiceImpl : BaseService, LeagueService
    {
        private readonly LeagueRepository leagueRepository;

        public LeagueServiceImpl(LeagueRepository leagueRepository)
        {
            this.leagueRepository = leagueRepository;
        }

        public async Task<CreateLeagueResponse> CreateLeague(CreateLeagueRequest request, int userId)
        {
            if (!MethodUtils.CheckLeagueType(request.LeagueType))
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-04"
                };
            }
            int numberOfRound = MethodUtils.CountNumberOfRound(request.LeagueType, request.NoParticipate);
            if (request.EndDate.CompareTo(request.StartDate) <= 0)
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-03"
                };
            }
            var league = await leagueRepository.FindByCondition(league => league.LeagueName.ToLower().Trim().Equals(request.LeagueName.ToLower().Trim())).FirstOrDefaultAsync();
            if (league != null)
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-02"
                };
            }
            league = mapper.Map<League>(request);
            league.UserId = userId;

            ICollection<ClubClone> clubClones = new List<ClubClone>();
            for (int i = 0; i < request.NoParticipate; i++)
            {
                clubClones.Add(new ClubClone { ClubCloneKey = "C" + (i + 1) });
            }
            ICollection<ParticipateNodeDTO> participateNodes = MethodUtils.GetKoList(request.NoParticipate);
            league.ClubClones = clubClones;
            List<ParticipateNode> participates = mapper.Map<List<ParticipateNode>>(participateNodes);
            int index = 0;
            foreach(ParticipateNode participateNode in participates.Where(p => p.LeftId==0))
            {
                participateNode.ClubClone = clubClones.ElementAt(index);
                index++;
            }
            league.ParticipateNodes = participates;

            var result = await leagueRepository.CreateAsync(league);
            if (result)
            {
                return new CreateLeagueResponse
                {
                    Success = true,
                    MessageCode = "MS-LE-01"
                };
            }
            else
            {
                return new CreateLeagueResponse
                {
                    Success = false,
                    MessageCode = "ER-LE-01"
                };
            }
        }
    }
}
