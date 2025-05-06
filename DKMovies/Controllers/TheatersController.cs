using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DKMovies.Models;
using System.Diagnostics.Metrics;

namespace DKMovies.Controllers
{
    public class TheatersController : Controller
    {
        private readonly ApplicationDbContext _context;

        public TheatersController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Theaters
        public async Task<IActionResult> Index()
        {
            return View(await _context.Theaters.ToListAsync());
        }

        // GET: Theaters/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var theater = await _context.Theaters
                .FirstOrDefaultAsync(m => m.ID == id);
            if (theater == null)
            {
                return NotFound();
            }

            return View(theater);
        }

        // GET: Theaters/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Theaters/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Name,Location,Phone")] Theater theater)
        {
            ModelState.Remove(nameof(Theater.Auditoriums));
            ModelState.Remove(nameof(Theater.Employees));

            if (await _context.Theaters.AnyAsync(t => t.Name == theater.Name))
            {
                ModelState.AddModelError("Name", "A theater with this name already exists.");
            }
            if (await _context.Theaters.AnyAsync(t => t.Location == theater.Location))
            {
                ModelState.AddModelError("Location", "A theater with this location already exists.");
            }

            if (ModelState.IsValid)
            {
                _context.Add(theater);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(theater);
        }

        // GET: Theaters/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var theater = await _context.Theaters.FindAsync(id);
            if (theater == null)
            {
                return NotFound();
            }
            return View(theater);
        }

        // POST: Theaters/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Location,Phone")] Theater theater)
        {
            if (id != theater.ID)
            {
                return NotFound();
            }

            ModelState.Remove(nameof(Theater.Auditoriums));
            ModelState.Remove(nameof(Theater.Employees));

            if (await _context.Theaters.AnyAsync(t => t.Name == theater.Name && t.ID != theater.ID))
            {
                ModelState.AddModelError("Name", "A theater with this name already exists.");
            }
            if (await _context.Theaters.AnyAsync(t => t.Location == theater.Location && t.ID != theater.ID))
            {
                ModelState.AddModelError("Location", "A theater with this location already exists.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(theater);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TheaterExists(theater.ID))
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
            return View(theater);
        }

        // GET: Theaters/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var theater = await _context.Theaters
                .FirstOrDefaultAsync(m => m.ID == id);
            if (theater == null)
            {
                return NotFound();
            }

            return View(theater);
        }

        // POST: Theaters/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var theater = await _context.Theaters.FindAsync(id);
            if (theater != null)
            {
                _context.Theaters.Remove(theater);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool TheaterExists(int id)
        {
            return _context.Theaters.Any(e => e.ID == id);
        }
    }
}
