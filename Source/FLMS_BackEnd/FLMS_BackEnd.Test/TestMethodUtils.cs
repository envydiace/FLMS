using FLMS_BackEnd.Models;
using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using NUnit.Framework;

namespace FLMS_BackEnd.Test
{
    [TestFixture]
    public class TestMethodUtils
    {
        [TestCase("LEAGUE_MANAGER", true)]
        [TestCase("LEAGUE MANAGER", false)]
        public void TestCheckRole(string role, bool expect)
        {
            bool actual = MethodUtils.CheckUserRole(role);
            Assert.AreEqual(expect, actual);
        }

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
            yield return new object[] { 3, "Quater Final" };
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
    }

}
