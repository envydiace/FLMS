using FLMS_BackEnd.DTO;
using FLMS_BackEnd.Models;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using NUnit.Framework;

namespace FLMS_BackEnd.Test
{
    [TestFixture]
    public class TestMethodUtils
    {
        [TestCase("KO", true)]
        [TestCase("LEAGUE", true)]
        [TestCase("TABLE", true)]
        [TestCase("ko", false)]
        [TestCase("table", false)]
        [TestCase("league", false)]
        [TestCase("a", false)]
        public void TestCheckLEagueType(string type, bool expect)
        {
            bool actual = MethodUtils.CheckLeagueType(type);
            Assert.AreEqual(expect, actual);
        }
        [TestCase("LEAGUE_MANAGER", true)]
        [TestCase("LEAGUE MANAGER", false)]
        ///TODO: more testcase
        public void TestCheckRole(string role, bool expect)
        {
            bool actual = MethodUtils.CheckUserRole(role);
            Assert.AreEqual(expect, actual);
        }

        [TestCase("KO", Constants.LeagueType.KO)]
        [TestCase("ko", null)]
        [TestCase("LEAGUE", Constants.LeagueType.LEAGUE)]
        [TestCase("a", null)]
        [TestCase("TABLE", Constants.LeagueType.TABLE)]
        public void TestGetLeagueTypeByName(string type, Constants.LeagueType? expect)
        {
            Constants.LeagueType? actual = MethodUtils.GetLeagueTypeByName(type);
            Assert.AreEqual(expect, actual);
        }

        [TestCaseSource(nameof(SourceProviderTestCheckEditableFeeKey))]
        public void TestCheckEditableFeeKey(string key, bool expect)
        {
            bool actual = MethodUtils.CheckEditableFeeKey(key);
            Assert.AreEqual(expect, actual);
        }
        public static IEnumerable<object[]> SourceProviderTestCheckEditableFeeKey()
        {
            yield return new object[] { "Fx", true };
            yield return new object[] { "F0", true };
            yield return new object[] { "F1", false };
            yield return new object[] { "F7", false };
            yield return new object[] { "f5", false };
            yield return new object[] { null, true };
            yield return new object[] { "f9", true };
        }

        [TestCaseSource(nameof(SourceProviderTestGenerateMatchSquad))]
        public void TestGenerateMatchSquad(int NoPlayerSquad, int MaxplayerTeam)
        {
            if (NoPlayerSquad > MaxplayerTeam)
            {
                List<Squad> result = MethodUtils.GenerateMatchSquad(NoPlayerSquad, MaxplayerTeam);
                Assert.AreEqual(null, result);
            }
            else
            {
                List<Squad> result = MethodUtils.GenerateMatchSquad(NoPlayerSquad, MaxplayerTeam);

                Assert.AreEqual(true, result.First().IsHome);
                Assert.AreEqual(false, result.Last().IsHome);
                Assert.AreEqual(NoPlayerSquad, result.First().NoPlayerSquad);
                Assert.AreEqual(NoPlayerSquad, result.Last().NoPlayerSquad);

                Assert.AreEqual(MaxplayerTeam, result.First().SquadPositions.Count);
                Assert.AreEqual(MaxplayerTeam, result.Last().SquadPositions.Count);

                Assert.AreEqual("P1", result.First().SquadPositions.ElementAt(0).PositionKey);
                Assert.AreEqual("P" + NoPlayerSquad, result.First().SquadPositions.ElementAt(NoPlayerSquad - 1).PositionKey);
                Assert.AreEqual("P0", result.First().SquadPositions.ElementAt(NoPlayerSquad).PositionKey);
                Assert.AreEqual("P0", result.First().SquadPositions.ElementAt(MaxplayerTeam - 1).PositionKey);

                Assert.AreEqual("P1", result.Last().SquadPositions.ElementAt(0).PositionKey);
                Assert.AreEqual("P" + NoPlayerSquad, result.Last().SquadPositions.ElementAt(NoPlayerSquad - 1).PositionKey);
                Assert.AreEqual("P0", result.Last().SquadPositions.ElementAt(NoPlayerSquad).PositionKey);
                Assert.AreEqual("P0", result.Last().SquadPositions.ElementAt(MaxplayerTeam - 1).PositionKey);
            }
        }

