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
        public static List<ParticipateNode >GetListKo(int numberOfParticipate)
        {
            List<ParticipateNode> result = new List<ParticipateNode>();

            int count = 1;
            int sumNode = numberOfParticipate * 2 - 1;

            //Init tree
            Queue<ParticipateNode> queue = new Queue<ParticipateNode>();
            ParticipateNode root = new ParticipateNode { Deep = 1 };
            queue.Enqueue(root);
            List<ParticipateNode> participates = new List<ParticipateNode>();
            participates.Add(root);
            while (count < sumNode)
            {
                ParticipateNode participate = queue.Dequeue();
                ParticipateNode left = new ParticipateNode
                {
                    Parent = participate,
                    Deep = participate.Deep + 1
                };
                ParticipateNode right = new ParticipateNode
                {
                    Parent = participate,
                    Deep = participate.Deep + 1
                };
                queue.Enqueue(left);
                queue.Enqueue(right);
                participates.Add(left);
                participates.Add(right);
                count += 2;
            }
            queue = new Queue<ParticipateNode>();
            queue.Enqueue(root);

            while (queue.Count > 0)
            {
                var node = queue.Dequeue();
                result.Add(node);
                if (participates.FirstOrDefault(p => node.Equals(p.Parent))!=null)
                {
                    queue.Enqueue(participates.FirstOrDefault(p => node.Equals(p.Parent)));
                    queue.Enqueue(participates.LastOrDefault(p => node.Equals(p.Parent)));
                }
            }
            return result;
        }
        public static ParticipateNode GetKoRoot(int numberOfParticipate)
        {
            int count = 1;
            int sumNode = numberOfParticipate * 2 - 1;

            //Init tree
            Queue<ParticipateNode> queue = new Queue<ParticipateNode>();
            ParticipateNode root = new ParticipateNode { Deep = 1 };
            queue.Enqueue(root);
            while (count < sumNode)
            {
                List<ParticipateNode> participates = new List<ParticipateNode>();
                ParticipateNode participate = queue.Dequeue();
                ParticipateNode left = new ParticipateNode
                {
                    Parent = participate,
                    Deep = participate.Deep + 1
                };
                ParticipateNode right = new ParticipateNode
                {
                    Parent = participate,
                    Deep = participate.Deep + 1
                };
                queue.Enqueue(left);
                queue.Enqueue(right);
                participates.Add(left);
                participates.Add(right);
                participate.InverseParent = participates;
                count += 2;
            }
            return root;
        }
        public static List<ParticipateNode> GetKoListBFS(ParticipateNode root)
        {
            Queue<ParticipateNode> queue = new Queue<ParticipateNode>();
            queue.Enqueue(root);

            List<ParticipateNode> r = new List<ParticipateNode>();
            while (queue.Count > 0)
            {
                var node = queue.Dequeue();
                r.Add(node);
                if (node.InverseParent != null && node.InverseParent.Count!=0)
                {
                    queue.Enqueue(node.InverseParent.FirstOrDefault());
                    queue.Enqueue(node.InverseParent.LastOrDefault());
                }
            }
            return r;
        }

        public static List<ParticipateNode> GetKoList(int numberOfParticipate)
        {
            return GetKoListBFS(GetKoRoot(numberOfParticipate));
        }
        public static int[][] GetLeagueMatchMatrix(int numberOfParticipate)
        {
            int participate = 2;
            while (participate < numberOfParticipate)
            {
                participate *= 2;
            }
            int round = participate - 1;
            int[][] matrix = new int[participate][];
            for (int i = 0; i < participate; i++)
            {
                matrix[i] = new int[round];
            }

            return matrix;
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
                result[day][0] = (teams[teamIdx]+ " vs "+ ListTeam[0]);
                for (int idx = 1; idx < halfSize; idx++)
                {
                    int firstTeam = (day + idx) % teamsSize;
                    int secondTeam = (day + teamsSize - idx) % teamsSize;
                    //Console.WriteLine("{0} vs {1}", teams[firstTeam], teams[secondTeam]);
                    result[day][idx] = (teams[firstTeam] + " vs " + teams[secondTeam]);
                }
            }

            return result;
        }
    }
}
