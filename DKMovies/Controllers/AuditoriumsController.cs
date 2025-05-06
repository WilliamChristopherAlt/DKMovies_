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
    public class AuditoriumsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AuditoriumsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Auditoriums
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.Auditoriums.Include(a => a.Theater);
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: Auditoriums/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var auditorium = await _context.Auditoriums
                .Include(a => a.Theater)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (auditorium == null)
            {
                return NotFound();
            }

            return View(auditorium);
        }

        // GET: Auditoriums/Create
        public IActionResult Create()
        {
            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location");
            return View();
        }

        // POST: Auditoriums/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,TheaterID,Name,Capacity")] Auditorium auditorium)
        {
            ModelState.Remove(nameof(Auditorium.Seats));
            ModelState.Remove(nameof(Auditorium.ShowTimes));
            ModelState.Remove(nameof(Auditorium.Theater));

            if (ModelState.IsValid)
            {
                _context.Add(auditorium);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            if (!ModelState.IsValid)
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                    Console.WriteLine(error.ErrorMessage);

            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location", auditorium.TheaterID);
            return View(auditorium);
        }

        // GET: Auditoriums/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var auditorium = await _context.Auditoriums.FindAsync(id);
            if (auditorium == null)
            {
                return NotFound();
            }
            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location", auditorium.TheaterID);
            return View(auditorium);
        }

        // POST: Auditoriums/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,TheaterID,Name,Capacity")] Auditorium auditorium)
        {
            if (id != auditorium.ID)
            {
                return NotFound();
            }

            ModelState.Remove(nameof(Auditorium.Seats));
            ModelState.Remove(nameof(Auditorium.ShowTimes));
            ModelState.Remove(nameof(Auditorium.Theater));

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(auditorium);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AuditoriumExists(auditorium.ID))
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

            if (!ModelState.IsValid)
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                    Console.WriteLine(error.ErrorMessage);

            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location", auditorium.TheaterID);
            return View(auditorium);
        }

        // GET: Auditoriums/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var auditorium = await _context.Auditoriums
                .Include(a => a.Theater)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (auditorium == null)
            {
                return NotFound();
            }

            return View(auditorium);
        }

        // POST: Auditoriums/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var auditorium = await _context.Auditoriums.FindAsync(id);
            if (auditorium != null)
            {
                _context.Auditoriums.Remove(auditorium);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AuditoriumExists(int id)
        {
            return _context.Auditoriums.Any(e => e.ID == id);
        }
    }
}
