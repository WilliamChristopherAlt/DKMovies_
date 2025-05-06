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
    public class MeasurementUnitsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public MeasurementUnitsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: MeasurementUnits
        public async Task<IActionResult> Index()
        {
            return View(await _context.MeasurementUnits.ToListAsync());
        }

        // GET: MeasurementUnits/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var measurementUnit = await _context.MeasurementUnits
                .FirstOrDefaultAsync(m => m.ID == id);
            if (measurementUnit == null)
            {
                return NotFound();
            }

            return View(measurementUnit);
        }

        // GET: MeasurementUnits/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: MeasurementUnits/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Name,IsContinuous")] MeasurementUnit measurementUnit)
        {
            ModelState.Remove(nameof(MeasurementUnit.Concessions));

            // Check if the Name already exists in the database
            if (await _context.MeasurementUnits.AnyAsync(mu => mu.Name == measurementUnit.Name))
            {
                ModelState.AddModelError("Name", "A measurement unit with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                _context.Add(measurementUnit);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(measurementUnit);
        }

        // GET: MeasurementUnits/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var measurementUnit = await _context.MeasurementUnits.FindAsync(id);
            if (measurementUnit == null)
            {
                return NotFound();
            }
            return View(measurementUnit);
        }

        // POST: MeasurementUnits/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,IsContinuous")] MeasurementUnit measurementUnit)
        {
            if (id != measurementUnit.ID)
            {
                return NotFound();
            }

            ModelState.Remove(nameof(MeasurementUnit.Concessions));

            // Check if the Name already exists in the database
            if (await _context.MeasurementUnits.AnyAsync(mu => mu.Name == measurementUnit.Name && mu.ID != id))
            {
                ModelState.AddModelError("Name", "A measurement unit with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(measurementUnit);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MeasurementUnitExists(measurementUnit.ID))
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
            return View(measurementUnit);
        }

        // GET: MeasurementUnits/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var measurementUnit = await _context.MeasurementUnits
                .FirstOrDefaultAsync(m => m.ID == id);
            if (measurementUnit == null)
            {
                return NotFound();
            }

            return View(measurementUnit);
        }

        // POST: MeasurementUnits/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var measurementUnit = await _context.MeasurementUnits.FindAsync(id);
            if (measurementUnit != null)
            {
                _context.MeasurementUnits.Remove(measurementUnit);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool MeasurementUnitExists(int id)
        {
            return _context.MeasurementUnits.Any(e => e.ID == id);
        }
    }
}
