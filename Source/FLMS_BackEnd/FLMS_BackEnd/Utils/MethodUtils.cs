using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;

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
        public static Constants.LeagueType GetLeagueTypeByName(string name)
        {
            return (Constants.LeagueType)Enum.Parse(typeof(Constants.LeagueType), name);
        }

        public static int CountNumberOfRound(string type, int NumberOfParticipate)
        {
            Constants.LeagueType leagueType = GetLeagueTypeByName(type);
            int result = 0;
            switch (leagueType)
            {
                case Constants.LeagueType.LEAGUE:
                    result = NumberOfParticipate - 1;
                    break;
                case Constants.LeagueType.TABLE:
                    break;
                case Constants.LeagueType.KO:
                    int sum = 1;
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
