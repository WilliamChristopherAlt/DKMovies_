using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using DKMovies.Models;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

public class WatchlistController : Controller
{
    private readonly ApplicationDbContext _context;

    public WatchlistController(ApplicationDbContext context)
    {
        _context = context;
    }

    // POST: Watchlist/Create
    [HttpPost]
    [ValidateAntiForgeryToken]
    [Authorize(Roles = "User")]
    public async Task<IActionResult> Create(int movieId)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));

        var exists = await _context.WatchList
            .AnyAsync(w => w.UserID == userId && w.MovieID == movieId);

        if (!exists)
        {
            var watchlistEntry = new WatchListSingular
            {
                UserID = userId,
                MovieID = movieId,
                AddedAt = DateTime.Now
            };

            _context.WatchList.Add(watchlistEntry);
            await _context.SaveChangesAsync();
        }

        return RedirectToAction("Details", "MoviesList", new { id = movieId });
    }

    // GET: Watchlist/MyWatchlist
    [Authorize(Roles = "User")]
    public async Task<IActionResult> MyWatchlist()
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));
        var list = await _context.WatchList
            .Include(w => w.Movie)
            .Where(w => w.UserID == userId)
            .ToListAsync();

        return View(list);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    [Authorize(Roles = "User")]
    public async Task<IActionResult> Remove(int movieId)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));

        var entry = await _context.WatchList
            .FirstOrDefaultAsync(w => w.UserID == userId && w.MovieID == movieId);

        if (entry != null)
        {
            _context.WatchList.Remove(entry);
            await _context.SaveChangesAsync();
        }

        return RedirectToAction("MyWatchlist");
    }

}
