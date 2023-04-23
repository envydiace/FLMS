using ClosedXML.Excel;
using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Utils
{
    public static class MethodUtils
    {
        public static bool CheckLeagueType(string type)
        {
            return Enum.GetValues(typeof(Constants.LeagueType))
                .Cast<Constants.LeagueType>()
                .Select(v => v.ToString())
                .ToList().Contains(type);
        }

        public static bool CheckUserRole(string role)
        {
            return Enum.GetValues(typeof(Constants.SystemRole))
                .Cast<Constants.SystemRole>()
                .Select(v => v.ToString())
                .ToList().Contains(role);
        }
        public static Constants.LeagueType? GetLeagueTypeByName(string name)
        {
            try
            {
                return (Constants.LeagueType)Enum.Parse(typeof(Constants.LeagueType), name);
            }
            catch (Exception)
            {
                return null;
            }

        }
        public static bool CheckEditableFeeKey(string feeKey)
        {
            if (feeKey != null && feeKey.ToUpper().StartsWith("F"))
            {
                try
                {
                    int keyIndex = int.Parse(feeKey.Substring(1, feeKey.Length - 1));
                    if (keyIndex > 0 && keyIndex < 8)
                    {
                        return false;
                    }
                }
                catch (Exception) { }
            }
            return true;
        }
        public static List<Squad> GenerateMatchSquad(int NoPlayerInSquad, int MaxPlayerInTeam)
        {
            List<Squad> result = new List<Squad>();
            if (MaxPlayerInTeam < NoPlayerInSquad)
            {
                return null;
            }
            List<SquadPosition> homeSquads = new List<SquadPosition>();
            List<SquadPosition> awaySquads = new List<SquadPosition>();
            for (int i = 0; i < NoPlayerInSquad; i++)
            {
                homeSquads.Add(new SquadPosition { PositionKey = "P" + (i + 1) });
                awaySquads.Add(new SquadPosition { PositionKey = "P" + (i + 1) });
            }
            for (int i = 0; i < MaxPlayerInTeam - NoPlayerInSquad; i++)
            {
                homeSquads.Add(new SquadPosition { PositionKey = "P0" });
                awaySquads.Add(new SquadPosition { PositionKey = "P0" });
            }
            Squad home = new Squad
            {
                IsHome = true,
                NoPlayerSquad = NoPlayerInSquad,
                SquadPositions = homeSquads
            };
            result.Add(home);
            Squad away = new Squad
            {
                IsHome = false,
                NoPlayerSquad = NoPlayerInSquad,
                SquadPositions = awaySquads
            };
            result.Add(away);
            return result;
        }

        public static string? GetLeagueKoRound(int deep)
        {
            string result = "";
            if (deep < 1) return null;
            switch (deep)
            {
                case 1:
                    result = "Final";
                    break;
                case 2:
                    result = "Semi Final";
                    break;
                case 3:
                    result = "Quater Final";
                    break;
                default:
                    result = "1/" + (Math.Pow(2, deep - 1));
                    break;
            }
            return result;
        }
        public static int CountLeagueDateRange(string type, int numberOfParticipation)
        {
            if (numberOfParticipation < 2) return 0;
            switch (MethodUtils.GetLeagueTypeByName(type))
            {
                case Constants.LeagueType.KO:
                    int height = 1;
                    while (numberOfParticipation > Math.Pow(2, height))
                    {
                        height++;
                    }
                    return height * 2 - 1;
                case Constants.LeagueType.LEAGUE:
                    return (numberOfParticipation % 2 == 0 ? numberOfParticipation - 1 : numberOfParticipation) * 2 - 1;
                case Constants.LeagueType.TABLE:
                    return 0;
                default:
                    return 0;
            }
        }
        public static Constants.MatchEventType? GetMatchEventTypeByName(string name)
        {
            try
            {
                return (Constants.MatchEventType)Enum.Parse(typeof(Constants.MatchEventType), name);
            }
            catch (Exception)
            {
                return null;
            }

        }
        public static bool CheckFeeType(string feeType)
        {
            return Enum.GetValues(typeof(Constants.FeeType))
                .Cast<Constants.FeeType>()
                .Select(v => v.ToString())
                .ToList().Contains(feeType);
        }
        public static int CountNumberOfRound(string type, int NumberOfParticipate)
        {
            Constants.LeagueType? leagueType = GetLeagueTypeByName(type);
            int result = 0;
            switch (leagueType)
            {
                case Constants.LeagueType.LEAGUE:
                    result = NumberOfParticipate - 1;
                    break;
                case Constants.LeagueType.TABLE:
                    break;
                case Constants.LeagueType.KO:
                    int sum = 0;
                    int participate = 1;
                    while (participate < NumberOfParticipate)
                    {
                        participate *= 2;
                        sum++;
                    }
                    result = sum;
                    break;
                default:
                    break;
            }
            return result;
        }
        public static decimal SumTotalLeagueFee(List<LeagueFeeDTO> leagueFees)
        {
            var totalfee = ((from e in leagueFees where e.FeeType.Equals(Constants.FeeType.Prize.ToString()) select e.Cost).Sum() +
                (from e in leagueFees where e.FeeType.Equals(Constants.FeeType.Fee.ToString()) select e.Cost).Sum() -
                (from e in leagueFees where e.FeeType.Equals(Constants.FeeType.Sponsored.ToString()) select e.Cost).Sum());
            return totalfee;
        }
        public static int GetTotalAmountByResult(Club club, string type)
        {
            return type switch
            {
                Constants.LeagueStatistic.WinKey => club.ClubClones.Sum(cl => cl.Won),
                Constants.LeagueStatistic.DrawKey => club.ClubClones.Sum(cl => cl.Draw),
                Constants.LeagueStatistic.LossKey => club.ClubClones.Sum(cl => cl.Loss),
                _ => 0,
            };
        }
        public static bool CheckLeagueStatus(string status)
        {
            return Enum.GetValues(typeof(Constants.LeagueStatus))
                .Cast<Constants.LeagueStatus>()
                .Select(v => v.ToString())
                .ToList().Contains(status);
        }
        public static List<string> GetClubHistoryInLeagueStatistic(ClubClone clubClone)
        {
            var result = new List<string>();
            var participateNote = clubClone.ParticipateNodes.FirstOrDefault();
            if (participateNote != null)
            {
                var listMatch = participateNote.MatchHomes.Where(m => m.IsFinish).ToList();
                listMatch.AddRange(participateNote.MatchAways.Where(m => m.IsFinish).ToList());
                listMatch = listMatch.OrderByDescending(m => m.MatchDate).Take(3).ToList();
                listMatch.ForEach(m =>
                {
                    int goalFor = 0, goalAgainst = 0;
                    var ms = m.MatchStats.FirstOrDefault(ms => ms.IsHome == m.HomeId.Equals(participateNote.ParticipateNodeId));
                    goalFor = ms != null ? ms.Score : 0;
                    ms = m.MatchStats.FirstOrDefault(ms => ms.IsHome != m.HomeId.Equals(participateNote.ParticipateNodeId));
                    goalAgainst = ms != null ? ms.Score : 0;
                    if (goalFor > goalAgainst)
                    {
                        result.Add(Constants.LeagueStatistic.WinKey);
                    }
                    else if (goalFor < goalAgainst)
                    {
                        result.Add(Constants.LeagueStatistic.LossKey);
                    }
                    else
                    {
                        result.Add(Constants.LeagueStatistic.DrawKey);
                    }
                });
            }
            return result;
        }
        public static int GetPlayerNumber(SquadPosition squadPosition)
        {
            if (squadPosition.Player != null)
            {
                int? clubId = null;
                if (squadPosition.Squad.IsHome && squadPosition.Squad.Match.Home.ClubClone != null && squadPosition.Squad.Match.Home.ClubClone != null)
                {
                    clubId = squadPosition.Squad.Match.Home.ClubClone.ClubId;
                }
                else if (!squadPosition.Squad.IsHome && squadPosition.Squad.Match.Away.ClubClone != null && squadPosition.Squad.Match.Away.ClubClone != null)
                {
                    clubId = squadPosition.Squad.Match.Away.ClubClone.ClubId;
                }
                if (clubId != null)
                {
                    var playerClub = squadPosition.Player.PlayerClubs.FirstOrDefault(pc => pc.ClubId == clubId);
                    if (playerClub != null)
                    {
                        return playerClub.Number;
                    }
                }
            }
            return 0;
        }

        public static int GetNodeScore(ParticipateNode node)
        {
            bool isHome;
            var match = node.MatchHomes.FirstOrDefault();
            if (match != null)
            {
                isHome = true;
            }
            else
            {
                match = node.MatchAways.FirstOrDefault();
                if (match != null)
                {
                    isHome = false;
                }
                else
                {
                    return 0;
                }
            }
            return match.MatchEvents.Where(ev => ev.IsHome == isHome &&
                (ev.EventType.Equals(Constants.MatchEventType.Goal.ToString()) ||
                ev.EventType.Equals(Constants.MatchEventType.OwnGoal.ToString()))
                ).Count();
        }

        public static void SetColumnWidths(IXLWorksheet worksheet)
        {
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.Time]).Width = 12;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.Date]).Width = 20;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.Home]).Width = 30;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.HomeScore]).Width = 16;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.AwayScore]).Width = 16;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.Away]).Width = 30;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.Round]).Width = 12;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.Stadium]).Width = 36;
            worksheet.Column(Constants.columnMapLeagueSchedule[Constants.DataColumn.Status]).Width = 20;
        }
        public static ParticipateNodeDTO GetKoRoot(int numberOfParticipate)
        {
            int rootId = 1;
            int count = 1;
            int sumNode = numberOfParticipate * 2 - 1;

            //Init tree
            Queue<ParticipateNodeDTO> queue = new Queue<ParticipateNodeDTO>();
            ParticipateNodeDTO root = new ParticipateNodeDTO { ParticipateId = rootId, Deep = 1 };
            queue.Enqueue(root);
            while (count < sumNode)
            {
                ParticipateNodeDTO participate = queue.Dequeue();
                participate.LeftParticipate = new ParticipateNodeDTO
                {
                    ParticipateId = count + rootId,
                    ParentParticipate = participate,
                    Deep = participate.Deep + 1
                };
                participate.RightParticipate = new ParticipateNodeDTO
                {
                    ParticipateId = count + rootId + 1,
                    ParentParticipate = participate,
                    Deep = participate.Deep + 1
                };
                queue.Enqueue(participate.LeftParticipate);
                queue.Enqueue(participate.RightParticipate);
                count += 2;
            }
            return root;
        }
        public static List<ParticipateNodeDTO> GetKoListBFS(ParticipateNodeDTO root)
        {
            Queue<ParticipateNodeDTO> queue = new Queue<ParticipateNodeDTO>();
            queue.Enqueue(root);

            List<ParticipateNodeDTO> r = new List<ParticipateNodeDTO>();
            while (queue.Count > 0)
            {
                var node = queue.Dequeue();
                r.Add(node);
                if (node.LeftParticipate != null)
                {
                    queue.Enqueue(node.LeftParticipate);
                }
                if (node.RightParticipate != null)
                {
                    queue.Enqueue(node.RightParticipate);
                }
            }
            return r;
        }

        public static List<ParticipateNodeDTO> GetKoList(int numberOfParticipate)
        {
            return GetKoListBFS(GetKoRoot(numberOfParticipate));
        }
        public static string[][] GetListMatches(List<string> ListTeam)
        {
            int numTeams = ListTeam.Count;
            int noParti = 1;
            while (noParti < numTeams)
            {
                noParti *= 2;
            }
            for (int i = numTeams; i < noParti; i++)
            {
                ListTeam.Add("Bye");
            }

            int numDays = (noParti - 1);
            int halfSize = noParti / 2;

            string[][] result = new string[numDays][];

            for (int i = 0; i < numDays; i++)
            {
                result[i] = new string[halfSize];
            }

            List<string> teams = new List<string>();

            teams.AddRange(ListTeam);
            teams.RemoveAt(0);

            int teamsSize = teams.Count;

            for (int day = 0; day < numDays; day++)
            {
                //Console.WriteLine("Day {0}", (day + 1));

                int teamIdx = day % teamsSize;

                //Console.WriteLine("{0} vs {1}", teams[teamIdx], ListTeam[0]);
                result[day][0] = (teams[teamIdx] + "/" + ListTeam[0]);
                for (int idx = 1; idx < halfSize; idx++)
                {
                    int firstTeam = (day + idx) % teamsSize;
                    int secondTeam = (day + teamsSize - idx) % teamsSize;
                    //Console.WriteLine("{0} vs {1}", teams[firstTeam], teams[secondTeam]);
                    result[day][idx] = (teams[firstTeam] + "/" + teams[secondTeam]);
                }
            }

            return result;
        }
    }
}
