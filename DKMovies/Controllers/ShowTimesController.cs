using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DKMovies.Models;

namespace DKMovies.Controllers
{
    public class ShowTimesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ShowTimesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: ShowTimes
        public async Task<IActionResult> Index()
        {
            var showTimes = await _context.ShowTimes
                .Include(s => s.Auditorium)
                .Include(s => s.Movie)
                .Include(s => s.SubtitleLanguage)
                .ToListAsync();
            Console.WriteLine($"Retrieved {showTimes.Count} ShowTime records");
            return View(showTimes);
        }

        // GET: ShowTimes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var showTime = await _context.ShowTimes
                .Include(s => s.Auditorium)
                .Include(s => s.Movie)
                .Include(s => s.SubtitleLanguage)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (showTime == null)
            {
                return NotFound();
            }

            return View(showTime);
        }

        // GET: ShowTimes/Create
        public IActionResult Create()
        {
            ViewData["AuditoriumID"] = new SelectList(_context.Auditoriums, "ID", "Name");
            ViewData["MovieID"] = new SelectList(_context.Movies, "ID", "Title");
            ViewData["ID"] = new SelectList(_context.Languages, "ID", "Name");
            ViewData["LanguageID"] = new SelectList(_context.Languages, "ID", "Name");
            return View();
        }

        // POST: ShowTimes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,MovieID,AuditoriumID,StartTime,DurationMinutes,SubtitleLanguageID,Is3D")] ShowTime showTime, int? movieId)
        {
            if (ModelState.IsValid)
            {
                _context.Add(showTime);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            var showtime = new ShowTime();
            if (movieId.HasValue)
            {
                showtime.MovieID = movieId.Value;
            }
            ViewData["AuditoriumID"] = new SelectList(_context.Auditoriums, "ID", "Name", showTime.AuditoriumID);
            ViewData["MovieID"] = new SelectList(_context.Movies, "ID", "Title", showTime.MovieID);
            ViewData["ID"] = new SelectList(_context.Languages, "ID", "Name", showTime.ID);
            ViewData["LanguageID"] = new SelectList(_context.Languages, "ID", "Name");

            return View(showTime);
        }

        // GET: ShowTimes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var showTime = await _context.ShowTimes.FindAsync(id);
            if (showTime == null)
            {
                return NotFound();
            }
            ViewData["AuditoriumID"] = new SelectList(_context.Auditoriums, "ID", "Name", showTime.AuditoriumID);
            ViewData["MovieID"] = new SelectList(_context.Movies, "ID", "Title", showTime.MovieID);
            ViewData["ID"] = new SelectList(_context.Languages, "ID", "Name", showTime.ID);
            return View(showTime);
        }

        // POST: ShowTimes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,MovieID,AuditoriumID,StartTime,DurationMinutes,SubtitleLanguageID,Is3D")] ShowTime showTime)
        {
            if (id != showTime.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(showTime);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ShowTimeExists(showTime.ID))
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
            ViewData["AuditoriumID"] = new SelectList(_context.Auditoriums, "ID", "Name", showTime.AuditoriumID);
            ViewData["MovieID"] = new SelectList(_context.Movies, "ID", "Title", showTime.MovieID);
            ViewData["ID"] = new SelectList(_context.Languages, "ID", "Name", showTime.ID);
            return View(showTime);
        }

        // GET: ShowTimes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var showTime = await _context.ShowTimes
                .Include(s => s.Auditorium)
                .Include(s => s.Movie)
                .Include(s => s.SubtitleLanguage)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (showTime == null)
            {
                return NotFound();
            }

            return View(showTime);
        }

        // POST: ShowTimes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var showTime = await _context.ShowTimes.FindAsync(id);
            if (showTime != null)
            {
                _context.ShowTimes.Remove(showTime);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ShowTimeExists(int id)
        {
            return _context.ShowTimes.Any(e => e.ID == id);
        }
    }
}