        public static IEnumerable<object[]> SourceProviderTestGenerateMatchSquad()
        {
            yield return new object[] { 5, 15 };
            yield return new object[] { 10, 3 };
            yield return new object[] { 7, 16 };
        }
        [TestCaseSource(nameof(SourceProviderTestGetLeagueKoRound))]
        public void TestGetLeagueKoRound(int deep, string expect)
        {
            string actual = MethodUtils.GetLeagueKoRound(deep);
            Assert.AreEqual(expect, actual);
        }
        public static IEnumerable<object[]> SourceProviderTestGetLeagueKoRound()
        {
            yield return new object[] { 1, "Final" };
            yield return new object[] { 2, "Semi Final" };
            yield return new object[] { 3, "Quarter Final" };
            yield return new object[] { 4, "1/8" };
            yield return new object[] { 5, "1/16" };
            yield return new object[] { 6, "1/32" };
            yield return new object[] { 0, null };
            yield return new object[] { -1, null };
        }

        [TestCaseSource(nameof(SourceProviderTestCountLeagueDateRange))]
        public void TestCountLeagueDateRange(string type, int numberOfParticipation, int expect)
        {
            int actual = MethodUtils.CountLeagueDateRange(type, numberOfParticipation);
            Assert.AreEqual(expect, actual);
        }
        public static IEnumerable<object[]> SourceProviderTestCountLeagueDateRange()
        {
            yield return new object[] { "LEAGUE", 1, 0 };
            yield return new object[] { "LEAGUE", 2, 1 };
            yield return new object[] { "LEAGUE", 3, 5 };
            yield return new object[] { "LEAGUE", 7, 13 };
            yield return new object[] { "LEAGUE", 8, 13 };
            yield return new object[] { "KO", 1, 0 };
            yield return new object[] { "KO", 2, 1 };
            yield return new object[] { "KO", 3, 3 };
            yield return new object[] { "KO", 4, 3 };
            yield return new object[] { "KO", 8, 5 };
            yield return new object[] { "KO", 9, 7 };
            yield return new object[] { "KO", 16, 7 };
        }

        [TestCase("Goal", Constants.MatchEventType.Goal)]
        [TestCase("OwnGoal", Constants.MatchEventType.OwnGoal)]
        [TestCase("YellowCard", Constants.MatchEventType.YellowCard)]
        [TestCase("RedCard", Constants.MatchEventType.RedCard)]
        [TestCase("a", null)]
        [TestCase("Own Goal", null)]
        [TestCase("GOAL", null)]
        public void TestGetMatchEventTypeByName(string type, Constants.MatchEventType? expect)
        {
            Constants.MatchEventType? actual = MethodUtils.GetMatchEventTypeByName(type);
            Assert.AreEqual(expect, actual);
        }
        [TestCase("Sponsored", true)]
        [TestCase("Prize", true)]
        [TestCase("Fee", true)]
        [TestCase("SponSored", false)]
        [TestCase("PRIZE", false)]
        [TestCase("a", false)]
        public void TestCheckFeeType(string feeType, bool expect)
        {
            bool actual = MethodUtils.CheckFeeType(feeType);
            Assert.AreEqual(expect, actual);
        }

