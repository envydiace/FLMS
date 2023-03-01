using FLMS_BackEnd.Services;
using FLMS_BackEnd.Utils;
using NUnit.Framework;

namespace FLMS_BackEnd.Test
{
    [TestFixture]
    public class TestMethodUtils
    {
        [TestCase("LEAGUE_MANAGER",true)]
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
    }
    
}
