using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DKMovies.Models;
using System.Linq;
using System.Threading.Tasks;
 
namespace DKMovies.Controllers
{
    public class DirectorsListController : Controller
    {
        private readonly ApplicationDbContext _context;

        public DirectorsListController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: DirectorsList/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var director = await _context.Directors
                .Include(d => d.Country)
                .Include(d => d.Movies)
                .FirstOrDefaultAsync(d => d.ID == id);

            if (director == null)
            {
                TempData["Error"] = "Director not found.";
                return RedirectToAction("Index", "MoviesList");
            }

            return View(director);
        }
    }
}
