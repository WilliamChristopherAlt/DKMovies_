USE DKMovies;
GO

-- COUNTRIES
INSERT INTO Countries (Name, Description) VALUES
('United States', 'Country in North America'),
('United Kingdom', 'Country in Western Europe'),
('France', 'Country in Western Europe'),
('Japan', 'Island country in East Asia'),
('India', 'Country in South Asia'),
('Canada', 'Country in North America'),
('Germany', 'Country in Central Europe'),
('Italy', 'Country in Southern Europe'),
('Australia', 'Country in Oceania'),
('South Korea', 'Country in East Asia'),
('Vietnam', 'Country in Southeast Asia');

-- GENRES
INSERT INTO Genres (Name, Description) VALUES
('Action', 'High-energy and intense sequences'),
('Drama', 'Emotional and character-driven stories'),
('Comedy', 'Humorous and entertaining content'),
('Thriller', 'Suspenseful and gripping plots'),
('Sci-Fi', 'Futuristic and science-based themes'),
('Fantasy', 'Magical and mythical elements'),
('Horror', 'Scary and unsettling experiences'),
('Romance', 'Focus on love and relationships'),
('Adventure', 'Exciting journeys and exploration'),
('Animation', 'Stories told through animated visuals');

-- RATINGS
INSERT INTO Ratings (Value, Description) VALUES
('G', 'General Audiences'),
('PG', 'Parental Guidance Suggested'),
('PG-13', 'Parents Strongly Cautioned'),
('R', 'Restricted to 17 and over'),
('NC-17', 'Adults Only - 18 and over'),
('M', 'Mature content, ages 16+');

-- LANGUAGES
INSERT INTO Languages (Name, Description) VALUES
('English', 'Widely spoken language used in international communication and business'),
('French', 'Official language in France, parts of Africa, and Canada'),
('Japanese', 'Primary language spoken in Japan'),
('Vietnamese', 'Official language of Vietnam, spoken by millions globally'),
('Korean', 'Official language of South Korea and North Korea'),
('German', 'Main language of Germany, Austria, and parts of Switzerland'),
('Chinese', 'Spoken mainly in China with several regional dialects'),
('Spanish', 'Widely spoken in Spain, Latin America, and parts of the US');

-- PAYMENT METHODS
INSERT INTO PaymentMethods (Name, Description) VALUES
('Credit Card', 'Visa, MasterCard, AMEX'),
('PayPal', 'Online payments'),
('Cash', 'Physical currency at the counter'),
('Apple Pay', 'Mobile payment service');

-- EMPLOYEE ROLES
INSERT INTO EmployeeRoles (Name, Description) VALUES
('Manager', 'Theater manager'),
('Cashier', 'Handles ticketing and sales'),
('Cleaner', 'Responsible for cleaning duties'),
('Technician', 'Maintains cinema equipment'),
('Usher', 'Guides customers to their seats');

-- MEASUREMENT UNITS
INSERT INTO MeasurementUnits (Name, IsContinuous) VALUES
('Piece', 0),
('Liter', 1),
('Kg', 1),
('Box', 0);

-- USERS
INSERT INTO Users (Username, Email, PasswordHash, FullName, Phone, BirthDate, Gender, ProfileImagePath) VALUES
('john_doe', 'john@example.com', 'hash1', 'John Doe', '1111111111', '1990-01-01', 'Male', 'men/0.jpg'),
('jane_doe', 'jane@example.com', 'hash2', 'Jane Doe', '2222222222', '1992-05-05', 'Female', 'women/0.jpg'),
('alex_lee', 'alex@example.com', 'hash3', 'Alex Lee', '3333333333', '1988-11-20', 'Other', 'men/1.jpg'),
('maria_smith', 'maria@example.com', 'hash4', 'Maria Smith', '4444444444', '1985-07-22', 'Female', 'women/1.jpg'),
('bob_jones', 'bob@example.com', 'hash5', 'Bob Jones', '5555555555', '1980-02-14', 'Male', 'men/2.jpg');

-- THEATERS
INSERT INTO Theaters (Name, Location, Phone) VALUES
('Cineworld LA', 'Los Angeles', '555-1234'),
('Galaxy NY', 'New York', '555-5678'),
('Regal Cinemas', 'Chicago', '555-9876'),
('Film City', 'San Francisco', '555-4321');

