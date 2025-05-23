USE DKMovies;
GO

-- COUNTRIES
CREATE TABLE Countries (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(255)
);

-- GENRES
CREATE TABLE Genres (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(255)
);

-- RATINGS
CREATE TABLE Ratings (
    ID INT IDENTITY PRIMARY KEY,
    Value NVARCHAR(10) UNIQUE NOT NULL,
    Description NVARCHAR(255)
);

-- LANGUAGES
CREATE TABLE Languages (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(MAX)
);

-- DIRECTORS
CREATE TABLE Directors (
    ID INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(255) UNIQUE NOT NULL,
    DateOfBirth DATE,
    Biography NVARCHAR(MAX),
    CountryID INT FOREIGN KEY REFERENCES Countries(ID) ON DELETE CASCADE,
	ProfileImagePath NVARCHAR(500),
);

-- USERS
CREATE TABLE Users (
    ID INT IDENTITY PRIMARY KEY,
    Username NVARCHAR(255) UNIQUE NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(255),
    Phone NVARCHAR(20),
    BirthDate DATE,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    ProfileImagePath NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- THEATERS
CREATE TABLE Theaters (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255) UNIQUE NOT NULL,
    Location NVARCHAR(255) UNIQUE NOT NULL,
    Phone NVARCHAR(20)
);

-- AUDITORIUMS
CREATE TABLE Auditoriums (
    ID INT IDENTITY PRIMARY KEY,
    TheaterID INT FOREIGN KEY REFERENCES Theaters(ID) ON DELETE CASCADE,
    Name NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL
);

-- SEATS
CREATE TABLE Seats (
    ID INT IDENTITY PRIMARY KEY,
    AuditoriumID INT FOREIGN KEY REFERENCES Auditoriums(ID) ON DELETE CASCADE,
    RowLabel CHAR(1) NOT NULL,
    SeatNumber INT NOT NULL,
    CONSTRAINT UC_Seat UNIQUE (AuditoriumID, RowLabel, SeatNumber)
);

-- MOVIES
CREATE TABLE Movies (
    ID INT IDENTITY PRIMARY KEY,
    Title NVARCHAR(255) UNIQUE NOT NULL,
    Description NVARCHAR(MAX),
    DurationMinutes INT NOT NULL,
    RatingID INT FOREIGN KEY REFERENCES Ratings(ID) ON DELETE CASCADE,
    ReleaseDate DATE,
    LanguageID INT FOREIGN KEY REFERENCES Languages(ID) ON DELETE CASCADE,
    CountryID INT FOREIGN KEY REFERENCES Countries(ID) ON DELETE NO ACTION,
    DirectorID INT FOREIGN KEY REFERENCES Directors(ID) ON DELETE SET NULL,
    PosterImagePath NVARCHAR(500),
	WallpaperImagePath NVARCHAR(500)
);

-- MOVIEGENRE
CREATE TABLE MovieGenres (
    ID INT IDENTITY PRIMARY KEY,
    MovieID INT NOT NULL,
    GenreID INT NOT NULL,
    FOREIGN KEY (MovieID) REFERENCES Movies(ID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(ID) ON DELETE CASCADE,
    CONSTRAINT UC_MovieGenre UNIQUE (MovieID, GenreID)
);

-- SHOWTIMES
CREATE TABLE ShowTimes (
    ID INT IDENTITY PRIMARY KEY,
    MovieID INT NOT NULL,
    AuditoriumID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    DurationMinutes INT NOT NULL,
    SubtitleLanguageID INT NULL,
    Is3D BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (MovieID) REFERENCES Movies(ID) ON DELETE CASCADE,
    FOREIGN KEY (AuditoriumID) REFERENCES Auditoriums(ID) ON DELETE CASCADE,
    FOREIGN KEY (SubtitleLanguageID) REFERENCES Languages(ID) -- removed ON DELETE CASCADE
);

-- TICKETS
CREATE TABLE Tickets (
    ID INT IDENTITY PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(ID) ON DELETE CASCADE,
    ShowTimeID INT FOREIGN KEY REFERENCES ShowTimes(ID) ON DELETE CASCADE,
    PurchaseTime DATETIME DEFAULT GETDATE(),
    TotalPrice DECIMAL(10, 2) NOT NULL
);

-- TICKET_SEATS
CREATE TABLE TicketSeats (
    ID INT IDENTITY PRIMARY KEY,
    TicketID INT NOT NULL,
    SeatID INT NOT NULL,
    FOREIGN KEY (TicketID) REFERENCES Tickets(ID) ON DELETE CASCADE,
    FOREIGN KEY (SeatID) REFERENCES Seats(ID)
);

-- PAYMENT METHODS
CREATE TABLE PaymentMethods (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) UNIQUE NOT NULL,
    Description NVARCHAR(255)
);

-- TICKET PAYMENTS
CREATE TABLE TicketPayments (
    ID INT IDENTITY PRIMARY KEY,
    TicketID INT FOREIGN KEY REFERENCES Tickets(ID) ON DELETE CASCADE,
    MethodID INT FOREIGN KEY REFERENCES PaymentMethods(ID) ON DELETE CASCADE,
    PaymentStatus NVARCHAR(50) CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed')) NOT NULL,
    PaidAmount DECIMAL(10, 2),
    PaidAt DATETIME
);

