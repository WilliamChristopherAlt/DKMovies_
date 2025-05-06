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
            var applicationDbContext = _context.Concessions.Include(c => c.MeasurementUnit);
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: Concessions/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var concession = await _context.Concessions
                .Include(c => c.MeasurementUnit)
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
            ViewData["UnitID"] = new SelectList(_context.MeasurementUnits, "ID", "Name");
            return View();
        }

        // POST: Concessions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Name,Description,Price,StockLeft,UnitID,IsAvailable")] Concession concession, IFormFile imageFile)
        {
            ModelState.Remove(nameof(Concession.OrderItems));
            ModelState.Remove(nameof(Concession.MeasurementUnit));

            // Check if the Name already exists in the database
            if (await _context.Concessions.AnyAsync(c => c.Name == concession.Name))
            {
                ModelState.AddModelError("Name", "A concession with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                // Handle image upload
                if (imageFile != null && imageFile.Length > 0)
                {
                    var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "concessions");
                    Directory.CreateDirectory(uploadsFolder); // ensure folder exists

                    var fileExt = Path.GetExtension(imageFile.FileName);
                    var uniqueName = $"{Guid.NewGuid().ToString().Replace("-", "")}{fileExt}";
                    var filePath = Path.Combine(uploadsFolder, uniqueName);

                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await imageFile.CopyToAsync(fileStream);
                    }

                    concession.ImagePath = uniqueName;
                }

                _context.Add(concession);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            // Optional: Debug validation errors
            if (!ModelState.IsValid)
            {
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                {
                    Console.WriteLine(error.ErrorMessage);
                }
            }

            ViewData["UnitID"] = new SelectList(_context.MeasurementUnits, "ID", "Name", concession.UnitID);
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
            ViewData["UnitID"] = new SelectList(_context.MeasurementUnits, "ID", "Name", concession.UnitID);
            return View(concession);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Description,Price,StockLeft,UnitID,IsAvailable,ImagePath")] Concession concession, IFormFile imageFile)
        {
            if (id != concession.ID)
            {
                return NotFound();
            }

            ModelState.Remove(nameof(Concession.OrderItems));
            ModelState.Remove(nameof(Concession.MeasurementUnit));

            // Check if the Name already exists in the database (excluding current item)
            if (await _context.Concessions.AnyAsync(c => c.Name == concession.Name && c.ID != id))
            {
                ModelState.AddModelError("Name", "A concession with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Handle new image upload if provided
                    if (imageFile != null && imageFile.Length > 0)
                    {
                        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "concessions");
                        Directory.CreateDirectory(uploadsFolder); // ensure folder exists

                        var fileExt = Path.GetExtension(imageFile.FileName);
                        var uniqueName = $"{Guid.NewGuid().ToString().Replace("-", "")}{fileExt}";
                        var filePath = Path.Combine(uploadsFolder, uniqueName);

                        using (var fileStream = new FileStream(filePath, FileMode.Create))
                        {
                            await imageFile.CopyToAsync(fileStream);
                        }

                        // Optional: Delete the old image file
                        if (!string.IsNullOrEmpty(concession.ImagePath))
                        {
                            var oldFilePath = Path.Combine(uploadsFolder, concession.ImagePath);
                            if (System.IO.File.Exists(oldFilePath))
                            {
                                System.IO.File.Delete(oldFilePath);
                            }
                        }

                        concession.ImagePath = uniqueName;
                    }

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

            // Optional: Debug validation errors
            if (!ModelState.IsValid)
            {
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                {
                    Console.WriteLine(error.ErrorMessage);
                }
            }

            ViewData["UnitID"] = new SelectList(_context.MeasurementUnits, "ID", "Name", concession.UnitID);
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
                .Include(c => c.MeasurementUnit)
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
