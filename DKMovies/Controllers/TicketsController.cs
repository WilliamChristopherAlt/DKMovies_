using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DKMovies.Models;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

public class TicketsController : Controller
{
    private readonly ApplicationDbContext _context;

    public TicketsController(ApplicationDbContext context)
    {
        _context = context;
    }

    // GET: Tickets/OrderTicket/5
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

        return View("OrderTicket", allShowtimes);
    }



    // GET: Tickets/OrderTicketDetails/5 (id = ShowTimeID)
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
        // ✅ Ensure authenticated and in role "User"
        if (!User.Identity.IsAuthenticated || !User.IsInRole("User"))
        {
            TempData["Error"] = "Only logged-in users can book tickets.";
            return RedirectToAction("Login", "Account");
        }

        // ✅ Get user ID from claims
        var userIdClaim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier);
        if (userIdClaim == null || !int.TryParse(userIdClaim.Value, out int userId))
        {
            TempData["Error"] = "User session is invalid.";
            return RedirectToAction("Login", "Account");
        }

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

    public async Task<IActionResult> UserTickets(string? search, string? status, string? sort)
    {
        if (!User.Identity.IsAuthenticated || !User.IsInRole("User"))
            return Forbid("Only logged-in users can view ticket history.");

        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
        if (userIdClaim == null || !int.TryParse(userIdClaim.Value, out int userId))
            return Unauthorized("Invalid user session.");

        var query = _context.Tickets
            .Where(t => t.UserID == userId)
            .Include(t => t.ShowTime).ThenInclude(st => st.Movie)
            .Include(t => t.ShowTime).ThenInclude(st => st.Auditorium).ThenInclude(a => a.Theater)
            .Include(t => t.TicketSeats).ThenInclude(ts => ts.Seat)
            .AsQueryable();

        // Search by movie title
        if (!string.IsNullOrWhiteSpace(search))
        {
            query = query.Where(t =>
                t.ShowTime.Movie.Title.Contains(search) ||
                t.ShowTime.Auditorium.Theater.Name.Contains(search));
        }

        // Filter by status
        if (!string.IsNullOrWhiteSpace(status))
        {
            if (Enum.TryParse(status.ToUpper(), out TicketStatus parsedStatus))
                query = query.Where(t => t.Status == parsedStatus);
        }

        // Sorting
        query = sort switch
        {
            "date_asc" => query.OrderBy(t => t.PurchaseTime),
            "date_desc" => query.OrderByDescending(t => t.PurchaseTime),
            "price_asc" => query.OrderBy(t => t.ShowTime.Price * t.TicketSeats.Count),
            "price_desc" => query.OrderByDescending(t => t.ShowTime.Price * t.TicketSeats.Count),
            _ => query.OrderByDescending(t => t.PurchaseTime)
        };

        var tickets = await query.ToListAsync();
        return View(tickets);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    [Authorize(Roles = "User")]
    public async Task<IActionResult> CancelTicket(int ticketId)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));

        var ticket = await _context.Tickets
            .Include(t => t.ShowTime)
            .FirstOrDefaultAsync(t => t.ID == ticketId && t.UserID == userId);

        if (ticket == null)
            return NotFound();

        if (ticket.Status != TicketStatus.PENDING)
        {
            TempData["ErrorMessage"] = "Only pending tickets can be cancelled.";
            return RedirectToAction("UserTickets");
        }

        if (ticket.ShowTime.StartTime <= DateTime.Now)
        {
            TempData["ErrorMessage"] = "You cannot cancel a ticket after the showtime has started.";
            return RedirectToAction("UserTickets");
        }

        ticket.Status = TicketStatus.CANCELLED;
        _context.Update(ticket);
        await _context.SaveChangesAsync();

        TempData["SuccessMessage"] = "Your ticket has been cancelled successfully.";
        return RedirectToAction("UserTickets");
    }
}
