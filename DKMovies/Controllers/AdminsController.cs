using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DKMovies.Models;
using System.Text;
using System.Security.Cryptography;
using Microsoft.AspNetCore.Identity;

namespace DKMovies.Controllers
{
    public class AdminsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AdminsController(ApplicationDbContext context)
        {
            _context = context;
        }
        public IActionResult AdminDashboard()
        {
            var orderData = _context.Orders
                .GroupBy(o => o.OrderTime.Date)
                .Select(g => new
                {
                    Date = g.Key,
                    TotalAmount = g.Sum(o => o.TotalAmount)
                })
                .OrderBy(g => g.Date)
                .ToList();

            var ticketData = _context.Tickets
                .GroupBy(t => t.PurchaseTime.Date)
                .Select(g => new
                {
                    Date = g.Key,
                    TotalPrice = g.Sum(t => t.TotalPrice)
                })
                .OrderBy(g => g.Date)
                .ToList();

            // Combine all unique dates from both datasets
            var dates = orderData.Select(o => o.Date)
                .Union(ticketData.Select(t => t.Date))
                .Distinct()
                .OrderBy(d => d)
                .Select(d => d.ToString("yyyy-MM-dd"))
                .ToList();

            // Map totals, ensuring 0 for missing dates
            var orderTotals = dates.Select(d =>
                orderData.FirstOrDefault(o => o.Date.ToString("yyyy-MM-dd") == d)?.TotalAmount ?? 0)
                .ToList();

            var ticketTotals = dates.Select(d =>
                ticketData.FirstOrDefault(t => t.Date.ToString("yyyy-MM-dd") == d)?.TotalPrice ?? 0)
                .ToList();

            // Calculate total income (orders + tickets)
            var totalIncome = orderTotals.Zip(ticketTotals, (o, t) => o + t).ToList();

            ViewBag.TotalUsers = _context.Users.Count();
            ViewBag.TotalEmployees = _context.Employees.Count();
            ViewData["Dates"] = dates;
            ViewData["OrderTotals"] = orderTotals;
            ViewData["TicketTotals"] = ticketTotals;
            ViewData["TotalIncome"] = totalIncome;
            return View();
        }
        // GET: Admins
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.Admins.Include(a => a.Employee);
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: Admins/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var admin = await _context.Admins
                .Include(a => a.Employee)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (admin == null)
            {
                return NotFound();
            }

            return View(admin);
        }

        // GET: Admins/Create
        public IActionResult Create()
        {
            ViewData["EmployeeID"] = new SelectList(_context.Employees, "ID", "Email");
            return View();
        }

        // POST: Admins/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("EmployeeID,Username")] Admin admin, string Password)
        {
            ModelState.Remove(nameof(Admin.Employee));
            ModelState.Remove(nameof(Admin.CreatedAt));
            ModelState.Remove(nameof(Admin.PasswordHash));

            // Check if Username already exists
            if (await _context.Admins.AnyAsync(a => a.Username == admin.Username))
            {
                ModelState.AddModelError("Username", "Username already exists.");
            }

            // Check if EmployeeID is already assigned
            if (await _context.Admins.AnyAsync(a => a.EmployeeID == admin.EmployeeID))
            {
                ModelState.AddModelError("EmployeeID", "This employee is already assigned to an admin account.");
            }

            // Validate password
            if (string.IsNullOrWhiteSpace(Password))
            {
                ModelState.AddModelError("PasswordHash", "Password is required.");
            }

            if (ModelState.IsValid)
            {
                admin.PasswordHash = HashPassword(Password);
                admin.CreatedAt = DateTime.Now;

                _context.Add(admin);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            ViewData["EmployeeID"] = new SelectList(_context.Employees, "ID", "Email", admin.EmployeeID);
            return View(admin);
        }

        // GET: Admins/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var admin = await _context.Admins.FindAsync(id);
            if (admin == null)
            {
                return NotFound();
            }
            ViewData["EmployeeID"] = new SelectList(_context.Employees, "ID", "Email", admin.EmployeeID);
            return View(admin);
        }

        // POST: Admins/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,EmployeeID,Username")] Admin admin, string Password)
        {
            ModelState.Remove(nameof(Admin.Employee));
            ModelState.Remove(nameof(Admin.CreatedAt));
            ModelState.Remove(nameof(Admin.PasswordHash));
            ModelState.Remove("Password");

            if (id != admin.ID)
            {
                return NotFound();
            }

            // Fetch the original admin record from DB
            var existingAdmin = await _context.Admins.AsNoTracking().FirstOrDefaultAsync(a => a.ID == id);
            if (existingAdmin == null)
            {
                return NotFound();
            }

            // Check if Username is already taken by another admin
            if (await _context.Admins.AnyAsync(a => a.Username == admin.Username && a.ID != id))
            {
                ModelState.AddModelError("Username", "Username already exists.");
            }

            // Check if EmployeeID is already assigned to a different admin
            if (await _context.Admins.AnyAsync(a => a.EmployeeID == admin.EmployeeID && a.ID != id))
            {
                ModelState.AddModelError("EmployeeID", "This employee is already assigned to another admin account.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Preserve CreatedAt and existing PasswordHash if password is not changed
                    admin.CreatedAt = existingAdmin.CreatedAt;
                    admin.PasswordHash = string.IsNullOrWhiteSpace(Password)
                        ? existingAdmin.PasswordHash
                        : HashPassword(Password);

                    Console.WriteLine(HashPassword(Password));

                    _context.Update(admin);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AdminExists(admin.ID))
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

            ViewData["EmployeeID"] = new SelectList(_context.Employees, "ID", "Email", admin.EmployeeID);
            return View(admin);
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }

        // GET: Admins/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var admin = await _context.Admins
                .Include(a => a.Employee)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (admin == null)
            {
                return NotFound();
            }

            return View(admin);
        }

        // POST: Admins/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var admin = await _context.Admins.FindAsync(id);
            if (admin != null)
            {
                _context.Admins.Remove(admin);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AdminExists(int id)
        {
            return _context.Admins.Any(e => e.ID == id);
        }
    }
}
