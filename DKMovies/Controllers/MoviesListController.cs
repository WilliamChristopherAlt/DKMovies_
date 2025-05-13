// MoviesListController.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DKMovies.Models;
using System.Linq;
using System.Threading.Tasks;
using System.Drawing.Printing;

namespace DKMovies.Controllers
{
    public class MoviesListController : Controller
    {
        private readonly ApplicationDbContext _context;
        private const int PageSize = 30;

        public MoviesListController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: MoviesList
        public async Task<IActionResult> Index(int page = 1)
        {
            var totalMovies = await _context.Movies.CountAsync();
            var totalPages = (int)Math.Ceiling(totalMovies / (double)PageSize);

            var movies = await _context.Movies
                .Include(m => m.Country)
                .Include(m => m.Language)
                .Include(m => m.Rating)
                .Include(m => m.Director)
                .Include(m => m.MovieGenres)
                    .ThenInclude(mg => mg.Genre)
                .OrderBy(m => m.Title)
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            // Get all review averages for the visible movies
            var movieIds = movies.Select(m => m.ID).ToList();

            var avgRatings = await _context.Reviews
                .Where(r => movieIds.Contains(r.MovieID) && r.IsApproved)
                .GroupBy(r => r.MovieID)
                .Select(g => new
                {
                    MovieID = g.Key,
                    AvgRating = g.Average(r => r.Rating)
                })
                .ToListAsync();

            // Add avg rating to each movie via ViewData dictionary
            var avgRatingDict = avgRatings.ToDictionary(x => x.MovieID, x => x.AvgRating);
            ViewData["AverageRatings"] = avgRatingDict;

            ViewData["CurrentPage"] = page;
            ViewData["TotalPages"] = totalPages;

            return View(movies);
        }


        // GET: MoviesList/Search
        public async Task<IActionResult> Search(string query)
        {
            if (string.IsNullOrWhiteSpace(query))
                return RedirectToAction(nameof(Index));

            query = query.ToLower();

            var movies = await _context.Movies
                .Include(m => m.Country)
                .Include(m => m.Language)
                .Include(m => m.Rating)
                .Include(m => m.Director)
                .Include(m => m.MovieGenres)
                    .ThenInclude(mg => mg.Genre)
                .Where(m =>
                    EF.Functions.Like(m.Title.ToLower(), $"%{query}%") ||
                    EF.Functions.Like(m.Description.ToLower(), $"%{query}%") ||
                    (m.Director != null && EF.Functions.Like(m.Director.FullName.ToLower(), $"%{query}%")) ||
                    (m.Country != null && EF.Functions.Like(m.Country.Name.ToLower(), $"%{query}%")) ||
                    (m.Language != null && EF.Functions.Like(m.Language.Name.ToLower(), $"%{query}%")) ||
                    m.MovieGenres.Any(mg => EF.Functions.Like(mg.Genre.Name.ToLower(), $"%{query}%"))
                )
                .ToListAsync();

            ViewData["Title"] = $"Search Results for \"{query}\"";
            return View("Index", movies);
        }

        // GET: MoviesList/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
                return NotFound();

            var movie = await _context.Movies
                .Include(m => m.Country)
                .Include(m => m.Language)
                .Include(m => m.Rating)
                .Include(m => m.Director)
                .Include(m => m.MovieGenres)
                    .ThenInclude(mg => mg.Genre)
                .Include(m => m.Reviews)
                    .ThenInclude(r => r.User) // 🔥 Add this line to load user info
                .FirstOrDefaultAsync(m => m.ID == id);

            if (movie == null)
                return NotFound();

            // Calculate average rating
            var averageRating = movie.Reviews.Any() ? movie.Reviews.Average(r => r.Rating) : 0;
            ViewData["AverageRating"] = averageRating;

            return View(movie);
        }

        // GET: MoviesList/OrderTicket/5
        public IActionResult OrderTicket(int id, string search, string date, int? theaterId)
        {
            var movie = _context.Movies.Find(id);
            if (movie == null) return NotFound();

            var now = DateTime.Now;

            var allShowtimes = _context.ShowTimes
                .Include(s => s.Auditorium)
                    .ThenInclude(a => a.Theater)
                .Where(s => s.MovieID == id && s.StartTime >= now)
                .ToList();

            // No filters should affect what's passed to the view
            ViewData["Movie"] = movie;
            ViewData["Search"] = search;
            ViewData["Date"] = date;
            ViewData["SelectedTheaterId"] = theaterId;

            return View(allShowtimes);
        }



