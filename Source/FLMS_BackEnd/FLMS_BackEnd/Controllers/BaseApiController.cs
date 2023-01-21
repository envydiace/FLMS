using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace FLMS_BackEnd.Controllers
{
    public class BaseApiController : Controller
    {
        protected int UserID => int.Parse(FindClaim(ClaimTypes.NameIdentifier));
        private string FindClaim(string claimName)
        {
            var claimsIdentity = HttpContext.User.Identity as ClaimsIdentity;
            var claim = claimsIdentity.FindFirst(claimName);

            if (claim == null)
            {
                return null;
            }
            return claim.Value;
        }
    }
}
