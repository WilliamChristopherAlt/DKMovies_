using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using DKMovies.Models;
using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace DKMovies.Controllers
{
    public class AccountController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AccountController(ApplicationDbContext context)
        {
            _context = context;
        }

        // Helper method to hash password
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }

        // Login view for normal users (GET)
        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        // POST: Login (Handle user login or admin login)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string username, string password)
        {
            var hashedPassword = HashPassword(password);

            // First, try to find a user in the Users table
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == username);

            if (user != null && user.PasswordHash == hashedPassword)
            {
                HttpContext.Session.SetString("Username", user.Username);
                HttpContext.Session.SetString("UserID", user.ID.ToString());
                HttpContext.Session.SetString("Role", "User");
                return RedirectToAction("Index", "Home");
            }

            // If not found in Users, try to find an admin
            var admin = await _context.Admins.FirstOrDefaultAsync(a => a.Username == username);

            if (admin != null && admin.PasswordHash == hashedPassword)
            {
                HttpContext.Session.SetString("Username", admin.Username);
                HttpContext.Session.SetString("UserID", admin.ID.ToString());
                HttpContext.Session.SetString("Role", "Admin");
                return RedirectToAction("AdminDashboard", "Admins");
            }
            Console.WriteLine("Cant log in");

            // If neither match
            ModelState.AddModelError(string.Empty, "Invalid username or password.");
            return View();
        }


        // Sign Up view for normal users (GET)
        [HttpGet]
        public IActionResult SignUp()
        {
            return View();
        }

        // POST: Sign Up (Handle user registration)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SignUp(string username, string email, string password)
        {
            // Check if username already exists
            if (await _context.Users.AnyAsync(u => u.Username == username))
            {
                ModelState.AddModelError("Username", "Username already taken.");
                return View();
            }

            // Check if email already exists
            if (await _context.Users.AnyAsync(u => u.Email == email))
            {
                ModelState.AddModelError("Email", "Email already in use.");
                return View();
            }

            var user = new User
            {
                Username = username,
                Email = email,
                PasswordHash = HashPassword(password),
                CreatedAt = DateTime.Now // Set CreatedAt to the current time
            };

            if (!ModelState.IsValid)
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                    Console.WriteLine(error.ErrorMessage);

            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return RedirectToAction("Login");
        }


        // Login view for admins (GET)
        [HttpGet]
        public IActionResult AdminLogin()
        {
            return View();
        }

        // POST: Admin Login (Handle admin login)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AdminLogin(string username, string password)
        {
            var admin = await _context.Admins.FirstOrDefaultAsync(a => a.Username == username);
            if (admin != null && admin.PasswordHash == HashPassword(password))
            {
                HttpContext.Session.SetString("Username", admin.Username);
                HttpContext.Session.SetString("UserID", admin.ID.ToString());
                HttpContext.Session.SetString("Role", "Admin"); // Assign the "Admin" role in the session
                return RedirectToAction("AdminDashboard", "Admin");
            }
            ModelState.AddModelError(string.Empty, "Invalid admin username or password.");
            return View();
        }

        // GET: Logout (Clears session and redirects to home or login)
        [HttpGet]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear(); // Remove all session data
            return RedirectToAction("Login", "Account"); 
        }
    }
}
