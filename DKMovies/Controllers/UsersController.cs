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

namespace DKMovies.Controllers
{
    public class UsersController : Controller
    {
        private readonly ApplicationDbContext _context;

        public UsersController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Users
        public async Task<IActionResult> Index()
        {
            return View(await _context.Users.ToListAsync());
        }

        // GET: Users/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.ID == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        // GET: Users/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Users/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Username,Email,FullName,Phone,BirthDate,Gender")] User user, string Password, IFormFile profileImage)
        {
            ModelState.Remove(nameof(DKMovies.Models.User.Tickets));
            ModelState.Remove(nameof(DKMovies.Models.User.Reviews));
            ModelState.Remove(nameof(DKMovies.Models.User.PasswordHash));

            if (string.IsNullOrWhiteSpace(Password))
                ModelState.AddModelError("PasswordHash", "Password is required.");

            if (await _context.Users.AnyAsync(u => u.Username == user.Username))
                ModelState.AddModelError("Username", "Username already exists.");

            if (await _context.Users.AnyAsync(u => u.Email == user.Email))
                ModelState.AddModelError("Email", "Email already exists.");

            if (ModelState.IsValid)
            {
                // Handle profile image upload
                if (profileImage != null && profileImage.Length > 0)
                {
                    var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "users");
                    Directory.CreateDirectory(uploadsFolder); // ensure folder exists

                    var fileExt = Path.GetExtension(profileImage.FileName);
                    var uniqueName = $"{Guid.NewGuid().ToString().Replace("-", "")}{fileExt}";
                    var filePath = Path.Combine(uploadsFolder, uniqueName);

                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await profileImage.CopyToAsync(fileStream);
                    }

                    user.ProfileImagePath = $"{uniqueName}";
                }

                user.PasswordHash = HashPassword(Password);
                user.CreatedAt = DateTime.UtcNow;

                _context.Add(user);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            return View(user);
        }


        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }

        // GET: Users/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            return View(user);
        }

        // POST: Users/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Username,Email,FullName,Phone,BirthDate,Gender")] User user, string Password, IFormFile profileImage)
        {
            if (id != user.ID)
                return NotFound();

            ModelState.Remove(nameof(DKMovies.Models.User.Tickets));
            ModelState.Remove(nameof(DKMovies.Models.User.Reviews));
            ModelState.Remove(nameof(DKMovies.Models.User.PasswordHash));
            ModelState.Remove("Password");

            if (await _context.Users.AnyAsync(u => u.Username == user.Username && u.ID != user.ID))
                ModelState.AddModelError("Username", "Username already exists.");

            if (await _context.Users.AnyAsync(u => u.Email == user.Email && u.ID != user.ID))
                ModelState.AddModelError("Email", "Email already exists.");

            if (ModelState.IsValid)
            {
                try
                {
                    var existingUser = await _context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.ID == id);
                    if (existingUser == null)
                        return NotFound();

                    user.CreatedAt = existingUser.CreatedAt;
                    user.PasswordHash = string.IsNullOrWhiteSpace(Password)
                        ? existingUser.PasswordHash
                        : HashPassword(Password);

                    // Handle profile image
                    if (profileImage != null && profileImage.Length > 0)
                    {
                        var fileName = $"{Guid.NewGuid()}{Path.GetExtension(profileImage.FileName)}";
                        var savePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images/users", fileName);

                        using (var stream = new FileStream(savePath, FileMode.Create))
                        {
                            await profileImage.CopyToAsync(stream);
                        }

                        user.ProfileImagePath = fileName;
                    }
                    else
                    {
                        user.ProfileImagePath = existingUser.ProfileImagePath;
                    }

                    _context.Update(user);
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserExists(user.ID))
                        return NotFound();
                    else
                        throw;
                }
            }

            return View(user);
        }


        // GET: Users/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.ID == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user != null)
            {
                _context.Users.Remove(user);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.ID == id);
        }
    }
}