        // GET: MoviesList/OrderTicketDetails/5 (id = ShowTimeID)
        public IActionResult OrderTicketDetails(int id)
        {
            var showtime = _context.ShowTimes
                .Include(s => s.Movie)                // ✅ Include Movie here
                .Include(s => s.Auditorium)
                    .ThenInclude(a => a.Seats)
                .FirstOrDefault(s => s.ID == id);

            if (showtime == null)
            {
                TempData["Error"] = "Showtime not found.";
                return RedirectToAction("OrderTicket", new { id });
            }

            if (showtime.Auditorium == null)
            {
                TempData["Error"] = "Auditorium information is missing.";
                return RedirectToAction("OrderTicket", new { id });
            }

            var seats = showtime.Auditorium.Seats?.ToList() ?? new List<Seat>();

            // Get all the seat IDs that are already taken for this showtime
            var takenSeats = _context.TicketSeats
                .Include(ts => ts.Ticket)
                .Where(ts => ts.Ticket != null && ts.Ticket.ShowTimeID == id)
                .Select(ts => ts.SeatID)
                .ToList();

            ViewData["TakenSeats"] = takenSeats;
            ViewData["ShowTime"] = showtime;

            return View(seats);
        }

        public IActionResult ConfirmOrder(int ShowTimeID, List<int> SelectedSeats)
        {
            // ✅ Session Check
            var role = HttpContext.Session.GetString("Role");
            var userIdStr = HttpContext.Session.GetString("UserID");

            if (string.IsNullOrEmpty(role) || role != "User" || string.IsNullOrEmpty(userIdStr))
            {
                TempData["Error"] = "Only logged-in users can book tickets.";
                return RedirectToAction("Login", "Account");
            }

            int userId = int.Parse(userIdStr);

            // ✅ Validate ShowTime
            var showTime = _context.ShowTimes
                .Include(st => st.Tickets)
                .ThenInclude(t => t.TicketSeats)
                .FirstOrDefault(st => st.ID == ShowTimeID);

            if (showTime == null)
            {
                return NotFound("ShowTime not found.");
            }

            // ✅ Check available seats
            var availableSeats = _context.Seats
                .Where(s => SelectedSeats.Contains(s.ID))
                .ToList();

            var takenSeatIds = showTime.Tickets
                .SelectMany(t => t.TicketSeats)
                .Select(ts => ts.SeatID)
                .ToHashSet();

            var alreadyTaken = SelectedSeats.Intersect(takenSeatIds).ToList();
            if (alreadyTaken.Any())
            {
                TempData["Error"] = "Some seats have already been booked. Please try again.";
                return RedirectToAction("OrderTicketDetails", new { id = ShowTimeID });
            }

            // ✅ Create Ticket
            var ticket = new Ticket
            {
                UserID = userId,
                ShowTimeID = ShowTimeID,
                PurchaseTime = DateTime.Now,
                TotalPrice = availableSeats.Count * 10 // Adjust price logic if needed
            };

            _context.Tickets.Add(ticket);
            _context.SaveChanges(); // To get Ticket ID

            // ✅ Create TicketSeats
            var ticketSeats = availableSeats.Select(seat => new TicketSeat
            {
                TicketID = ticket.ID,
                SeatID = seat.ID
            }).ToList();

            _context.TicketSeats.AddRange(ticketSeats);
            _context.SaveChanges();

            TempData["Success"] = "Seats reserved successfully!";
            return RedirectToAction("OrderConfirmation", new { ticketId = ticket.ID });
        }


        public IActionResult OrderConfirmation(int ticketId)
        {
            var ticket = _context.Tickets
                .Include(t => t.ShowTime)
                    .ThenInclude(st => st.Movie)
                .Include(t => t.ShowTime)
                    .ThenInclude(st => st.Auditorium)
                        .ThenInclude(a => a.Theater)
                .Include(t => t.TicketSeats)
                    .ThenInclude(ts => ts.Seat)
                .FirstOrDefault(t => t.ID == ticketId);

            if (ticket == null)
            {
                return NotFound("Ticket not found.");
            }

            return View(ticket);
        }

    }
}
