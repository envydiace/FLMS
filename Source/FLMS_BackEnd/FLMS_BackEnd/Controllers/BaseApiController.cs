using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace FLMS_BackEnd.Controllers
{
    public class BaseApiController : Controller
    {
        protected int UserID
        {
            get
            {
                var claim = FindClaim(ClaimTypes.NameIdentifier);
                return claim != null ? int.Parse(claim) : 0;
            }
        }
        private string? FindClaim(string claimName)
        {
            var claimsIdentity = HttpContext.User.Identity as ClaimsIdentity;
            if (claimsIdentity == null)
            {
                return null;
            }
            var claim = claimsIdentity.FindFirst(claimName);
            if (claim == null)
            {
                return null;
            }
            return claim.Value;
        }
    }
}
