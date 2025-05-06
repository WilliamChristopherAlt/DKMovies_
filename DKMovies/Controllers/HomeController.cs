using Microsoft.AspNetCore.Mvc;

namespace DKMovies.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
