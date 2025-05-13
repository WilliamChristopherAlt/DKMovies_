using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using DKMovies.Models;
using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Security.Claims;

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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string username, string password)
        {
            var hashedPassword = HashPassword(password);

            // Check for normal user
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == username);
            if (user != null && user.PasswordHash == hashedPassword)
            {
                var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, user.Username),
            new Claim(ClaimTypes.NameIdentifier, user.ID.ToString()),
            new Claim(ClaimTypes.Role, "User")
        };

                var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                var principal = new ClaimsPrincipal(identity);

                await HttpContext.SignInAsync("MyCookieAuth", principal,
                    new AuthenticationProperties
                    {
                        IsPersistent = true, // persist after browser/app restart
                        ExpiresUtc = DateTime.UtcNow.AddDays(30)
                    });

                return RedirectToAction("Index", "Home");
            }

            // Check for admin
            var admin = await _context.Admins.FirstOrDefaultAsync(a => a.Username == username);
            if (admin != null && admin.PasswordHash == hashedPassword)
            {
                var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, admin.Username),
            new Claim(ClaimTypes.NameIdentifier, user.ID.ToString()),
            new Claim(ClaimTypes.Role, "Admin")
        };

                var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                var principal = new ClaimsPrincipal(identity);

                await HttpContext.SignInAsync("MyCookieAuth", principal,
                    new AuthenticationProperties
                    {
                        IsPersistent = true,
                        ExpiresUtc = DateTime.UtcNow.AddDays(30)
                    });

                return RedirectToAction("AdminDashboard", "Admin");
            }

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


        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync("MyCookieAuth");
            return RedirectToAction("Login", "Account");
        }

    }
}
