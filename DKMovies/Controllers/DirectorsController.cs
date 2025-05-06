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
    public class DirectorsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public DirectorsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Directors
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.Directors.Include(d => d.Country);
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: Directors/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var director = await _context.Directors
                .Include(d => d.Country)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (director == null)
            {
                return NotFound();
            }

            return View(director);
        }

        // GET: Directors/Create
        public IActionResult Create()
        {
            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name");
            return View();
        }

        // POST: Directors/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,FullName,DateOfBirth,Biography,CountryID,ProfileImagePath")] Director director, IFormFile profileImage)
        {
            ModelState.Remove(nameof(Director.Movies));
            ModelState.Remove(nameof(Director.Country));

            if (await _context.Directors.AnyAsync(d => d.FullName == director.FullName))
            {
                ModelState.AddModelError("FullName", "A director with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                if (profileImage != null && profileImage.Length > 0)
                {
                    var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "directors");
                    Directory.CreateDirectory(uploadsFolder);

                    var fileExt = Path.GetExtension(profileImage.FileName);
                    var uniqueName = $"{Guid.NewGuid():N}{fileExt}";
                    var filePath = Path.Combine(uploadsFolder, uniqueName);

                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await profileImage.CopyToAsync(fileStream);
                    }

                    director.ProfileImagePath = uniqueName;
                }

                _context.Add(director);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name", director.CountryID);
            return View(director);
        }

        // GET: Directors/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var director = await _context.Directors.FindAsync(id);
            if (director == null)
            {
                return NotFound();
            }
            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name", director.CountryID);
            return View(director);
        }

        // POST: Directors/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,FullName,DateOfBirth,Biography,CountryID,ProfileImagePath")] Director director, IFormFile profileImage)
        {
            if (id != director.ID)
            {
                return NotFound();
            }

            ModelState.Remove(nameof(Director.Movies));
            ModelState.Remove(nameof(Director.Country));

            if (await _context.Directors.AnyAsync(d => d.FullName == director.FullName && d.ID != director.ID))
            {
                ModelState.AddModelError("FullName", "A director with this name already exists.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var existingDirector = await _context.Directors.AsNoTracking().FirstOrDefaultAsync(d => d.ID == id);
                    if (existingDirector == null)
                    {
                        return NotFound();
                    }

                    // Handle profile image
                    if (profileImage != null && profileImage.Length > 0)
                    {
                        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "directors");
                        Directory.CreateDirectory(uploadsFolder);

                        var fileExt = Path.GetExtension(profileImage.FileName);
                        var uniqueName = $"{Guid.NewGuid():N}{fileExt}";
                        var filePath = Path.Combine(uploadsFolder, uniqueName);

                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await profileImage.CopyToAsync(stream);
                        }

                        director.ProfileImagePath = uniqueName;
                    }
                    else
                    {
                        director.ProfileImagePath = existingDirector.ProfileImagePath;
                    }

                    _context.Update(director);
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!DirectorExists(director.ID))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
            }

            ViewData["CountryID"] = new SelectList(_context.Countries, "ID", "Name", director.CountryID);
            return View(director);
        }


        // GET: Directors/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var director = await _context.Directors
                .Include(d => d.Country)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (director == null)
            {
                return NotFound();
            }

            return View(director);
        }

        // POST: Directors/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var director = await _context.Directors.FindAsync(id);
            if (director != null)
            {
                _context.Directors.Remove(director);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool DirectorExists(int id)
        {
            return _context.Directors.Any(e => e.ID == id);
        }
    }
}
