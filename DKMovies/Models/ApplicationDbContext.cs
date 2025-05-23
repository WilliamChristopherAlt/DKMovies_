using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Reflection.Emit;
using DKMovies.Models;

namespace DKMovies.Models
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options) { }

        public DbSet<Country> Countries { get; set; }
        public DbSet<Genre> Genres { get; set; }
        public DbSet<Rating> Ratings { get; set; }
        public DbSet<Language> Languages { get; set; }
        public DbSet<Director> Directors { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Theater> Theaters { get; set; }
        public DbSet<Auditorium> Auditoriums { get; set; }
        public DbSet<Seat> Seats { get; set; }
        public DbSet<Movie> Movies { get; set; }
        public DbSet<MovieGenre> MovieGenres { get; set; }
        public DbSet<WatchListSingular> WatchList { get; set; }
        public DbSet<ShowTime> ShowTimes { get; set; }
        public DbSet<Ticket> Tickets { get; set; }
        public DbSet<TicketSeat> TicketSeats { get; set; }
        public DbSet<TicketPayment> TicketPayments { get; set; }
        public DbSet<PaymentMethod> PaymentMethods { get; set; }
        public DbSet<EmployeeRole> EmployeeRoles { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<Concession> Concessions { get; set; }
        public DbSet<TheaterConcession> TheaterConcession { get; set; }
        public DbSet<Admin> Admins { get; set; }
        public DbSet<OrderItem> OrderItems { get; set; }
        public DbSet<Review> Reviews { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<User>().ToTable("Users");
            modelBuilder.Entity<Theater>().ToTable("Theaters");
            modelBuilder.Entity<Employee>().ToTable("Employees");
            modelBuilder.Entity<EmployeeRole>().ToTable("EmployeeRoles");
            modelBuilder.Entity<Auditorium>().ToTable("Auditoriums");
            modelBuilder.Entity<Seat>().ToTable("Seats");
            modelBuilder.Entity<Movie>().ToTable("Movies");
            modelBuilder.Entity<MovieGenre>().ToTable("MovieGenres");
            modelBuilder.Entity<WatchListSingular>().ToTable("WatchList");
            modelBuilder.Entity<ShowTime>().ToTable("ShowTimes");
            modelBuilder.Entity<Ticket>().ToTable("Tickets");
            modelBuilder.Entity<TicketSeat>().ToTable("TicketSeats");
            modelBuilder.Entity<PaymentMethod>().ToTable("PaymentMethods");
            modelBuilder.Entity<TicketPayment>().ToTable("TicketPayments");
            modelBuilder.Entity<Concession>().ToTable("Concessions");
            modelBuilder.Entity<TheaterConcession>().ToTable("TheaterConcessions");
            modelBuilder.Entity<OrderItem>().ToTable("OrderItems");
            modelBuilder.Entity<Review>().ToTable("Reviews");

            modelBuilder.Entity<Country>().ToTable("Countries");
            modelBuilder.Entity<Genre>().ToTable("Genres");
            modelBuilder.Entity<Rating>().ToTable("Ratings");
            modelBuilder.Entity<Director>().ToTable("Directors");
            modelBuilder.Entity<Language>().ToTable("Languages");
            modelBuilder.Entity<Admin>().ToTable("Admins");

            modelBuilder.Entity<Ticket>()
                .Property(t => t.Status)
                .HasConversion<string>(); // stores enum as string

            // 1. Countries
            modelBuilder.Entity<Country>()
                .HasKey(c => c.ID);

            modelBuilder.Entity<Country>()
                .HasIndex(c => c.Name)
                .IsUnique();

            // 2. Genres
            modelBuilder.Entity<Genre>()
                .HasKey(g => g.ID);

            modelBuilder.Entity<Genre>()
                .HasIndex(g => g.Name)
                .IsUnique();

            // 3. Ratings
            modelBuilder.Entity<Rating>()
                .HasKey(r => r.ID);

            modelBuilder.Entity<Rating>()
                .HasIndex(r => r.Value)
                .IsUnique();

            // 4. Languages
            modelBuilder.Entity<Language>()
                .HasKey(l => l.ID);

            modelBuilder.Entity<Language>()
                .HasIndex(l => l.Name)
                .IsUnique();

            // 5. Directors
            modelBuilder.Entity<Director>()
                .HasKey(d => d.ID);

            // 6. Users
            modelBuilder.Entity<User>()
                .HasKey(u => u.ID);

            modelBuilder.Entity<User>()
                .HasIndex(u => u.Username)
                .IsUnique();

            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique();

            // 7. Theaters
            modelBuilder.Entity<Theater>()
                .HasKey(t => t.ID);

            modelBuilder.Entity<Theater>()
                .HasIndex(t => new { t.Name, t.Location })
                .IsUnique();

            // 8. Auditoriums
            modelBuilder.Entity<Auditorium>()
                .HasKey(a => a.ID);

            // 9. Seats
            modelBuilder.Entity<Seat>()
                .HasKey(s => s.ID);

            modelBuilder.Entity<Seat>()
                .HasIndex(s => new { s.AuditoriumID, s.RowLabel, s.SeatNumber })
                .IsUnique();

            // 10. Movies
            modelBuilder.Entity<Movie>()
                .HasKey(m => m.ID);

            modelBuilder.Entity<Movie>()
                .HasIndex(m => m.Title)
                .IsUnique();

            // 11. MovieGenre
            modelBuilder.Entity<MovieGenre>()
                .HasKey(mg => mg.ID);

            modelBuilder.Entity<MovieGenre>()
                .HasIndex(mg => new { mg.MovieID, mg.GenreID })
                .IsUnique();

            // 12. ShowTimes
            modelBuilder.Entity<ShowTime>()
                .HasKey(st => st.ID);

            // 13. Tickets
            modelBuilder.Entity<Ticket>()
                .HasKey(t => t.ID);

            // 14. PaymentMethods
            modelBuilder.Entity<PaymentMethod>()
                .HasKey(pm => pm.ID);

            modelBuilder.Entity<PaymentMethod>()
                .HasIndex(pm => pm.Name)
                .IsUnique();

            // 15. TicketPayments
            modelBuilder.Entity<TicketPayment>()
                .HasKey(tp => tp.ID);

            // 16. EmployeeRoles
            modelBuilder.Entity<EmployeeRole>()
                .HasKey(er => er.ID);

            modelBuilder.Entity<EmployeeRole>()
                .HasIndex(er => er.Name)
                .IsUnique();

            // 17. Employees
            modelBuilder.Entity<Employee>()
                .HasKey(e => e.ID);

            modelBuilder.Entity<Employee>()
                .HasIndex(e => e.Email)
                .IsUnique();

            modelBuilder.Entity<Employee>()
                .HasIndex(e => e.CitizenID)
                .IsUnique();

            // 19. Concessions
            modelBuilder.Entity<Concession>()
                .HasKey(c => c.ID);

            // 21. OrderItems
            modelBuilder.Entity<OrderItem>()
                .HasKey(oi => oi.ID);

            // 23. Reviews
            modelBuilder.Entity<Review>()
                .HasKey(r => r.ID);

            // 24. Admins
            modelBuilder.Entity<Admin>()
                .HasKey(a => a.ID);

            modelBuilder.Entity<Admin>()
                .HasIndex(a => a.EmployeeID)
                .IsUnique();

            modelBuilder.Entity<Admin>()
                .HasIndex(a => a.Username)
                .IsUnique();


            // 1. Countries
            modelBuilder.Entity<Country>()
                .HasMany(c => c.Directors)
                .WithOne(d => d.Country)
                .HasForeignKey(d => d.CountryID)
                .OnDelete(DeleteBehavior.SetNull);

            modelBuilder.Entity<Country>()
                .HasMany(c => c.Movies)
                .WithOne(m => m.Country)
                .HasForeignKey(m => m.CountryID)
                .OnDelete(DeleteBehavior.SetNull);

            // 2. Genres
            modelBuilder.Entity<Genre>()
                .HasMany(g => g.MovieGenres)
                .WithOne(mg => mg.Genre)
                .HasForeignKey(mg => mg.GenreID)
                .OnDelete(DeleteBehavior.Cascade);

            // 3. Ratings
            modelBuilder.Entity<Rating>()
                .HasMany(r => r.Movies)
                .WithOne(m => m.Rating)
                .HasForeignKey(m => m.RatingID)
                .OnDelete(DeleteBehavior.Restrict);

            // 4. Languages
            modelBuilder.Entity<Language>()
                .HasMany(l => l.Movies)
                .WithOne(m => m.Language)
                .HasForeignKey(m => m.LanguageID)
                .OnDelete(DeleteBehavior.SetNull);

            modelBuilder.Entity<Language>()
                .HasMany(l => l.ShowTimes)
                .WithOne(st => st.SubtitleLanguage)
                .HasForeignKey(st => st.SubtitleLanguageID)
                .OnDelete(DeleteBehavior.SetNull);

            // 5. Directors
            modelBuilder.Entity<Director>()
                .HasMany(d => d.Movies)
                .WithOne(m => m.Director)
                .HasForeignKey(m => m.DirectorID)
                .OnDelete(DeleteBehavior.SetNull);

            // 6. Users
            modelBuilder.Entity<User>()
                .HasMany(u => u.Tickets)
                .WithOne(t => t.User)
                .HasForeignKey(t => t.UserID)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<User>()
                .HasMany(u => u.Reviews)
                .WithOne(r => r.User)
                .HasForeignKey(r => r.UserID)
                .OnDelete(DeleteBehavior.Cascade);

            // 7. Theaters
            modelBuilder.Entity<Theater>()
                .HasMany(t => t.Auditoriums)
                .WithOne(a => a.Theater)
                .HasForeignKey(a => a.TheaterID)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Theater>()
                .HasMany(t => t.Employees)
                .WithOne(e => e.Theater)
                .HasForeignKey(e => e.TheaterID)
                .OnDelete(DeleteBehavior.Cascade);

            // 8. Auditoriums
            modelBuilder.Entity<Auditorium>()
                .HasMany(a => a.Seats)
                .WithOne(s => s.Auditorium)
                .HasForeignKey(s => s.AuditoriumID)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Auditorium>()
                .HasMany(a => a.ShowTimes)
                .WithOne(st => st.Auditorium)
                .HasForeignKey(st => st.AuditoriumID)
                .OnDelete(DeleteBehavior.Cascade);

            // 9. Seats


            // 10. Movies
            modelBuilder.Entity<Movie>()
                .HasMany(m => m.MovieGenres)
                .WithOne(mg => mg.Movie)
                .HasForeignKey(mg => mg.MovieID)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Movie>()
                .HasMany(m => m.ShowTimes)
                .WithOne(st => st.Movie)
                .HasForeignKey(st => st.MovieID)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Movie>()
                .HasMany(m => m.Reviews)
                .WithOne(r => r.Movie)
                .HasForeignKey(r => r.MovieID)
                .OnDelete(DeleteBehavior.Cascade);

            // 11. MovieGenre
            // No children

            // 12. ShowTimes
            modelBuilder.Entity<ShowTime>()
                .HasMany(st => st.Tickets)
                .WithOne(t => t.ShowTime)
                .HasForeignKey(t => t.ShowTimeID)
                .OnDelete(DeleteBehavior.Cascade);

            // 13. Tickets
            modelBuilder.Entity<Ticket>()
                .HasMany(t => t.TicketPayments)
                .WithOne(tp => tp.Ticket)
                .HasForeignKey(tp => tp.TicketID)
                .OnDelete(DeleteBehavior.Cascade);

            // 14. PaymentMethods
            modelBuilder.Entity<PaymentMethod>()
                .HasMany(pm => pm.TicketPayments)
                .WithOne(tp => tp.PaymentMethod)
                .HasForeignKey(tp => tp.MethodID)
                .OnDelete(DeleteBehavior.Cascade);

            // 15. TicketPayments
            // No children

            // 16. EmployeeRoles
            modelBuilder.Entity<EmployeeRole>()
                .HasMany(er => er.Employees)
                .WithOne(e => e.Role)
                .HasForeignKey(e => e.RoleID)
                .OnDelete(DeleteBehavior.SetNull);

            // 17. Employees
            modelBuilder.Entity<Employee>()
                .HasMany(e => e.Admins)
                .WithOne(a => a.Employee)
                .HasForeignKey(a => a.EmployeeID)
                .OnDelete(DeleteBehavior.Cascade);


            // 19. Concessions
            modelBuilder.Entity<Concession>()
                .HasMany(c => c.TheaterConcessions)
                .WithOne(oi => oi.Concession)
                .HasForeignKey(oi => oi.ConcessionID)
                .OnDelete(DeleteBehavior.Cascade);

            // 21. OrderItems
            // No children

            // 22. OrderPayments
            // No children

            // 23. Reviews
            // No children

            // 24. Admins
            // No children

        }
    }
}