        [TestCaseSource(nameof(SourceProviderTestCountNumberOfRound))]
        public void TestCountNumberOfRound(string type, int numberOfParticipation, int expect)
        {
            int actual = MethodUtils.CountNumberOfRound(type, numberOfParticipation);
            Assert.AreEqual(expect, actual);
        }
        public static IEnumerable<object[]> SourceProviderTestCountNumberOfRound()
        {
            yield return new object[] { "LEAGUE", 1, 0 };
            yield return new object[] { "LEAGUE", 2, 1 };
            yield return new object[] { "LEAGUE", 3, 2 };
            yield return new object[] { "LEAGUE", 10, 9 };
            yield return new object[] { "KO", 1, 0 };
            yield return new object[] { "KO", 2, 1 };
            yield return new object[] { "KO", 3, 2 };
            yield return new object[] { "KO", 4, 2 };
            yield return new object[] { "KO", 8, 3 };
            yield return new object[] { "KO", 9, 4 };
            yield return new object[] { "a", 16, 0 };
            yield return new object[] { "a", 0, 0 };
        }
        [TestCaseSource(nameof(SourceProviderTestSumTotalLeagueFee))]
        public void TestSumTotalLeagueFee(List<LeagueFeeDTO> leagueFees, int expect)
        {
            decimal actual = MethodUtils.SumTotalLeagueFee(leagueFees);
            Assert.AreEqual(expect, actual);
        }
        public static IEnumerable<object[]> SourceProviderTestSumTotalLeagueFee()
        {
            LeagueFeeDTO sponsored1 = new LeagueFeeDTO { FeeType = Constants.FeeType.Sponsored.ToString(), Cost = 10 };
            LeagueFeeDTO sponsored2 = new LeagueFeeDTO { FeeType = Constants.FeeType.Sponsored.ToString(), Cost = 20 };
            LeagueFeeDTO sponsored3 = new LeagueFeeDTO { FeeType = Constants.FeeType.Sponsored.ToString(), Cost = 30 };
            LeagueFeeDTO prize1 = new LeagueFeeDTO { FeeType = Constants.FeeType.Prize.ToString(), Cost = 10 };
            LeagueFeeDTO prize2 = new LeagueFeeDTO { FeeType = Constants.FeeType.Prize.ToString(), Cost = 20 };
            LeagueFeeDTO prize3 = new LeagueFeeDTO { FeeType = Constants.FeeType.Prize.ToString(), Cost = 30 };
            LeagueFeeDTO fee1 = new LeagueFeeDTO { FeeType = Constants.FeeType.Fee.ToString(), Cost = 10 };
            LeagueFeeDTO fee2 = new LeagueFeeDTO { FeeType = Constants.FeeType.Fee.ToString(), Cost = 20 };
            LeagueFeeDTO fee3 = new LeagueFeeDTO { FeeType = Constants.FeeType.Fee.ToString(), Cost = 30 };

            List<LeagueFeeDTO> s1s2s3f1f2 = new List<LeagueFeeDTO> { sponsored1, sponsored2, sponsored3, fee1, fee2 };
            List<LeagueFeeDTO> s1s3p1p2p3f3 = new List<LeagueFeeDTO> { sponsored1, sponsored3, prize1, prize2, prize3, fee3 };
            List<LeagueFeeDTO> p1p2p3f1f2f3 = new List<LeagueFeeDTO> {prize1, prize2, prize3, fee1, fee2, fee3 };
            yield return new object[] { s1s2s3f1f2, -30 };
            yield return new object[] { s1s3p1p2p3f3, 50 };
            yield return new object[] { p1p2p3f1f2f3, 120 };
        }
        [TestCaseSource(nameof(SourceProviderTestGetTotalAmountByResult))]
        public void TestGetTotalAmountByResult(Club club, string type, int expect)
        {
            int actual = MethodUtils.GetTotalAmountByResult(club, type);
            Assert.AreEqual(expect, actual);
        }
        public static IEnumerable<object[]> SourceProviderTestGetTotalAmountByResult()
        {
            Club club1 = new Club { ClubClones = new List<ClubClone> { 
                new ClubClone
                {
                Won = 3, Draw = 3, Loss = 2
                }, 
                new ClubClone
                {
                Won = 1, Draw = 2, Loss = 4
                } 
            } };
            yield return new object[] { club1, "W", 4 };
            yield return new object[] { club1, "D", 5 };
            yield return new object[] { club1, "L", 6 };
        }
        [TestCase("New", true)]
        [TestCase("OnGoing", true)]
        [TestCase("Finished", true)]
        [TestCase("NEW", false)]
        [TestCase("On Going", false)]
        [TestCase("a", false)]
        public void TestCheckLeagueStatus(string type, bool expect)
        {
            bool actual = MethodUtils.CheckLeagueStatus(type);
            Assert.AreEqual(expect, actual);
        }
    }

}