-- EMPLOYEES
INSERT INTO Employees (TheaterID, RoleID, FullName, Email, Phone, Gender, DateOfBirth, CitizenID, Address, Salary, ProfileImagePath) VALUES
(1, 1, 'Alice Manager', 'alice@cineworld.com', '9999999999', 'Female', '1980-07-01', 'AAA111', '123 Sunset Blvd', 5000, 'women/10.jpg'),
(1, 2, 'Bob Cashier', 'bob@cineworld.com', '8888888888', 'Male', '1990-09-15', 'BBB222', '456 Ocean Dr', 3000, 'men/10.jpg'),
(2, 1, 'Clara Watts', 'clara@galaxy.com', '7777777777', 'Female', '1985-03-12', 'CCC333', '789 Park Ave', 5200, 'women/11.jpg'),
(3, 3, 'Dave Clean', 'dave@regal.com', '6666666666', 'Male', '1992-11-09', 'DDD444', '123 Elm St', 2500, 'men/11.jpg'),
(4, 4, 'Emily Usher', 'emily@filmcity.com', '5555555555', 'Female', '1990-03-21', 'EEE555', '456 Oak Rd', 2800, 'women/12.jpg');

-- ADMINS
INSERT INTO Admins (EmployeeID, PasswordHash, Username) VALUES
(1, 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', 'admin_alice'),
(3, 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', 'admin_clara'),
(5, 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', 'admin_emily');

-- AUDITORIUMS
INSERT INTO Auditoriums (TheaterID, Name, Capacity) VALUES
(1, 'Auditorium A', 100),
(1, 'Auditorium B', 80),
(2, 'Auditorium C', 120),
(3, 'Auditorium D', 150),
(4, 'Auditorium E', 200);

-- SEATS
INSERT INTO Seats (AuditoriumID, RowLabel, SeatNumber) VALUES
(1, 'A', 1), (1, 'A', 2), (1, 'B', 1), (1, 'B', 2),
(2, 'A', 1), (2, 'A', 2),
(3, 'A', 1), (3, 'A', 2),
(4, 'A', 1), (4, 'A', 2),
(5, 'A', 1), (5, 'A', 2);

-- DIRECTORS
INSERT INTO Directors (FullName, DateOfBirth, Biography, CountryID, ProfileImagePath) VALUES
('Christopher Nolan', '1970-07-30', 'British-American filmmaker.', 2, '0.jpg'),
('Steven Spielberg', '1946-12-18', 'American director and producer.', 1, '1.jpg'),
('Quentin Tarantino', '1963-03-27', 'American filmmaker known for stylized violence and nonlinear storytelling.', 1, '2.jpg'),
('Hayao Miyazaki', '1941-01-05', 'Co-founder of Studio Ghibli and acclaimed Japanese animator.', 4, '3.jpg'),
('Bong Joon-ho', '1969-09-14', 'South Korean director and screenwriter.', 10, '4.jpg'),
('Denis Villeneuve', '1967-10-03', 'Canadian director known for science fiction and drama.', 6, '5.jpg'),
('James Cameron', '1954-08-16', 'Canadian filmmaker known for epic blockbusters.', 6, '6.jpg'),
('Martin Scorsese', '1942-11-17', 'American director known for crime dramas.', 1, '7.jpg'),
('Greta Gerwig', '1983-08-04', 'American actress, screenwriter, and director.', 1, '8.jpg'),
('Taika Waititi', '1975-08-16', 'New Zealand director, actor, and comedian.', 9, '9.jpg'),
('Alfonso Cuarón', '1961-11-28', 'Mexican filmmaker known for technical brilliance.', 1, '10.jpg'),
('Ridley Scott', '1937-11-30', 'British director known for sci-fi and historical epics.', 2, '11.jpg'),
('Patty Jenkins', '1971-07-24', 'American director and screenwriter.', 1, '12.jpg'),
('Wes Anderson', '1969-05-01', 'American filmmaker known for stylized visuals.', 1, '13.jpg'),
('Damien Chazelle', '1985-01-19', 'American director known for musical and drama films.', 1, '14.jpg'),
('Jordan Peele', '1979-02-21', 'American director known for horror-thrillers.', 1, '15.jpg'),
('Chloé Zhao', '1982-03-31', 'Chinese filmmaker known for minimalist storytelling.', 7, '16.jpg'),
('Peter Jackson', '1961-10-31', 'New Zealand director of epic fantasy.', 9, '17.jpg'),
('Guillermo del Toro', '1964-10-09', 'Mexican director known for dark fantasy films.', 1, '18.jpg'),
('George Miller', '1945-03-03', 'Australian director best known for Mad Max series.', 9, '19.jpg'),
('Francis Ford Coppola', '1939-04-07', 'American director known for the Godfather trilogy.', 1, '20.jpg'),
('Stanley Kubrick', '1928-07-26', 'American director known for his work in various genres.', 1, '21.jpg'),
('Tim Burton', '1958-08-25', 'American director known for dark fantasy and horror films.', 1, '22.jpg'),
('Robert Zemeckis', '1952-05-14', 'American director and producer, best known for Back to the Future.', 1, '23.jpg'),
('Oliver Stone', '1946-09-15', 'American director known for politically charged films.', 1, '25.jpg'),
('Ron Howard', '1954-03-01', 'American filmmaker known for mainstream films.', 1, '26.jpg'),
('Martin Campbell', '1943-10-24', 'British director known for action films, especially James Bond.', 2, '27.jpg'),
('James Wan', '1977-02-26', 'Australian director known for horror and action films.', 6, '28.jpg'),
('Michael Bay', '1965-02-17', 'American director known for action blockbusters and explosions.', 1, '29.jpg'),
('Sam Mendes', '1965-08-01', 'British filmmaker known for dramas and action films.', 2, '30.jpg'),
('M. Night Shyamalan', '1970-08-06', 'Indian-American director known for supernatural thrillers.', 1, '31.jpg'),
('David Fincher', '1962-08-28', 'American director known for psychological thrillers.', 1, '32.jpg');

-- MOVIES
INSERT INTO Movies (Title, Description, DurationMinutes, RatingID, ReleaseDate, LanguageID, CountryID, DirectorID, ImagePath)
VALUES 
('Inception', 'A thief enters dreams to implant ideas.', 148, 3, '2010-07-16', 1, 1, 1, '0.jpg'),
('E.T. the Extra-Terrestrial', 'A child befriends an alien.', 115, 2, '1982-06-11', 1, 1, 2, '1.jpg'),
('Pulp Fiction', 'Interconnected crime stories in LA.', 154, 4, '1994-10-14', 1, 1, 3, '2.jpg'),
('Spirited Away', 'A girl finds herself in a spirit world.', 125, 2, '2001-07-20', 3, 4, 4, '3.jpg'),
('Parasite', 'A poor family schemes to infiltrate a wealthy one.', 132, 4, '2019-05-30', 5, 10, 5, '4.jpg'),
('Dune', 'A noble family fights for control of a desert planet.', 155, 3, '2021-10-22', 1, 1, 6, '5.jpg'),
('Avatar', 'A paraplegic Marine is sent to another world.', 162, 3, '2009-12-18', 1, 1, 7, '6.jpg'),
('The Irishman', 'A mob hitman reflects on his life.', 209, 4, '2019-11-01', 1, 1, 8, '7.jpg'),
('Barbie', 'A doll ventures into the real world.', 114, 2, '2023-07-21', 1, 1, 9, '8.jpg'),
('Jojo Rabbit', 'A boy’s imaginary friend is Hitler in WWII Germany.', 108, 2, '2019-10-18', 1, 9, 10, '9.jpg'),
('Gravity', 'An astronaut is stranded in space.', 91, 3, '2013-10-04', 1, 1, 11, '10.jpg'),
('Gladiator', 'A Roman general seeks vengeance.', 155, 4, '2000-05-05', 1, 1, 12, '11.jpg'),
('Wonder Woman', 'An Amazon princess fights in World War I.', 141, 3, '2017-06-02', 1, 1, 13, '12.jpg'),
('The Grand Budapest Hotel', 'The adventures of a hotel concierge.', 99, 2, '2014-03-28', 1, 1, 14, '13.jpg'),
('La La Land', 'A musician and an actress fall in love.', 128, 2, '2016-12-09', 1, 1, 15, '14.jpg'),
('Get Out', 'A Black man uncovers a sinister family secret.', 104, 4, '2017-02-24', 1, 1, 16, '15.jpg'),
('Nomadland', 'A woman travels the American West.', 108, 2, '2020-12-04', 1, 1, 17, '16.jpg'),
('The Lord of the Rings: The Fellowship of the Ring', 'A hobbit sets out to destroy an evil ring.', 178, 3, '2001-12-19', 1, 9, 18, '17.jpg'),
('Pan''s Labyrinth', 'A girl escapes into a fantasy world during the Spanish Civil War.', 118, 4, '2006-10-11', 1, 1, 19, '18.jpg'),
('Mad Max: Fury Road', 'Post-apocalyptic chase across a desert wasteland.', 120, 4, '2015-05-15', 1, 9, 20, '19.jpg'),
('The Godfather', 'The patriarch of a powerful crime family seeks to preserve his empire.', 175, 4, '1972-03-24', 1, 1, 21, '20.jpg'),
('2001: A Space Odyssey', 'A spacecraft travels to Jupiter with a sentient computer on board.', 149, 3, '1968-04-03', 1, 1, 22, '21.jpg'),
('Beetlejuice', 'A deceased couple attempts to haunt their former home with the help of a mischievous ghost.', 92, 3, '1988-03-30', 1, 1, 23, '22.jpg'),
('Back to the Future', 'A teenager travels back in time in a DeLorean.', 116, 2, '1985-07-03', 1, 1, 24, '23.jpg'),
('Alien', 'The crew of a space tugboat are forced to fight for survival when they encounter a deadly alien species.', 117, 3, '1979-05-25', 1, 2, 25, '24.jpg'),
('Platoon', 'A soldier faces the brutalities of the Vietnam War.', 120, 2, '1986-12-19', 1, 1, 26, '25.jpg'),
('Apollo 13', 'A real-life drama about the dangerous Apollo 13 mission.', 140, 2, '1995-06-30', 1, 1, 27, '26.jpg'),
('Casino Royale', 'A British spy faces off with a banker to terrorists.', 144, 3, '2006-11-14', 1, 2, 28, '27.jpg'),
('The Conjuring', 'A family is terrorized by a dark force after moving into an old house.', 112, 4, '2013-07-19', 1, 6, 29, '28.jpg'),
('Transformers', 'A young man is caught in a war between two factions of robotic aliens.', 143, 3, '2007-07-03', 1, 1, 30, '29.jpg'),
('Skyfall', 'James Bond faces a dangerous adversary in a high-stakes mission.', 143, 3, '2012-10-26', 1, 2, 1, '30.jpg'),
('The Sixth Sense', 'A young boy who communicates with spirits seeks the help of a disheartened child psychologist.', 107, 4, '1999-08-06', 1, 1, 2, '31.jpg'),
('Fight Club', 'An insomniac office worker forms an underground fight club.', 139, 4, '1999-10-15', 1, 1, 3, '32.jpg'),
('Watchmen', 'In an alternate reality, superheroes are part of society and have a profound impact on history.', 163, 3, '2009-03-06', 1, 1, 4, '33.jpg'),
('Slumdog Millionaire', 'A poor young man from Mumbai wins big on a game show.', 120, 2, '2008-11-12', 1, 2, 5, '34.jpg'),
('Harry Potter and the Order of the Phoenix', 'Harry and his friends battle the forces of darkness in the wizarding world.', 138, 3, '2007-07-11', 1, 2, 6, '35.jpg'),
('Halloween', 'A masked killer escapes from an asylum and terrorizes a small town.', 91, 4, '1978-10-25', 1, 1, 7, '36.jpg'),
('In the Mood for Love', 'Two neighbors form a bond after discovering their spouses are having an affair.', 98, 2, '2000-09-01', 3, 11, 8, '37.jpg'),
('Crouching Tiger, Hidden Dragon', 'Two warriors team up to find a stolen sword in 19th-century China.', 120, 3, '2000-12-08', 1, 7, 9, '38.jpg'),
('Heat', 'A master criminal and a detective engage in a battle of wits in Los Angeles.', 170, 4, '1995-12-15', 1, 1, 10, '39.jpg'),
('Ocean''s Eleven', 'A group of criminals plans to rob three Las Vegas casinos.', 116, 3, '2001-12-07', 1, 1, 11, '40.jpg'),
('Captain America: The Winter Soldier', 'Captain America teams up with Black Widow to take down a sinister conspiracy.', 136, 3, '2014-04-04', 1, 1, 12, '41.jpg'),
('Avengers: Endgame', 'The Avengers seek to undo the damage caused by Thanos.', 181, 3, '2019-04-26', 1, 1, 13, '42.jpg'),
('There Will Be Blood', 'An ambitious oilman battles for wealth and power in early 20th-century California.', 158, 3, '2007-12-26', 1, 1, 14, '43.jpg'),
('Mission: Impossible - Fallout', 'Ethan Hunt is forced to work with a new ally to prevent a nuclear disaster.', 148, 3, '2018-07-27', 1, 1, 15, '44.jpg'),
('Requiem for a Dream', 'A drug addict spirals into madness as his life unravels.', 102, 4, '2000-10-06', 1, 1, 16, '45.jpg'),
('Amélie', 'A shy waitress sets out to improve the lives of those around her.', 122, 2, '2001-04-25', 1, 3, 17, '46.jpg'),
('Once Upon a Time in Hollywood', 'A fading actor and his stunt double try to navigate the changing landscape of Hollywood in 1969.', 161, 3, '2019-07-26', 1, 1, 18, '47.jpg'),
('No Country for Old Men', 'A hunter finds a fortune and becomes the target of a merciless killer.', 122, 4, '2007-11-09', 1, 1, 19, '48.jpg');


-- MOVIEGENRES
INSERT INTO MovieGenres (MovieID, GenreID) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(4, 2);

-- SHOWTIMES
INSERT INTO ShowTimes (MovieID, AuditoriumID, StartTime, DurationMinutes, SubtitleLanguageID, Is3D) VALUES
(1, 1, '2025-04-21 14:00', 130, 2, 0),
(2, 2, '2025-04-21 17:00', 95, 3, 1),
(3, 3, '2025-04-22 12:00', 150, 2, 0),
(4, 4, '2025-04-22 20:00', 154, 1, 0);

-- TICKETS
INSERT INTO Tickets (UserID, ShowTimeID, SeatID, TotalPrice) VALUES
(1, 1, 1, 15.00),
(2, 2, 5, 12.50),
(3, 3, 9, 20.00),
(4, 4, 12, 18.00);

-- TICKET PAYMENTS
INSERT INTO TicketPayments (TicketID, MethodID, PaymentStatus, PaidAmount, PaidAt) VALUES
(1, 1, 'Completed', 15.00, GETDATE()),
(2, 2, 'Completed', 12.50, GETDATE()),
(3, 1, 'Completed', 20.00, GETDATE()),
(4, 3, 'Completed', 18.00, GETDATE());

-- CONCESSIONS
INSERT INTO Concessions (Name, Description, Price, StockLeft, UnitID, ImagePath) VALUES
('Large Popcorn', 'Buttered popcorn.', 5.00, 50, 1, '0.jpg'),
('Soda', 'Chilled drink.', 3.00, 100, 2, '1.jpg'),
('Nachos', 'Cheese and crispy chips.', 4.00, 30, 1, '2.jpg'),
('Candy', 'Sweet and delicious candy.', 2.50, 60, 1, '3.jpg');

-- ORDERS
INSERT INTO Orders (UserID, TotalAmount, OrderStatus) VALUES
(1, 8.00, 'Completed'),
(2, 6.00, 'Completed'),
(3, 10.00, 'Completed'),
(4, 7.50, 'Completed');

-- ORDER ITEMS
INSERT INTO OrderItems (OrderID, ConcessionID, Quantity, PriceAtPurchase) VALUES
(1, 1, 1, 5.00),
(1, 2, 1, 3.00),
(2, 2, 2, 3.00),
(3, 1, 2, 5.00),
(4, 3, 1, 4.00);

-- ORDER PAYMENTS
INSERT INTO OrderPayments (OrderID, MethodID, PaymentStatus, PaidAmount, PaidAt) VALUES
(1, 1, 'Completed', 8.00, GETDATE()),
(2, 3, 'Completed', 6.00, GETDATE()),
(3, 1, 'Completed', 10.00, GETDATE()),
(4, 2, 'Completed', 7.50, GETDATE());

-- REVIEWS
INSERT INTO Reviews (MovieID, UserID, Rating, Comment, IsApproved) VALUES
(1, 1, 5, 'Mind-blowing movie!', 1),
(2, 2, 4, 'Hilarious and fun.', 1),
(3, 3, 5, 'A thrilling journey!', 1),
(4, 4, 4, 'Amazing dialogue and action!', 1);
