using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Repositories;
using FLMS_BackEnd.Utils;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Asn1.Ocsp;
using System.Data;
using System.Reflection.Metadata;

namespace FLMS_BackEnd.Services.Impl
{
    public class ExportServiceImpl : BaseService, ExportService
    {
        private readonly PlayerRepository playerRepository;
        private readonly MatchRepository matchRepository;
        public ExportServiceImpl(PlayerRepository playerRepository, MatchRepository matchRepository)
        {
            this.playerRepository = playerRepository;
            this.matchRepository = matchRepository;
        }
        public async Task<DataTable> ExportLeagueSchedule(int LeagueId)
        {
            List<Match> matches = await matchRepository.FindByCondition
            (m => m.LeagueId == LeagueId)
            .Include(m => m.League)
            .Include(m => m.Home).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
            .Include(m => m.Away).ThenInclude(p => p.ClubClone).ThenInclude(c => c != null ? c.Club : null)
            .Include(m => m.MatchStats)
            .OrderBy(m => m.MatchDate)
            .ToListAsync();

            var listMatch = mapper.Map<List<MatchDTO>>(matches);
            listMatch.ForEach(m =>
            {
                var match = matches.Where(x => x.MatchId == m.MatchId).FirstOrDefault();
                if (match != null && match.IsFinish)
                {
                    var homeStats = match.MatchStats.FirstOrDefault(ms => ms.IsHome);
                    m.Home.Score = homeStats != null ? homeStats.Score : 0;
                    var awayStats = match.MatchStats.FirstOrDefault(ms => !ms.IsHome);
                    m.Away.Score = awayStats != null ? awayStats.Score : 0;
                }
            });
            DataTable dtLeagueSchedule = new DataTable("LeagueSchedule");
            dtLeagueSchedule.Columns.AddRange(new DataColumn[9]
            {
                new DataColumn(Constants.DataColumn.Time),
                new DataColumn(Constants.DataColumn.Date),
                new DataColumn(Constants.DataColumn.Home),
                new DataColumn(Constants.DataColumn.HomeScore),
                new DataColumn(Constants.DataColumn.AwayScore),
                new DataColumn(Constants.DataColumn.Away),
                new DataColumn(Constants.DataColumn.Round),
                new DataColumn(Constants.DataColumn.Stadium),
                new DataColumn(Constants.DataColumn.Status)
            });
            foreach (var match in listMatch)
            {
                dtLeagueSchedule.Rows.Add(match.MatchTime, match.MatchDate, match.Home.Name, 
                    match.IsFinish ? match.Home.Score : "-", match.IsFinish ? match.Away.Score : "-", match.Away.Name,
                    match.Round, match.Stadium, match.IsFinish ? "Finished" : "Not yet");
            }

            return dtLeagueSchedule;
        }

        public async Task<DataTable> ExportPlayer()
        {
            var players = await playerRepository.FindAll().ToListAsync();
            var result = mapper.Map<List<PlayerInfoDTO>>(players.ToList());
            DataTable dtPlayer = new DataTable("Players");
            dtPlayer.Columns.AddRange(new DataColumn[4] { new DataColumn("Name"),
                                            new DataColumn("NickName"),
                                            new DataColumn("Height"),
                                            new DataColumn("Weight") });
            foreach (var player in result)
            {
                dtPlayer.Rows.Add(player.Name, "", player.Height, player.Weight);
            }

            return dtPlayer;
        }
    }
}
