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
    public class ConcessionsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ConcessionsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Concessions
        public async Task<IActionResult> Index()
        {
            return View(await _context.Concessions.ToListAsync());
        }

        // GET: Concessions/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var concession = await _context.Concessions
                .FirstOrDefaultAsync(m => m.ID == id);
            if (concession == null)
            {
                return NotFound();
            }

            return View(concession);
        }

        // GET: Concessions/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Concessions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Name,Description,ImagePath")] Concession concession)
        {
            if (ModelState.IsValid)
            {
                _context.Add(concession);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(concession);
        }

        // GET: Concessions/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var concession = await _context.Concessions.FindAsync(id);
            if (concession == null)
            {
                return NotFound();
            }
            return View(concession);
        }

        // POST: Concessions/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Description,ImagePath")] Concession concession)
        {
            if (id != concession.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(concession);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ConcessionExists(concession.ID))
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
            return View(concession);
        }

        // GET: Concessions/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var concession = await _context.Concessions
                .FirstOrDefaultAsync(m => m.ID == id);
            if (concession == null)
            {
                return NotFound();
            }

            return View(concession);
        }

        // POST: Concessions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var concession = await _context.Concessions.FindAsync(id);
            if (concession != null)
            {
                _context.Concessions.Remove(concession);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ConcessionExists(int id)
        {
            return _context.Concessions.Any(e => e.ID == id);
        }
    }
}
