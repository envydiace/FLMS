using FLMS_BackEnd.DTO;

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
                    int sum = 3;
                    int participate = 2;
                    while (participate < NumberOfParticipate)
                    {
                        participate *= 2;
                        sum += participate;
                    }
                    result = sum - 1;
                    break;
                default:
                    break;
            }
            return result;
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

        public static List<ParticipateNodeDTO> GetKoList(int numberOfParticipate)
        {
            int index = 1;
            List<ParticipateNodeDTO> result = new List<ParticipateNodeDTO>();
            Queue<ParticipateNodeDTO> queue = new Queue<ParticipateNodeDTO>();
            ParticipateNodeDTO root = new ParticipateNodeDTO { ParticipateId = 0 };
            queue.Enqueue(root);
            while (result.Count< numberOfParticipate)
            {
                ParticipateNodeDTO participate = queue.Dequeue();
                ParticipateNodeDTO left = new ParticipateNodeDTO { ParticipateId = index++, ParentParticipate = participate.ParticipateId };
                ParticipateNodeDTO right = new ParticipateNodeDTO { ParticipateId = index++, ParentParticipate = participate.ParticipateId };
                participate.LeftParticipate = left.ParticipateId;
                participate.RightParticipate = right.ParticipateId;
                result.Add(participate);
                queue.Enqueue(left);
                queue.Enqueue(right);
            }
            return result;
        }
    }
}