-- EMPLOYEE ROLES
CREATE TABLE EmployeeRoles (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(255)
);

-- EMPLOYEES
CREATE TABLE Employees (
    ID INT IDENTITY PRIMARY KEY,
    TheaterID INT FOREIGN KEY REFERENCES Theaters(ID) ON DELETE CASCADE,
    RoleID INT FOREIGN KEY REFERENCES EmployeeRoles(ID) ON DELETE CASCADE,
    FullName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    DateOfBirth DATE,
    CitizenID NVARCHAR(50) UNIQUE,
    Address NVARCHAR(255),
    HireDate DATE DEFAULT GETDATE(),
    Salary DECIMAL(10, 2) NOT NULL,
	ProfileImagePath NVARCHAR(500),
);

-- MEASUREMENT UNITS
CREATE TABLE MeasurementUnits (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) UNIQUE NOT NULL,
    IsContinuous BIT NOT NULL
);

-- CONCESSIONS
CREATE TABLE Concessions (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(255),
    Price DECIMAL(6, 2) NOT NULL,
    StockLeft INT NOT NULL CHECK (StockLeft >= 0),
    UnitID INT FOREIGN KEY REFERENCES MeasurementUnits(ID) ON DELETE CASCADE,
    IsAvailable BIT DEFAULT 1,
    ImagePath NVARCHAR(500)
);

-- ORDERS
CREATE TABLE Orders (
    ID INT IDENTITY PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(ID) ON DELETE CASCADE,
    OrderTime DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2),
    OrderStatus NVARCHAR(50) CHECK (OrderStatus IN ('Pending', 'Completed', 'Cancelled')) DEFAULT 'Pending'
);

-- ORDER ITEMS
CREATE TABLE OrderItems (
    ID INT IDENTITY PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(ID) ON DELETE CASCADE,
    ConcessionID INT FOREIGN KEY REFERENCES Concessions(ID) ON DELETE CASCADE,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PriceAtPurchase DECIMAL(6, 2) NOT NULL
);

-- ORDER PAYMENTS
CREATE TABLE OrderPayments (
    ID INT IDENTITY PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(ID) ON DELETE CASCADE,
    MethodID INT FOREIGN KEY REFERENCES PaymentMethods(ID) ON DELETE CASCADE,
    PaymentStatus NVARCHAR(50) CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed')) NOT NULL,
    PaidAmount DECIMAL(10, 2),
    PaidAt DATETIME
);

-- REVIEWS
CREATE TABLE Reviews (
    ID INT IDENTITY PRIMARY KEY,
    MovieID INT FOREIGN KEY REFERENCES Movies(ID) ON DELETE CASCADE,
    UserID INT FOREIGN KEY REFERENCES Users(ID) ON DELETE CASCADE,
    Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
    Comment NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsApproved BIT DEFAULT 0
);

-- ADMINS
CREATE TABLE Admins (
    ID INT IDENTITY PRIMARY KEY,
    EmployeeID INT UNIQUE NOT NULL,
    Username NVARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(ID) ON DELETE CASCADE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

GO

CREATE PROCEDURE sp_DeleteTheaterAndDependencies
    @TheaterID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Delete ShowTimes linked to the auditoriums of the theater
    DELETE FROM ShowTimes
    WHERE AuditoriumID IN (SELECT ID FROM Auditoriums WHERE TheaterID = @TheaterID);

    -- Delete TicketSeats linked to the seats in those auditoriums
    DELETE FROM TicketSeats
    WHERE SeatID IN (
        SELECT ID 
        FROM Seats 
        WHERE AuditoriumID IN (SELECT ID FROM Auditoriums WHERE TheaterID = @TheaterID)
    );

    -- Delete the seats
    DELETE FROM Seats
    WHERE AuditoriumID IN (SELECT ID FROM Auditoriums WHERE TheaterID = @TheaterID);

    -- Finally, delete the auditoriums
    DELETE FROM Auditoriums WHERE TheaterID = @TheaterID;

    -- And the theater itself
    DELETE FROM Theaters WHERE ID = @TheaterID;
END;
GO


CREATE PROCEDURE sp_DeleteSeatAndDependencies
    @SeatID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Delete TicketSeats linked to this seat
    DELETE FROM TicketSeats WHERE SeatID = @SeatID;

    -- Delete the seat itself
    DELETE FROM Seats WHERE ID = @SeatID;
END;
GO


-- Create stored procedure to delete Movies and Directors by Country
DROP PROCEDURE IF EXISTS sp_DeleteCountryMovies;
GO
CREATE PROCEDURE sp_DeleteCountryMovies
    @CountryID INT
AS
BEGIN
    DELETE FROM Movies WHERE CountryID = @CountryID;
    DELETE FROM Directors WHERE CountryID = @CountryID;
END;
GO

-- Create stored procedure to delete ShowTimes by Language
DROP PROCEDURE IF EXISTS sp_DeleteLanguage_ShowTimes;
GO
CREATE PROCEDURE sp_DeleteLanguage_ShowTimes
    @LanguageID INT
AS
BEGIN
    DELETE FROM ShowTimes WHERE SubtitleLanguageID = @LanguageID;
END;
GO