using FLMS_BackEnd.Utils;
using NUnit.Framework;

namespace FLMS_BackEnd.Test
{
    [TestFixture]
    public class TestDemo
    {
        //Test case
        [TestCase("LEAGUE_MANAGER", true)]
        [TestCase("LEAGUE MANAGER", false)]
        public void TestCheckRole(string role, bool expect)
        {
            bool actual = MethodUtils.CheckUserRole(role);
            Assert.AreEqual(expect, actual);
        }

        //Test Maxtime
        [Test]
        [MaxTime(1000)]
        public async Task WhenTakesMoreTime_ThenItFails()
        {
            //await Task.Delay(100);
            // Assert
            Assert.IsTrue(true);
        }

        [TestCaseSource(nameof(SourceProviderTestGetLeagueTypeByName))]
        public void TestGetLeagueTypeByName(string type, Constants.LeagueType? expect)
        {
            Constants.LeagueType? actual = MethodUtils.GetLeagueTypeByName(type);
            Assert.AreEqual(expect, actual);
        }
        public static IEnumerable<object[]> SourceProviderTestGetLeagueTypeByName()
        {
            yield return new object[] { "KO", Constants.LeagueType.KO };
            yield return new object[] { "ko", null };
            yield return new object[] { "LEAGUE", Constants.LeagueType.LEAGUE };
        }
    }
}
