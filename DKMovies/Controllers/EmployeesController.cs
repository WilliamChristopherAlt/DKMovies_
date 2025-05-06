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
    public class EmployeesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public EmployeesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Employees
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.Employees.Include(e => e.Role).Include(e => e.Theater);
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: Employees/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var employee = await _context.Employees
                .Include(e => e.Role)
                .Include(e => e.Theater)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (employee == null)
            {
                return NotFound();
            }

            return View(employee);
        }

        // GET: Employees/Create
        public IActionResult Create()
        {
            ViewData["RoleID"] = new SelectList(_context.EmployeeRoles, "ID", "Name");
            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location");
            return View();
        }

        // POST: Employees/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(
       [Bind("ID,FullName,Email,Phone,Gender,DateOfBirth,CitizenID,Address,HireDate,Salary,TheaterID,RoleID")] Employee employee,
       IFormFile profileImage)
        {
            ModelState.Remove(nameof(Employee.Admins));
            ModelState.Remove(nameof(Employee.Theater));
            ModelState.Remove(nameof(Employee.Role));

            // Uniqueness checks
            if (await _context.Employees.AnyAsync(e => e.Email == employee.Email))
                ModelState.AddModelError("Email", "Email already exists.");

            if (await _context.Employees.AnyAsync(e => e.Phone == employee.Phone))
                ModelState.AddModelError("Phone", "Phone number already exists.");

            if (await _context.Employees.AnyAsync(e => e.CitizenID == employee.CitizenID))
                ModelState.AddModelError("CitizenID", "Citizen ID already exists.");

            if (ModelState.IsValid)
            {
                // Handle profile image upload
                if (profileImage != null && profileImage.Length > 0)
                {
                    var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "employees");
                    Directory.CreateDirectory(uploadsFolder); // Ensure folder exists

                    var fileExt = Path.GetExtension(profileImage.FileName);
                    var uniqueName = $"{Guid.NewGuid():N}{fileExt}";
                    var filePath = Path.Combine(uploadsFolder, uniqueName);

                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await profileImage.CopyToAsync(fileStream);
                    }

                    employee.ProfileImagePath = uniqueName;
                }

                _context.Add(employee);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            if (!ModelState.IsValid)
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                    Console.WriteLine(error.ErrorMessage);


            ViewData["RoleID"] = new SelectList(_context.EmployeeRoles, "ID", "Name", employee.RoleID);
            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location", employee.TheaterID);
            return View(employee);
        }


        // GET: Employees/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var employee = await _context.Employees.FindAsync(id);
            if (employee == null)
            {
                return NotFound();
            }
            ViewData["RoleID"] = new SelectList(_context.EmployeeRoles, "ID", "Name", employee.RoleID);
            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location", employee.TheaterID);
            return View(employee);
        }

        // POST: Employees/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id,
    [Bind("ID,FullName,Email,Phone,Gender,DateOfBirth,CitizenID,Address,HireDate,Salary,TheaterID,RoleID")] Employee employee,
    IFormFile profileImage)
        {
            if (id != employee.ID)
                return NotFound();

            ModelState.Remove(nameof(Employee.Admins));
            ModelState.Remove(nameof(Employee.Theater));
            ModelState.Remove(nameof(Employee.Role));

            // Uniqueness checks (excluding self)
            if (await _context.Employees.AnyAsync(e => e.Email == employee.Email && e.ID != id))
                ModelState.AddModelError("Email", "Email already exists.");

            if (await _context.Employees.AnyAsync(e => e.Phone == employee.Phone && e.ID != id))
                ModelState.AddModelError("Phone", "Phone number already exists.");

            if (await _context.Employees.AnyAsync(e => e.CitizenID == employee.CitizenID && e.ID != id))
                ModelState.AddModelError("CitizenID", "Citizen ID already exists.");

            if (ModelState.IsValid)
            {
                try
                {
                    // Get original employee from DB
                    var existingEmployee = await _context.Employees.AsNoTracking()
                        .FirstOrDefaultAsync(e => e.ID == id);

                    if (existingEmployee == null)
                        return NotFound();

                    // Handle profile image upload
                    if (profileImage != null && profileImage.Length > 0)
                    {
                        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "employees");
                        Directory.CreateDirectory(uploadsFolder);

                        var fileExt = Path.GetExtension(profileImage.FileName);
                        var uniqueName = $"{Guid.NewGuid():N}{fileExt}";
                        var filePath = Path.Combine(uploadsFolder, uniqueName);

                        using (var fileStream = new FileStream(filePath, FileMode.Create))
                        {
                            await profileImage.CopyToAsync(fileStream);
                        }

                        employee.ProfileImagePath = uniqueName;
                    }
                    else
                    {
                        // Keep the existing image
                        employee.ProfileImagePath = existingEmployee.ProfileImagePath;
                    }

                    _context.Update(employee);
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EmployeeExists(employee.ID))
                        return NotFound();
                    else
                        throw;
                }
            }

            foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                Console.WriteLine(error.ErrorMessage);

            ViewData["RoleID"] = new SelectList(_context.EmployeeRoles, "ID", "Name", employee.RoleID);
            ViewData["TheaterID"] = new SelectList(_context.Theaters, "ID", "Location", employee.TheaterID);
            return View(employee);
        }



        // GET: Employees/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var employee = await _context.Employees
                .Include(e => e.Role)
                .Include(e => e.Theater)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (employee == null)
            {
                return NotFound();
            }

            return View(employee);
        }

        // POST: Employees/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var employee = await _context.Employees.FindAsync(id);
            if (employee != null)
            {
                _context.Employees.Remove(employee);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool EmployeeExists(int id)
        {
            return _context.Employees.Any(e => e.ID == id);
        }
    }
}
