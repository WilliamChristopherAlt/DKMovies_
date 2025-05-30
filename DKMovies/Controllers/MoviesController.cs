using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DKMovies.Models;
using System.IO;

namespace DKMovies.Controllers
{
    public class MoviesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public MoviesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Movies
        public IActionResult Index(string searchTitle, int? languageId, string sortBy, string sortOrder)
        {
            ViewData["CurrentFilter"] = searchTitle;
            ViewData["CurrentSortBy"] = sortBy;
            ViewData["CurrentSortOrder"] = sortOrder;

            var movies = _context.Movies
                .Include(m => m.Language)
                .Include(m => m.Country)
                .Include(m => m.Director)
                .Include(m => m.Rating)
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchTitle))
            {
                movies = movies.Where(m => m.Title.Contains(searchTitle));
            }

            if (languageId.HasValue)
            {
                movies = movies.Where(m => m.LanguageID == languageId.Value);
            }

            // Default to ascending if not specified
            bool ascending = sortOrder?.ToLower() != "desc";

            movies = (sortBy?.ToLower()) switch
            {
                "title" => ascending ? movies.OrderBy(m => m.Title) : movies.OrderByDescending(m => m.Title),
                "release" => ascending ? movies.OrderBy(m => m.ReleaseDate) : movies.OrderByDescending(m => m.ReleaseDate),
                "rating" => ascending ? movies.OrderBy(m => m.Rating.Value) : movies.OrderByDescending(m => m.Rating.Value),
                "duration" => ascending ? movies.OrderBy(m => m.DurationMinutes) : movies.OrderByDescending(m => m.DurationMinutes),
                _ => movies.OrderBy(m => m.Title)
            };

            ViewBag.Languages = _context.Languages.ToList();

            return View(movies.ToList());
        }

        // GET: Movies/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies
                .Include(m => m.Country)
                .Include(m => m.Director)
                .Include(m => m.Language)
                .Include(m => m.Rating)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (movie == null)
            {
                return NotFound();
            }

            return View(movie);
        }

        // GET: Movies/Create
        public IActionResult Create()
        {
            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name");
            ViewData["DirectorID"] = new SelectList(_context.Directors, "ID", "FullName");
            ViewData["LanguageID"] = new SelectList(_context.Languages, "ID", "Name");
            ViewData["RatingID"] = new SelectList(_context.Ratings, "ID", "Value");
            return View();
        }

        // POST: Movies/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(
            [Bind("ID,Title,Description,DurationMinutes,RatingID,ReleaseDate,LanguageID,CountryID,DirectorID")] Movie movie,
            IFormFile image)
        {
            // Remove navigation properties from model state
            ModelState.Remove(nameof(Movie.MovieGenres));
            ModelState.Remove(nameof(Movie.ShowTimes));
            ModelState.Remove(nameof(Movie.Reviews));
            ModelState.Remove(nameof(Movie.Country));
            ModelState.Remove(nameof(Movie.Director));
            ModelState.Remove(nameof(Movie.Language));
            ModelState.Remove(nameof(Movie.Rating));

            // Check for duplicate title
            if (await _context.Movies.AnyAsync(m => m.Title == movie.Title))
            {
                ModelState.AddModelError("Title", "A movie with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                // Handle image upload
                if (image != null && image.Length > 0)
                {
                    var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "movie_posters");
                    Directory.CreateDirectory(uploadsFolder); // Ensure folder exists

                    var fileExt = Path.GetExtension(image.FileName);
                    var uniqueName = $"{Guid.NewGuid():N}{fileExt}";
                    var filePath = Path.Combine(uploadsFolder, uniqueName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await image.CopyToAsync(stream);
                    }

                    movie.PosterImagePath = uniqueName;
                }

                _context.Add(movie);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            // Repopulate ViewBags for the form
            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name", movie.CountryID);
            ViewData["DirectorID"] = new SelectList(_context.Directors, "ID", "FullName", movie.DirectorID);
            ViewData["LanguageID"] = new SelectList(_context.Languages, "ID", "Name", movie.LanguageID);
            ViewData["RatingID"] = new SelectList(_context.Ratings, "ID", "Value", movie.RatingID);

            return View(movie);
        }

        // GET: Movies/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies.FindAsync(id);
            if (movie == null)
            {
                return NotFound();
            }
            var showtimes = await _context.ShowTimes
                .Where(s => s.MovieID == id)
                .Select(s => new {
                    s.StartTime,
                    TheaterName = s.Auditorium.Theater.Name,
                    AuditoriumName = s.Auditorium.Name
                })
                .ToListAsync();

            ViewBag.ShowTimes = showtimes;

            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name", movie.CountryID);
            ViewData["DirectorID"] = new SelectList(_context.Directors, "ID", "FullName", movie.DirectorID);
            ViewData["LanguageID"] = new SelectList(_context.Languages, "ID", "Name", movie.LanguageID);
            ViewData["RatingID"] = new SelectList(_context.Ratings, "ID", "Value", movie.RatingID);
            return View(movie);
        }

        // POST: Movies/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Title,Description,DurationMinutes,RatingID,ReleaseDate,LanguageID,CountryID,DirectorID,ImagePath")] Movie movie, IFormFile image)
        {
            if (id != movie.ID)
            {
                return NotFound();
            }

            ModelState.Remove(nameof(Movie.MovieGenres));
            ModelState.Remove(nameof(Movie.ShowTimes));
            ModelState.Remove(nameof(Movie.Reviews));

            ModelState.Remove(nameof(Movie.Country));
            ModelState.Remove(nameof(Movie.Director));
            ModelState.Remove(nameof(Movie.Language));
            ModelState.Remove(nameof(Movie.Rating));

            if (await _context.Movies.AnyAsync(m => m.Title == movie.Title && m.ID != movie.ID))
            {
                ModelState.AddModelError("Title", "A movie with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Handle image upload if provided
                    if (image != null && image.Length > 0)
                    {
                        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "movie_posters");
                        Directory.CreateDirectory(uploadsFolder); // Ensure the folder exists

                        var fileExt = Path.GetExtension(image.FileName);
                        var uniqueName = $"{Guid.NewGuid():N}{fileExt}";
                        var filePath = Path.Combine(uploadsFolder, uniqueName);

                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await image.CopyToAsync(stream);
                        }

                        movie.PosterImagePath = uniqueName;
                    }

                    _context.Update(movie);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MovieExists(movie.ID))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }

            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name", movie.CountryID);
            ViewData["DirectorID"] = new SelectList(_context.Directors, "ID", "FullName", movie.DirectorID);
            ViewData["LanguageID"] = new SelectList(_context.Languages, "ID", "Name", movie.LanguageID);
            ViewData["RatingID"] = new SelectList(_context.Ratings, "ID", "Value", movie.RatingID);

            return View(movie);
        }


        // GET: Movies/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies
                .Include(m => m.Country)
                .Include(m => m.Director)
                .Include(m => m.Language)
                .Include(m => m.Rating)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (movie == null)
            {
                return NotFound();
            }

            return View(movie);
        }

        // POST: Movies/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var movie = await _context.Movies.FindAsync(id);
            if (movie != null)
            {
                _context.Movies.Remove(movie);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool MovieExists(int id)
        {
            return _context.Movies.Any(e => e.ID == id);
        }
    }
}