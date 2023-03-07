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
    }

}
