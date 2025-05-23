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
('john_doe', 'john@example.com', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', 'John Doe', '1111111111', '1990-01-01', 'Male', 'men/0.jpg'),
('jane_doe', 'jane@example.com', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', 'Jane Doe', '2222222222', '1992-05-05', 'Female', 'women/0.jpg'),
('alex_lee', 'alex@example.com', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', 'Alex Lee', '3333333333', '1988-11-20', 'Other', 'men/1.jpg'),
('maria_smith', 'maria@example.com', 'hash4', 'Maria Smith', '4444444444', '1985-07-22', 'Female', 'women/1.jpg'),
('bob_jones', 'bob@example.com', 'hash5', 'Bob Jones', '5555555555', '1980-02-14', 'Male', 'men/2.jpg'),
('susan_white', 'susan@example.com', 'hash6', 'Susan White', '6666666666', '1995-09-12', 'Female', 'women/2.jpg'),
('james_brown', 'james@example.com', 'hash7', 'James Brown', '7777777777', '1989-04-30', 'Male', 'men/3.jpg'),
('emily_davis', 'emily@example.com', 'hash8', 'Emily Davis', '8888888888', '1993-03-18', 'Female', 'women/3.jpg'),
('michael_martin', 'michael@example.com', 'hash9', 'Michael Martin', '9999999999', '1987-01-09', 'Male', 'men/4.jpg'),
('lisa_jackson', 'lisa@example.com', 'hash10', 'Lisa Jackson', '1010101010', '1991-06-24', 'Female', 'women/4.jpg'),
('chris_rodgers', 'chris@example.com', 'hash11', 'Chris Rodgers', '2020202020', '1982-12-02', 'Male', 'men/5.jpg'),
('patricia_lee', 'patricia@example.com', 'hash12', 'Patricia Lee', '3030303030', '1996-07-14', 'Female', 'women/5.jpg'),
('david_wilson', 'david@example.com', 'hash13', 'David Wilson', '4040404040', '1986-11-03', 'Male', 'men/6.jpg'),
('sarah_miller', 'sarah@example.com', 'hash14', 'Sarah Miller', '5050505050', '1994-08-25', 'Female', 'women/6.jpg'),
('william_rodgers', 'william@example.com', 'hash15', 'William Rodgers', '6060606060', '1990-12-05', 'Male', 'men/7.jpg'),
('charlotte_clark', 'charlotte@example.com', 'hash16', 'Charlotte Clark', '7070707070', '1987-02-20', 'Female', 'women/7.jpg'),
('jacob_harris', 'jacob@example.com', 'hash17', 'Jacob Harris', '8080808080', '1983-05-15', 'Male', 'men/8.jpg'),
('olivia_taylor', 'olivia@example.com', 'hash18', 'Olivia Taylor', '9090909090', '1998-10-22', 'Female', 'women/8.jpg'),
('benjamin_young', 'benjamin@example.com', 'hash19', 'Benjamin Young', '1011121314', '1992-04-08', 'Male', 'men/9.jpg'),
('maggie_scott', 'maggie@example.com', 'hash20', 'Maggie Scott', '2122232425', '1991-01-29', 'Female', 'women/9.jpg');

-- THEATERS
INSERT INTO Theaters (Name, Location, Phone) VALUES
('Cineworld LA', 'Los Angeles', '555-1234'),
('Galaxy NY', 'New York', '555-5678'),
('Regal Cinemas', 'Chicago', '555-9876'),
('Film City', 'San Francisco', '555-4321'),
('MegaScreen Boston', 'Boston', '555-2468'),
('Starplex Houston', 'Houston', '555-1357'),
('Premier Movies', 'Seattle', '555-1122'),
('Grand Cinema Miami', 'Miami', '555-2233'),
('MovieLand Dallas', 'Dallas', '555-3344'),
('Skyline Theaters', 'Denver', '555-4455');


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

-- Generate Auditoriums A–E for Theaters 1 to 10
DECLARE @theaterId INT = 1

WHILE @theaterId <= 10
BEGIN
    INSERT INTO Auditoriums (TheaterID, Name, Capacity) VALUES
    (@theaterId, 'Auditorium A', 100 + (@theaterId * 5)),
    (@theaterId, 'Auditorium B', 120 + (@theaterId * 3)),
    (@theaterId, 'Auditorium C', 90 + (@theaterId * 4)),
    (@theaterId, 'Auditorium D', 150 + (@theaterId * 2)),
    (@theaterId, 'Auditorium E', 110 + (@theaterId * 6));

    SET @theaterId += 1
END

-- SEATS
SET NOCOUNT ON;

-- Generate seats A1 to K12 for Auditoriums 1 to 50
DECLARE @auditoriumId INT = 1
DECLARE @row CHAR(1)
DECLARE @seatNumber INT

WHILE @auditoriumId <= 50
BEGIN
    SET @row = 'A'
    
    WHILE ASCII(@row) <= ASCII('O')  -- Rows A to K
    BEGIN
        SET @seatNumber = 1
        
        WHILE @seatNumber <= 18  -- Seats 1 to 18
        BEGIN
            INSERT INTO Seats (AuditoriumID, RowLabel, SeatNumber)
            VALUES (@auditoriumId, @row, @seatNumber)

            SET @seatNumber += 1
        END

        SET @row = CHAR(ASCII(@row) + 1)
    END

    SET @auditoriumId += 1
END
SET NOCOUNT OFF;

-- DIRECTORS
INSERT INTO Directors (FullName, DateOfBirth, Biography, CountryID, ProfileImagePath) VALUES
('Christopher Nolan', '1970-07-30', 'Acclaimed British-American director known for cerebral blockbusters like Inception and The Dark Knight trilogy.', 2, 'christopher_nolan.png'),
('Steven Spielberg', '1946-12-18', 'Legendary American filmmaker behind iconic classics such as E.T., Jurassic Park, and Schindler’s List.', 1, 'steven_spielberg.png'),
('Quentin Tarantino', '1963-03-27', 'Renowned for stylized violence and nonlinear storytelling in films like Pulp Fiction and Django Unchained.', 1, 'quentin_tarantino.png'),
('Hayao Miyazaki', '1941-01-05', 'Visionary Japanese animator and co-founder of Studio Ghibli, known for Spirited Away and My Neighbor Totoro.', 4, 'hayao_miyazaki.png'),
('Bong Joon-ho', '1969-09-14', 'South Korean director of Parasite, blending social commentary with genre storytelling.', 10, 'bong_joon_ho.png'),
('Denis Villeneuve', '1967-10-03', 'Canadian director acclaimed for sci-fi epics like Arrival, Blade Runner 2049, and Dune.', 6, 'denis_villeneuve.png'),
('James Cameron', '1954-08-16', 'Canadian filmmaker known for groundbreaking visuals in Titanic and Avatar.', 6, 'james_cameron.png'),
('Martin Scorsese', '1942-11-17', 'American master of crime and drama, with classics like Goodfellas and The Irishman.', 1, 'martin_scorsese.png'),
('Greta Gerwig', '1983-08-04', 'American actress and filmmaker praised for Lady Bird, Little Women, and Barbie.', 1, 'greta_gerwig.png'),
('Taika Waititi', '1975-08-16', 'New Zealand director blending comedy and heart in films like Jojo Rabbit and Thor: Ragnarok.', 9, 'taika_waititi.png'),
('Alfonso Cuarón', '1961-11-28', 'Oscar-winning Mexican filmmaker known for Gravity, Roma, and Children of Men.', 1, 'alfonso_cuaron.png'),
('Ridley Scott', '1937-11-30', 'British director famous for genre-defining epics like Alien, Blade Runner, and Gladiator.', 2, 'ridley_scott.png'),
('Patty Jenkins', '1971-07-24', 'American director best known for Wonder Woman and Monster.', 1, 'patty_jenkins.png'),
('Wes Anderson', '1969-05-01', 'American filmmaker recognized for his whimsical style in The Grand Budapest Hotel and Moonrise Kingdom.', 1, 'wes_anderson.png'),
('Damien Chazelle', '1985-01-19', 'American director acclaimed for musical dramas like Whiplash and La La Land.', 1, 'damien_chazelle.png'),
('Jordan Peele', '1979-02-21', 'American filmmaker reshaping horror with Get Out, Us, and Nope.', 1, 'jordan_peele.png'),
('Chloé Zhao', '1982-03-31', 'Chinese director known for minimalist narratives like Nomadland and Eternals.', 7, 'chloe_zhao.png'),
('Peter Jackson', '1961-10-31', 'New Zealand filmmaker famed for The Lord of the Rings and Hobbit trilogies.', 9, 'peter_jackson.png'),
('Guillermo del Toro', '1964-10-09', 'Mexican director blending fantasy and horror in Pan’s Labyrinth and The Shape of Water.', 1, 'guillermo_del_toro.png'),
('George Miller', '1945-03-03', 'Australian director behind the Mad Max series and Babe.', 9, 'george_miller.png'),
('Francis Ford Coppola', '1939-04-07', 'American auteur behind the Godfather trilogy and Apocalypse Now.', 1, 'francis_ford_coppola.png'),
('Stanley Kubrick', '1928-07-26', 'Visionary American filmmaker of 2001: A Space Odyssey and The Shining.', 1, 'stanley_kubrick.png'),
('Tim Burton', '1958-08-25', 'American director noted for his gothic fantasy style in Edward Scissorhands and Beetlejuice.', 1, 'tim_burton.png'),
('Robert Zemeckis', '1952-05-14', 'American director best known for Back to the Future, Forrest Gump, and The Polar Express.', 1, 'robert_zemeckis.png'),
('Oliver Stone', '1946-09-15', 'American filmmaker known for politically charged films like Platoon and JFK.', 1, 'oliver_stone.png'),
('Ron Howard', '1954-03-01', 'American director with a diverse portfolio including A Beautiful Mind and Apollo 13.', 1, 'ron_howard.png'),
('Martin Campbell', '1943-10-24', 'British director of action films including Casino Royale and GoldenEye.', 2, 'martin_campbell.png'),
('James Wan', '1977-02-26', 'Australian director behind horror hits like Saw, The Conjuring, and Aquaman.', 6, 'james_wan.png'),
('Michael Bay', '1965-02-17', 'American director famed for explosive blockbusters like Transformers and Armageddon.', 1, 'michael_bay.png'),
('Sam Mendes', '1965-08-01', 'British director known for American Beauty and the James Bond films Skyfall and Spectre.', 2, 'sam_mendes.png'),
('M. Night Shyamalan', '1970-08-06', 'Indian-American filmmaker noted for twist endings in films like The Sixth Sense and Split.', 1, 'm_night_shyamalan.png'),
('David Fincher', '1962-08-28', 'American director acclaimed for thrillers like Fight Club, Se7en, and Gone Girl.', 1, 'david_fincher.png');


-- MOVIES
INSERT INTO Movies (Title, Description, DurationMinutes, RatingID, ReleaseDate, LanguageID, CountryID, DirectorID, PosterImagePath, WallpaperImagePath) 
VALUES
('Inception', 'Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: "inception", the implantation of another person''s idea into a target''s subconscious.', 148, 3, '2010-07-15', 1, 1, 1, 'inception.png', 'inception.png'),
('Interstellar', 'The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.', 169, 3, '2014-11-05', 1, 1, 1, 'interstellar.png', 'interstellar.png'),
('The Dark Knight', 'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.', 152, 3, '2008-07-16', 1, 1, 1, 'the_dark_knight.png', 'the_dark_knight.png'),
('Tenet', 'Armed with only one word - Tenet - and fighting for the survival of the entire world, the Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.', 150, 3, '2020-08-22', 1, 1, 1, 'tenet.png', 'tenet.png'),
('Dunkirk', 'A British Corporal in France finds himself responsible for the lives of his men when their officer is killed. He has to get them back to Britain somehow. Meanwhile, British civilians are being dragged into the war with Operation Dynamo, the scheme to get the French and British forces back from the Dunkirk beaches. Some come forward to help, others were less willing.', 134, 3, '1958-03-20', 1, 1, 1, 'dunkirk.png', 'dunkirk.png'),
('Jurassic Park', 'A wealthy entrepreneur secretly creates a theme park featuring living dinosaurs drawn from prehistoric DNA. Before opening day, he invites a team of experts and his two eager grandchildren to experience the park and help calm anxious investors. However, the park is anything but amusing as the security systems go off-line and the dinosaurs escape.', 127, 3, '1993-06-11', 1, 1, 2, 'jurassic_park.png', 'jurassic_park.png'),
('Schindler''s List', 'The true story of how businessman Oskar Schindler saved over a thousand Jewish lives from the Nazis while they worked as slaves in his factory during World War II.', 195, 3, '1993-12-15', 1, 1, 2, 'schindlers_list.png', 'schindlers_list.png'),
('Jaws', 'When the seaside community of Amity finds itself under attack by a dangerous great white shark, the town''s chief of police, a young marine biologist, and a grizzled hunter embark on a desperate quest to destroy the beast before it strikes again.', 124, 3, '1975-06-20', 1, 1, 2, 'jaws.png', 'jaws.png'),
('Saving Private Ryan', 'As U.S. troops storm the beaches of Normandy, three brothers lie dead on the battlefield, with a fourth trapped behind enemy lines. Ranger captain John Miller and seven men are tasked with penetrating German-held territory and bringing the boy home.', 169, 3, '1998-07-24', 1, 1, 2, 'saving_private_ryan.png', 'saving_private_ryan.png'),
('Pulp Fiction', 'A burger-loving hit man, his philosophical partner, a drug-addled gangster''s moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.', 154, 4, '1994-09-10', 1, 1, 3, 'pulp_fiction.png', 'pulp_fiction.png'),
('Django Unchained', 'With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.', 165, 4, '2012-12-25', 1, 1, 3, 'django_unchained.png', 'django_unchained.png'),
('Inglourious Basterds', 'In Nazi-occupied France during World War II, a group of Jewish-American soldiers known as "The Basterds" are chosen specifically to spread fear throughout the Third Reich by scalping and brutally killing Nazis. The Basterds, lead by Lt. Aldo Raine soon cross paths with a French-Jewish teenage girl who runs a movie theater in Paris which is targeted by the soldiers.', 153, 4, '2009-08-02', 1, 1, 3, 'inglourious_basterds.png', 'inglourious_basterds.png'),
('Spirited Away', 'A young girl, Chihiro, becomes trapped in a strange new world of spirits. When her parents undergo a mysterious transformation, she must call upon the courage she never knew she had to free her family.', 125, 1, '2001-07-20', 3, 4, 4, 'spirited_away.png', 'spirited_away.png'),
('My Neighbor Totoro', 'Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.', 86, 1, '1988-04-16', 3, 4, 4, 'my_neighbor_totoro.png', 'my_neighbor_totoro.png'),
('Howl''s Moving Castle', 'Sophie, a young milliner, is turned into an elderly woman by a witch who enters her shop and curses her. She encounters a wizard named Howl and gets caught up in his resistance to fighting for the king.', 119, 1, '2004-09-09', 3, 4, 4, 'howls_moving_castle.png', 'howls_moving_castle.png'),
('Princess Mononoke', 'Ashitaka, a prince of the disappearing Emishi people, is cursed by a demonized boar god and must journey to the west to find a cure. Along the way, he encounters San, a young human woman fighting to protect the forest, and Lady Eboshi, who is trying to destroy it. Ashitaka must find a way to bring balance to this conflict.', 134, 1, '1997-07-12', 3, 4, 4, 'princess_mononoke.png', 'princess_mononoke.png'),
('Parasite', 'Paul Dean has created a deadly parasite that is now attached to his stomach. He and his female companion, Patricia Welles, must find a way to destroy it while also trying to avoid Ricus & his rednecks, and an evil government agent named Merchant.', 85, 4, '1982-03-12', 5, 10, 5, 'parasite.png', 'parasite.png'),
('Snowpiercer', 'In a future where a failed global-warming experiment kills off most life on the planet, a class system evolves aboard the Snowpiercer; a train that travels around the globe via a perpetual-motion engine.', 127, 4, '2013-08-01', 1, 1, 5, 'snowpiercer.png', 'snowpiercer.png'),
('The Host', 'A parasitic alien soul is injected into the body of Melanie Stryder. Instead of carrying out her race''s mission of taking over the Earth, "Wanda" (as she comes to be called) forms a bond with her host and sets out to aid other free humans.', 125, 4, '2013-03-22', 5, 10, 5, 'the_host.png', 'the_host.png'),
('Memories of Murder', 'During the late 1980s, two detectives in a South Korean province attempt to solve the nation''s first series of rape-and-murder cases.', 131, 4, '2003-04-25', 5, 10, 5, 'memories_of_murder.png', 'memories_of_murder.png'),
('Okja', 'A young girl named Mija risks everything to prevent a powerful, multi-national company from kidnapping her best friend - a massive animal named Okja.', 122, 4, '2017-06-28', 1, 1, 5, 'okja.png', 'okja.png'),
('Dune', 'Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet''s exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity''s greatest potential-only those who can conquer their fear will survive.', 155, 4, '2021-09-15', 1, 1, 6, 'dune.png', 'dune.png'),
('Arrival', 'Taking place after alien crafts land around the world, an expert linguist is recruited by the military to determine whether they come in peace or are a threat.', 116, 4, '2016-11-10', 1, 1, 6, 'arrival.png', 'arrival.png'),
('Blade Runner 2049', 'Thirty years after the events of the first film, a new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what''s left of society into chaos. K''s discovery leads him on a quest to find Rick Deckard, a former LAPD blade runner who has been missing for 30 years.', 164, 4, '2017-10-04', 1, 1, 6, 'blade_runner_2049.png', 'blade_runner_2049.png'),
('Prisoners', 'Keller Dover is facing every parent’s worst nightmare. His six-year-old daughter, Anna, is missing, together with her young friend, Joy, and as minutes turn to hours, panic sets in. The only lead is a dilapidated RV that had earlier been parked on their street.', 153, 4, '2013-09-19', 1, 1, 6, 'prisoners.png', 'prisoners.png'),
('Sicario', 'An idealistic FBI agent is enlisted by a government task force to aid in the escalating war against drugs at the border area between the U.S. and Mexico.', 122, 4, '2015-09-17', 1, 1, 6, 'sicario.png', 'sicario.png'),
('Titanic', '101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later. A young Rose boards the ship with her mother and fiancé. Meanwhile, Jack Dawson and Fabrizio De Rossi win third-class tickets aboard the ship. Rose tells the whole story from Titanic''s departure through to its death—on its first and last voyage—on April 15, 1912.', 194, 3, '1997-11-18', 1, 1, 7, 'titanic.png', 'titanic.png'),
('Avatar', 'In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.', 162, 3, '2009-12-15', 1, 1, 7, 'avatar.png', 'avatar.png'),
('Terminator 2: Judgment Day', 'Set ten years after the events of the original, James Cameron’s classic sci-fi action flick tells the story of a second attempt to get rid of rebellion leader John Connor, this time targeting the boy himself. However, the rebellion has sent a reprogrammed terminator to protect Connor.', 137, 4, '1991-07-03', 1, 1, 7, 'terminator_2_judgment_day.png', 'terminator_2_judgment_day.png'),
('Aliens', 'Ripley, the sole survivor of the Nostromo''s deadly encounter with the monstrous Alien, returns to Earth after drifting through space in hypersleep for 57 years. Although her story is initially met with skepticism, she agrees to accompany a team of Colonial Marines back to LV-426.', 137, 4, '1986-07-18', 1, 1, 7, 'aliens.png', 'aliens.png'),
('The Abyss', 'A civilian oil rig crew is recruited to conduct a search and rescue effort when a nuclear submarine mysteriously sinks. One diver soon finds himself on a spectacular odyssey 25,000 feet below the ocean''s surface where he confronts a mysterious force that has the power to change the world or destroy it.', 140, 4, '1989-08-09', 1, 1, 7, 'the_abyss.png', 'the_abyss.png'),
('GoodFellas', 'The true story of Henry Hill, a half-Irish, half-Sicilian Brooklyn kid who is adopted by neighbourhood gangsters at an early age and climbs the ranks of a Mafia family under the guidance of Jimmy Conway.', 145, 4, '1990-09-12', 1, 1, 8, 'goodfellas.png', 'goodfellas.png'),
('The Wolf of Wall Street', 'A New York stockbroker refuses to cooperate in a large securities fraud case involving corruption on Wall Street, corporate banking world and mob infiltration. Based on Jordan Belfort''s autobiography.', 180, 4, '2013-12-25', 1, 1, 8, 'the_wolf_of_wall_street.png', 'the_wolf_of_wall_street.png'),
('The Irishman', 'Pennsylvania, 1956. Frank Sheeran, a war veteran of Irish origin who works as a truck driver, accidentally meets mobster Russell Bufalino. Once Frank becomes his trusted man, Bufalino sends him to Chicago with the task of helping Jimmy Hoffa, a powerful union leader related to organized crime, with whom Frank will maintain a close friendship for nearly twenty years.', 209, 4, '2019-11-01', 1, 1, 8, 'the_irishman.png', 'the_irishman.png'),
('Taxi Driver', 'A mentally unstable Vietnam War veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feed his urge for violent action.', 114, 4, '1976-02-09', 1, 1, 8, 'taxi_driver.png', 'taxi_driver.png'),
('Casino', 'In early-1970s Las Vegas, Sam "Ace" Rothstein gets tapped by his bosses to head the Tangiers Casino. At first, he''s a great success in the job, but over the years, problems with his loose-cannon enforcer Nicky Santoro, his ex-hustler wife Ginger, her con-artist ex Lester Diamond and a handful of corrupt politicians put Sam in ever-increasing danger.', 179, 4, '1995-11-22', 1, 1, 8, 'casino.png', 'casino.png'),
('Lady Bird', 'Lady Bird McPherson, a strong willed, deeply opinionated, artistic 17 year old comes of age in Sacramento. Her relationship with her mother and her upbringing are questioned and tested as she plans to head off to college.', 94, 4, '2017-09-01', 1, 1, 9, 'lady_bird.png', 'lady_bird.png'),
('Little Women', 'Four sisters come of age in America in the aftermath of the Civil War.', 135, 4, '2019-12-25', 1, 1, 9, 'little_women.png', 'little_women.png'),
('Barbie', 'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.', 114, 3, '2023-07-19', 1, 1, 9, 'barbie.png', 'barbie.png'),
('Jojo Rabbit', 'A World War II satire that follows a lonely German boy whose world view is turned upside down when he discovers his single mother is hiding a young Jewish girl in their attic. Aided only by his idiotic imaginary friend, Adolf Hitler, Jojo must confront his blind nationalism.', 108, 3, '2019-10-18', 1, 9, 10, 'jojo_rabbit.png', 'jojo_rabbit.png'),
('Thor: Ragnarok', 'Thor is imprisoned on the other side of the universe and finds himself in a race against time to get back to Asgard to stop Ragnarok, the destruction of his home-world and the end of Asgardian civilization, at the hands of a powerful new threat, the ruthless Hela.', 131, 3, '2017-10-02', 1, 1, 10, 'thor_ragnarok.png', 'thor_ragnarok.png'),
('Hunt for the Wilderpeople', 'Ricky is a defiant young city kid who finds himself on the run with his cantankerous foster uncle in the wild New Zealand bush. A national manhunt ensues, and the two are forced to put aside their differences and work together to survive.', 101, 3, '2016-03-31', 1, 9, 10, 'hunt_for_the_wilderpeople.png', 'hunt_for_the_wilderpeople.png'),
('What We Do in the Shadows', 'Vampire housemates try to cope with the complexities of modern life and show a newly turned hipster some of the perks of being undead.', 86, 3, '2014-06-19', 1, 9, 10, 'what_we_do_in_the_shadows.png', 'what_we_do_in_the_shadows.png'),
('Roma', 'In 1970s Mexico City, two domestic workers help a mother of four while her husband is away for an extended period of time.', 135, 3, '2018-11-21', 1, 1, 11, 'roma.png', 'roma.png'),
('Gravity', 'Dr. Ryan Stone, a brilliant medical engineer on her first Shuttle mission, with veteran astronaut Matt Kowalsky in command of his last flight before retiring. But on a seemingly routine spacewalk, disaster strikes. The Shuttle is destroyed, leaving Stone and Kowalsky completely alone-tethered to nothing but each other and spiraling out into the blackness of space. The deafening silence tells them they have lost any link to Earth and any chance for rescue. As fear turns to panic, every gulp of air eats away at what little oxygen is left. But the only way home may be to go further out into the terrifying expanse of space.', 91, 3, '2013-10-03', 1, 1, 11, 'gravity.png', 'gravity.png'),
('Children of Men', 'In 2027, in a chaotic world in which humans can no longer procreate, a former activist agrees to help transport a miraculously pregnant woman to a sanctuary at sea, where her child''s birth may help scientists save the future of humankind.', 109, 4, '2006-09-22', 1, 1, 11, 'children_of_men.png', 'children_of_men.png'),
('Harry Potter and the Prisoner of Azkaban', 'Year three at Hogwarts means new fun and challenges as Harry learns the delicate art of approaching a Hippogriff, transforming shape-shifting Boggarts into hilarity and even turning back time. But the term also brings danger: soul-sucking Dementors hover over the school, an ally of the accursed He-Who-Cannot-Be-Named lurks within the castle walls, and fearsome wizard Sirius Black escapes Azkaban. And Harry will confront them all.', 141, 3, '2004-05-31', 1, 1, 11, 'harry_potter_and_the_prisoner_of_azkaban.png', 'harry_potter_and_the_prisoner_of_azkaban.png'),
('Blade Runner', 'In the smog-choked dystopian Los Angeles of 2019, blade runner Rick Deckard is called out of retirement to terminate a quartet of replicants who have escaped to Earth seeking their creator for a way to extend their short life spans.', 118, 4, '1982-06-25', 1, 1, 12, 'blade_runner.png', 'blade_runner.png'),
('Gladiator', 'Tommy Riley has moved with his dad to Chicago from a ''nice place''. He keeps to himself, goes to school. However, after a street fight he is noticed and quickly falls into the world of illegal underground boxing - where punches can kill.', 101, 4, '1992-03-06', 1, 1, 12, 'gladiator.png', 'gladiator.png'),
('Alien', 'During its return to the earth, commercial spaceship Nostromo intercepts a distress signal from a distant planet. When a three-member team of the crew discovers a chamber containing thousands of eggs on the planet, a creature inside one of the eggs attacks an explorer. The entire crew is unaware of the impending nightmare set to descend upon them when the alien parasite planted inside its unfortunate host is birthed.', 117, 4, '1979-05-25', 1, 1, 12, 'alien.png', 'alien.png'),
('The Martian', 'During a manned mission to Mars, Astronaut Mark Watney is presumed dead after a fierce storm and left behind by his crew. But Watney has survived and finds himself stranded and alone on the hostile planet. With only meager supplies, he must draw upon his ingenuity, wit and spirit to subsist and find a way to signal to Earth that he is alive.', 141, 4, '2015-09-30', 1, 1, 12, 'the_martian.png', 'the_martian.png'),
('Black Hawk Down', 'When U.S. Rangers and an elite Delta Force team attempt to kidnap two underlings of a Somali warlord, their Black Hawk helicopters are shot down, and the Americans suffer heavy casualties, facing intense fighting from the militia on the ground.', 145, 4, '2001-12-28', 1, 1, 12, 'black_hawk_down.png', 'black_hawk_down.png'),
('Wonder Woman', 'An Amazon princess comes to the world of Man in the grips of the First World War to confront the forces of evil and bring an end to human conflict.', 141, 3, '2017-05-30', 1, 1, 13, 'wonder_woman.png', 'wonder_woman.png'),
('Wonder Woman 1984', 'A botched store robbery places Wonder Woman in a global battle against a powerful and mysterious ancient force that puts her powers in jeopardy.', 151, 3, '2020-12-16', 1, 1, 13, 'wonder_woman_1984.png', 'wonder_woman_1984.png'),
('Monster', 'The story of Steve Harmon, a 17-year-old honor student whose world comes crashing down around him when he is charged with felony murder.', 98, 4, '2021-07-15', 1, 1, 13, 'monster.png', 'monster.png'),
('The Grand Budapest Hotel', 'The Grand Budapest Hotel tells of a legendary concierge at a famous European hotel between the wars and his friendship with a young employee who becomes his trusted protégé. The story involves the theft and recovery of a priceless Renaissance painting, the battle for an enormous family fortune and the slow and then sudden upheavals that transformed Europe during the first half of the 20th century.', 100, 3, '2014-02-26', 1, 1, 14, 'the_grand_budapest_hotel.png', 'the_grand_budapest_hotel.png'),
('Moonrise Kingdom', 'Set on an island off the coast of New England in the summer of 1965, Moonrise Kingdom tells the story of two twelve-year-olds who fall in love, make a secret pact, and run away together into the wilderness. As various authorities try to hunt them down, a violent storm is brewing off-shore – and the peaceful island community is turned upside down in more ways than anyone can handle.', 94, 3, '2012-05-16', 1, 1, 14, 'moonrise_kingdom.png', 'moonrise_kingdom.png'),
('Fantastic Mr. Fox', 'The Fantastic Mr. Fox, bored with his current life, plans a heist against the three local farmers. The farmers, tired of sharing their chickens with the sly fox, seek revenge against him and his family.', 87, 3, '2009-10-14', 1, 1, 14, 'fantastic_mr_fox.png', 'fantastic_mr_fox.png'),
('The Royal Tenenbaums', 'Royal Tenenbaum and his wife Etheline had three children and then they separated. All three children are extraordinary --- all geniuses. Virtually all memory of the brilliance of the young Tenenbaums was subsequently erased by two decades of betrayal, failure, and disaster. Most of this was generally considered to be their father''s fault. "The Royal Tenenbaums" is the story of the family''s sudden, unexpected reunion one recent winter.', 110, 3, '2001-10-05', 1, 1, 14, 'the_royal_tenenbaums.png', 'the_royal_tenenbaums.png'),
('Isle of Dogs', 'In the future, an outbreak of canine flu leads the mayor of a Japanese city to banish all dogs to an island used as a garbage dump. The outcasts must soon embark on an epic journey when a 12-year-old boy arrives on the island to find his beloved pet.', 101, 3, '2018-03-23', 1, 1, 14, 'isle_of_dogs.png', 'isle_of_dogs.png'),
('La La Land', 'Mia, an aspiring actress, serves lattes to movie stars in between auditions and Sebastian, a jazz musician, scrapes by playing cocktail party gigs in dingy bars, but as success mounts they are faced with decisions that begin to fray the fragile fabric of their love affair, and the dreams they worked so hard to maintain in each other threaten to rip them apart.', 129, 3, '2016-12-01', 1, 1, 15, 'la_la_land.png', 'la_la_land.png'),
('Whiplash', 'Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.', 107, 4, '2014-10-10', 1, 1, 15, 'whiplash.png', 'whiplash.png'),
('First Man', 'A look at the life of the astronaut, Neil Armstrong, and the legendary space mission that led him to become the first man to walk on the Moon on July 20, 1969.', 141, 3, '2018-10-10', 1, 1, 15, 'first_man.png', 'first_man.png'),
('Babylon', 'A tale of outsized ambition and outrageous excess, tracing the rise and fall of multiple characters in an era of unbridled decadence and depravity during Hollywood''s transition from silent films to sound films in the late 1920s.', 189, 4, '2022-12-22', 1, 1, 15, 'babylon.png', 'babylon.png'),
('Get Out', 'Chris and his girlfriend Rose go upstate to visit her parents for the weekend. At first, Chris reads the family''s overly accommodating behavior as nervous attempts to deal with their daughter''s interracial relationship, but as the weekend progresses, a series of increasingly disturbing discoveries lead him to a truth that he never could have imagined.', 104, 4, '2017-02-24', 1, 1, 16, 'get_out.png', 'get_out.png'),
('Us', 'Husband and wife Gabe and Adelaide Wilson take their kids to their beach house expecting to unplug and unwind with friends. But as night descends, their serenity turns to tension and chaos when some shocking visitors arrive uninvited.', 116, 4, '2019-03-14', 1, 1, 16, 'us.png', 'us.png'),
('Nope', 'Residents in a lonely gulch of inland California bear witness to an uncanny, chilling discovery.', 130, 4, '2022-07-20', 1, 1, 16, 'nope.png', 'nope.png'),
('Nomadland', 'A woman in her sixties embarks on a journey through the western United States after losing everything in the Great Recession, living as a van-dwelling modern-day nomad.', 108, 3, '2021-01-29', 1, 1, 17, 'nomadland.png', 'nomadland.png'),
('The Rider', 'Once a rising star of the rodeo circuit, and a gifted horse trainer, young cowboy Brady is warned that his riding days are over after a horse crushed his skull at a rodeo. In an attempt to regain control of his own fate, Brady undertakes a search for a new identity and what it means to be a man in the heartland of the United States.', 103, 3, '2018-03-28', 1, 1, 17, 'the_rider.png', 'the_rider.png'),
('Eternals', 'The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.', 156, 3, '2021-11-03', 1, 1, 17, 'eternals.png', 'eternals.png'),
('King Kong', 'Adventurous filmmaker Carl Denham sets out to produce a motion picture unlike anything the world has seen before. Alongside his leading lady Ann Darrow and his first mate Jack Driscoll, they arrive on an island and discover a legendary creature said to be neither beast nor man. Denham captures the monster to be displayed on Broadway as King Kong, the eighth wonder of the world.', 104, 3, '1933-03-15', 1, 1, 18, 'king_kong.png', 'king_kong.png'),
('Heavenly Creatures', 'Precocious teenager Juliet moves to New Zealand with her family and soon befriends the quiet, brooding Pauline through their shared love of fantasy and literature. This friendship gradually develops into an intense and obsessive bond.', 109, 4, '1994-09-12', 1, 1, 18, 'heavenly_creatures.png', 'heavenly_creatures.png'),
('Pan''s Labyrinth', 'Living with her tyrannical stepfather in a new home with her pregnant mother, 10-year-old Ofelia feels alone until she explores a decaying labyrinth guarded by a mysterious faun who claims to know her destiny. If she wishes to return to her real father, Ofelia must complete three terrifying tasks.', 118, 4, '2006-10-11', 1, 1, 19, 'pans_labyrinth.png', 'pans_labyrinth.png'),
('The Shape of Water', 'An other-worldly story, set against the backdrop of Cold War era America circa 1962, where a mute janitor working at a lab falls in love with an amphibious man being held captive there and devises a plan to help him escape.', 123, 4, '2017-12-01', 1, 1, 19, 'the_shape_of_water.png', 'the_shape_of_water.png'),
('Crimson Peak', 'In the aftermath of a family tragedy, an aspiring author is torn between love for her childhood friend and the temptation of a mysterious outsider. Trying to escape the ghosts of her past, she is swept away to a house that breathes, bleeds… and remembers.', 118, 4, '2015-10-13', 1, 1, 19, 'crimson_peak.png', 'crimson_peak.png'),
('Hellboy', 'In the final days of World War II, the Nazis attempt to use black magic to aid their dying cause. The Allies raid the camp where the ceremony is taking place, but not before they summon a baby demon who is rescued by Allied forces and dubbed "Hellboy". Sixty years later, Hellboy serves the cause of good rather than evil as an agent in the Bureau of Paranormal Research & Defense, along with Abe Sapien - a merman with psychic powers, and Liz Sherman - a woman with pyrokinesis, protecting America against dark forces.', 122, 4, '2004-04-02', 1, 1, 19, 'hellboy.png', 'hellboy.png'),
('Nightmare Alley', 'An ambitious carnival man with a talent for manipulating people with a few well-chosen words hooks up with a female psychologist who is even more dangerous than he is.', 150, 4, '2021-12-02', 1, 1, 19, 'nightmare_alley.png', 'nightmare_alley.png'),
('Mad Max: Fury Road', 'An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order.', 121, 4, '2015-05-13', 1, 9, 20, 'mad_max_fury_road.png', 'mad_max_fury_road.png'),
('Mad Max 2', 'Max Rockatansky returns as the heroic loner who drives the dusty roads of a postapocalyptic Australian Outback in an unending search for gasoline. Arrayed against him and the other scraggly defendants of a fuel-depot encampment are the bizarre warriors commanded by the charismatic Lord Humungus, a violent leader whose scruples are as barren as the surrounding landscape.', 96, 4, '1981-12-24', 1, 9, 20, 'mad_max_2.png', 'mad_max_2.png'),
('Babe', 'Babe is a little pig who doesn''t quite know his place in the world. With a bunch of odd friends, like Ferdinand the duck who thinks he is a rooster and Fly the dog he calls mum, Babe realises that he has the makings to become the greatest sheep pig of all time, and Farmer Hoggett knows it. With the help of the sheep dogs, Babe learns that a pig can be anything that he wants to be.', 92, 3, '1995-07-18', 1, 9, 20, 'babe.png', 'babe.png'),
('Happy Feet', 'Into the world of the Emperor Penguins, who find their soul mates through song, a penguin is born who cannot sing. But he can tap dance something fierce!', 108, 3, '2006-11-16', 1, 9, 20, 'happy_feet.png', 'happy_feet.png'),
('Apocalypse Now', 'At the height of the Vietnam war, Captain Benjamin Willard is sent on a dangerous mission that, officially, "does not exist, nor will it ever exist." His goal is to locate - and eliminate - a mysterious Green Beret Colonel named Walter Kurtz, who has been leading his personal army on illegal guerrilla missions into enemy territory.', 147, 4, '1979-05-19', 1, 1, 21, 'apocalypse_now.png', 'apocalypse_now.png'),
('The Conversation', 'Based on a true story of a meeting in June 1945 between two powerful men with very opposite philosophies and perspectives on the future of their country.', 108, 4, '2022-04-28', 1, 1, 21, 'the_conversation.png', 'the_conversation.png'),
('Dracula', 'Romanticized adaptation of Bram Stoker''s 1897 classic. Count Dracula is a subject of fatal attraction to more than one English maiden lady, as he seeks an immortal bride.', 109, 4, '1979-07-20', 1, 1, 21, 'dracula.png', 'dracula.png'),
('2001: A Space Odyssey', 'Humanity finds a mysterious object buried beneath the lunar surface and sets off to find its origins with the help of HAL 9000, the world''s most advanced super computer.', 149, 3, '1968-04-02', 1, 1, 22, '2001_a_space_odyssey.png', '2001_a_space_odyssey.png'),
('The Shining', 'Jack Torrance accepts a caretaker job at the Overlook Hotel, where he, along with his wife Wendy and their son Danny, must live isolated from the rest of the world for the winter. But they aren''t prepared for the madness that lurks within.', 144, 4, '1980-05-23', 1, 1, 22, 'the_shining.png', 'the_shining.png'),
('A Clockwork Orange', 'In a near-future Britain, young Alexander DeLarge and his pals get their kicks beating and raping anyone they please. When not destroying the lives of others, Alex swoons to the music of Beethoven. The state, eager to crack down on juvenile crime, gives an incarcerated Alex the option to undergo an invasive procedure that''ll rob him of all personal agency. In a time when conscience is a commodity, can Alex change his tune?', 137, 4, '1971-12-19', 1, 1, 22, 'a_clockwork_orange.png', 'a_clockwork_orange.png'),
('Full Metal Jacket', 'A pragmatic U.S. Marine observes the dehumanizing effects the U.S.-Vietnam War has on his fellow recruits from their brutal boot camp training to the bloody street fighting in Hue.', 117, 4, '1987-06-26', 1, 1, 22, 'full_metal_jacket.png', 'full_metal_jacket.png'),
('Eyes Wide Shut', 'After Dr. Bill Harford''s wife, Alice, admits to having sexual fantasies about a man she met, Bill becomes obsessed with having a sexual encounter. He discovers an underground sexual group and attends one of their meetings -- and quickly discovers that he is in over his head.', 159, 4, '1999-07-16', 1, 1, 22, 'eyes_wide_shut.png', 'eyes_wide_shut.png'),
('Edward Scissorhands', 'A small suburban town receives a visit from a castaway unfinished science experiment named Edward.', 105, 3, '1990-12-07', 1, 1, 23, 'edward_scissorhands.png', 'edward_scissorhands.png'),
('Beetlejuice', 'A newly dead New England couple seeks help from a deranged demon exorcist to scare an affluent New York family out of their home.', 92, 3, '1988-03-30', 1, 1, 23, 'beetlejuice.png', 'beetlejuice.png'),
('Batman', 'Japanese master spy Daka operates a covert espionage-sabotage organization located in Gotham City''s now-deserted Little Tokyo, which turns American scientists into pliable zombies. The great crime-fighters Batman and Robin, with the help of their allies, are in pursuit.', 260, 3, '1943-07-16', 1, 1, 23, 'batman.png', 'batman.png'),
('Corpse Bride', 'In a 19th-century European village, a young man about to be married is whisked away to the underworld and wed to a mysterious corpse bride, while his real bride waits bereft in the land of the living.', 77, 3, '2005-09-12', 1, 1, 23, 'corpse_bride.png', 'corpse_bride.png'),
('Big Fish', 'Throughout his life Edward Bloom has always been a man of big appetites, enormous passions and tall tales. In his later years, he remains a huge mystery to his son, William. Now, to get to know the real man, Will begins piecing together a true picture of his father from flashbacks of his amazing adventures.', 125, 3, '2003-12-25', 1, 1, 23, 'big_fish.png', 'big_fish.png'),
('Forrest Gump', 'A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.', 142, 3, '1994-06-23', 1, 1, 24, 'forrest_gump.png', 'forrest_gump.png'),
('Cast Away', 'Chuck Nolan, a top international manager for FedEx, and Kelly, a Ph.D. student, are in love and heading towards marriage. Then Chuck''s plane to Malaysia crashes at sea during a terrible storm. He''s the only survivor, and finds himself marooned on a desolate island. With no way to escape, Chuck must find ways to survive in his new home.', 143, 3, '2000-12-22', 1, 1, 24, 'cast_away.png', 'cast_away.png'),
('The Polar Express', 'When a doubting young boy takes an extraordinary train ride to the North Pole, he embarks on a journey of self-discovery that shows him that the wonder of life never fades for those who believe.', 100, 3, '2004-11-10', 1, 1, 24, 'the_polar_express.png', 'the_polar_express.png'),
('Platoon', 'As a young and naive recruit in Vietnam, Chris Taylor faces a moral crisis when confronted with the horrors of war and the duality of man.', 120, 4, '1986-12-19', 1, 1, 25, 'platoon.png', 'platoon.png'),
('JFK', 'Follows the investigation into the assassination of President John F. Kennedy led by New Orleans district attorney Jim Garrison.', 188, 4, '1991-12-20', 1, 1, 25, 'jfk.png', 'jfk.png'),
('Born on the Fourth of July', 'Paralyzed in the Vietnam war, Ron Kovic becomes an anti-war and pro-human rights political activist after feeling betrayed by the country he fought for.', 145, 4, '1989-12-20', 1, 1, 25, 'born_on_the_fourth_of_july.png', 'born_on_the_fourth_of_july.png'),
('Natural Born Killers', 'Two victims of traumatized childhoods become lovers and serial murderers irresponsibly glorified by the mass media.', 118, 4, '1994-08-26', 1, 1, 25, 'natural_born_killers.png', 'natural_born_killers.png'),
('A Beautiful Mind', 'From the heights of notoriety to the depths of depravity, John Forbes Nash Jr. experiences it all. As a brilliant but socially awkward mathematician, he made a groundbreaking discovery early in his career and stands on the brink of international acclaim. But as the handsome and arrogant Nash accepts secret work in cryptography, he becomes entangled in a mysterious conspiracy. His life takes a nightmarish turn and he soon finds himself on a painful and harrowing journey of self-discovery.', 135, 3, '2001-12-14', 1, 1, 26, 'a_beautiful_mind.png', 'a_beautiful_mind.png'),
('Apollo 13', 'The true story of technical troubles that scuttle the Apollo 13 lunar mission in 1970, risking the lives of astronaut Jim Lovell and his crew, with the failed journey turning into a thrilling saga of heroism. Drifting more than 200,000 miles from Earth, the astronauts work furiously with the ground crew to avert tragedy.', 140, 3, '1995-06-30', 1, 1, 26, 'apollo_13.png', 'apollo_13.png'),
('Rush', 'In the 1970s, a rivalry propels race car drivers Niki Lauda and James Hunt to fame and glory — until a horrible accident threatens to end it all.', 123, 4, '2013-09-02', 1, 1, 26, 'rush.png', 'rush.png'),
('The Da Vinci Code', 'A murder in Paris’ Louvre Museum and cryptic clues in some of Leonardo da Vinci’s most famous paintings lead to the discovery of a religious mystery. For 2,000 years a secret society closely guards information that — should it come to light — could rock the very foundations of Christianity.', 149, 3, '2006-05-17', 1, 1, 26, 'the_da_vinci_code.png', 'the_da_vinci_code.png'),
('Cinderella Man', 'The true story of boxer Jim Braddock who, following his retirement in the 1930s, makes a surprise comeback in order to lift his family out of poverty.', 144, 3, '2005-06-02', 1, 1, 26, 'cinderella_man.png', 'cinderella_man.png'),
('Casino Royale', 'Le Chiffre, a banker to the world''s terrorists, is scheduled to participate in a high-stakes poker game in Montenegro, where he intends to use his winnings to establish his financial grip on the terrorist market. M sends Bond—on his maiden mission as a 00 Agent—to attend this game and prevent Le Chiffre from winning. With the help of Vesper Lynd and Felix Leiter, Bond enters the most important poker game in his already dangerous career.', 144, 4, '2006-11-14', 1, 1, 27, 'casino_royale.png', 'casino_royale.png'),
('GoldenEye', 'When a powerful satellite system falls into the hands of Alec Trevelyan, AKA Agent 006, a former ally-turned-enemy, only James Bond can save the world from a dangerous space weapon that -- in one short pulse -- could destroy the earth! As Bond squares off against his former compatriot, he also battles Xenia Onatopp, an assassin who uses pleasure as her ultimate weapon.', 130, 4, '1995-11-16', 1, 1, 27, 'goldeneye.png', 'goldeneye.png'),
('The Mask of Zorro', 'It has been twenty years since Don Diego de la Vega fought Spanish oppression in Alta California as the legendary romantic hero, Zorro. Having escaped from prison he transforms troubled bandit Alejandro into his successor, in order to foil the plans of the tyrannical Don Rafael Montero who robbed him of his freedom, his wife and his precious daughter.', 136, 3, '1998-07-16', 1, 1, 27, 'the_mask_of_zorro.png', 'the_mask_of_zorro.png'),
('The Foreigner', 'This story is about a freelance agent who is the courier of a package from France to Germany. He soon finds that many people want to get their hands on it.', 95, 4, '2003-06-01', 1, 1, 27, 'the_foreigner.png', 'the_foreigner.png'),
('Edge of Darkness', 'The film pivots around the local Norwegian doctor and his family. The doctor''s wife (Ruth Gordon) wants to hold on to the pretence of gracious living and ignore their German occupiers. The doctor, Martin Stensgard (Walter Huston), would also prefer to stay neutral, but is torn. His brother-in-law, the wealthy owner of the local fish cannery, collaborates with the Nazis. The doctor''s daughter, Karen (Ann Sheridan), is involved with the resistance and with its leader Gunnar Brogge (Errol Flynn). The doctor''s son has just returned to town, having been sent down from the university, and is soon influenced by his Nazi-sympathizer uncle. Captain Koenig (Helmut Dantine), the young German commandant of the occupying garrison, whose fanatic determination to do everything by the book and spoutings about the invincibility of the Reich hides a growing fear of a local uprising.', 119, 4, '1943-04-09', 1, 1, 27, 'edge_of_darkness.png', 'edge_of_darkness.png'),
('Saw', 'David, an orderly at a hospital, tells his horrific story of being kidnapped and forced to play a vile game of survival.', 10, 4, '2003-10-16', 1, 1, 28, 'saw.png', 'saw.png'),
('The Conjuring', 'Paranormal investigators Ed and Lorraine Warren work to help a family terrorized by a dark presence in their farmhouse. Forced to confront a powerful entity, the Warrens find themselves caught in the most terrifying case of their lives.', 112, 4, '2013-07-18', 1, 1, 28, 'the_conjuring.png', 'the_conjuring.png'),
('Insidious', 'A family discovers that dark spirits have invaded their home after their son inexplicably falls into an endless sleep. When they reach out to a professional for help, they learn things are a lot more personal than they thought.', 102, 4, '2011-03-31', 1, 1, 28, 'insidious.png', 'insidious.png'),
('Aquaman', 'A young twenty-something diver living in the Florida Keys discovers he has the power to breathe underwater.', 42, 3, '2006-07-24', 1, 1, 28, 'aquaman.png', 'aquaman.png'),
('Furious 7', 'Deckard Shaw seeks revenge against Dominic Toretto and his family for his comatose brother.', 137, 3, '2015-04-01', 1, 1, 28, 'furious_7.png', 'furious_7.png'),
('Armageddon', 'When an asteroid threatens to collide with Earth, NASA honcho Dan Truman determines the only way to stop it is to drill into its surface and detonate a nuclear bomb. This leads him to renowned driller Harry Stamper, who agrees to helm the dangerous space mission provided he can bring along his own hotshot crew. Among them is the cocksure A.J. who Harry thinks isn''t good enough for his daughter, until the mission proves otherwise.', 151, 3, '1998-07-01', 1, 1, 29, 'armageddon.png', 'armageddon.png'),
('Bad Boys', 'Marcus Burnett is a henpecked family man. Mike Lowrey is a footloose and fancy free ladies'' man. Both Miami policemen, they have 72 hours to reclaim a consignment of drugs stolen from under their station''s nose. To complicate matters, in order to get the assistance of the sole witness to a murder, they have to pretend to be each other.', 119, 3, '1995-04-07', 1, 1, 29, 'bad_boys.png', 'bad_boys.png'),
('The Rock', 'When vengeful General Francis X. Hummel seizes control of Alcatraz Island and threatens to launch missiles loaded with deadly chemical weapons into San Francisco, only a young FBI chemical weapons expert and notorious Federal prisoner have the skills to penetrate the impregnable island fortress and take him down.', 137, 3, '1996-06-07', 1, 1, 29, 'the_rock.png', 'the_rock.png'),
('American Beauty', 'Lester Burnham, a depressed suburban father in a mid-life crisis, decides to turn his hectic life around after developing an infatuation with his daughter''s attractive friend.', 122, 4, '1999-09-15', 1, 1, 30, 'american_beauty.png', 'american_beauty.png'),
('1917', 'At the height of the First World War, two young British soldiers must cross enemy territory and deliver a message that will stop a deadly attack on hundreds of soldiers.', 119, 4, '2019-12-25', 1, 1, 30, '1917.png', '1917.png'),
('Skyfall', 'When Bond''s latest assignment goes gravely wrong, agents around the world are exposed and MI6 headquarters is attacked. While M faces challenges to her authority and position from Gareth Mallory, the new Chairman of the Intelligence and Security Committee, it''s up to Bond, aided only by field agent Eve, to locate the mastermind behind the attack.', 143, 4, '2012-10-24', 1, 1, 30, 'skyfall.png', 'skyfall.png'),
('Spectre', 'A cryptic message from Bond’s past sends him on a trail to uncover a sinister organization. While M battles political forces to keep the secret service alive, Bond peels back the layers of deceit to reveal the terrible truth behind SPECTRE.', 148, 4, '2015-10-26', 1, 1, 30, 'spectre.png', 'spectre.png'),
('Road to Perdition', 'Mike Sullivan works as a hit man for crime boss John Rooney. Sullivan views Rooney as a father figure, however after his son is witness to a killing, Mike Sullivan finds himself on the run in attempt to save the life of his son and at the same time looking for revenge on those who wronged him.', 117, 4, '2002-07-12', 1, 1, 30, 'road_to_perdition.png', 'road_to_perdition.png'),
('The Sixth Sense', 'Following an unexpected tragedy, child psychologist Malcolm Crowe meets a nine year old boy named Cole Sear, who is hiding a dark secret.', 107, 4, '1999-08-06', 1, 1, 31, 'the_sixth_sense.png', 'the_sixth_sense.png'),
('Unbreakable', 'An ordinary man makes an extraordinary discovery when a train accident leaves his fellow passengers dead — and him unscathed. The answer to this mystery could lie with the mysterious Elijah Price, a man who suffers from a disease that renders his bones as fragile as glass.', 106, 4, '2000-11-22', 1, 1, 31, 'unbreakable.png', 'unbreakable.png'),
('Signs', 'Where do you find love? Sometimes all you need is a sign.', 12, 4, '2008-03-10', 1, 1, 31, 'signs.png', 'signs.png'),
('Split', 'Though Kevin has evidenced 23 personalities to his trusted psychiatrist, Dr. Fletcher, there remains one still submerged who is set to materialize and dominate all the others. Compelled to abduct three teenage girls led by the willful, observant Casey, Kevin reaches a war for survival among all of those contained within him — as well as everyone around him — as the walls between his compartments shatter apart.', 117, 4, '2017-01-19', 1, 1, 31, 'split.png', 'split.png'),
('The Village', 'When a willful young man tries to venture beyond his sequestered Pennsylvania hamlet, his actions set off a chain of chilling incidents that will alter the community forever.', 108, 4, '2004-07-30', 1, 1, 31, 'the_village.png', 'the_village.png'),
('Fight Club', 'A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground "fight clubs" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.', 139, 4, '1999-10-15', 1, 1, 32, 'fight_club.png', 'fight_club.png'),
('Se7en', 'Two homicide detectives are on a desperate hunt for a serial killer whose crimes are based on the "seven deadly sins" in this dark and haunting film that takes viewers from the tortured remains of one victim to the next. The seasoned Det. Somerset researches each sin in an effort to get inside the killer''s mind, while his novice partner, Mills, scoffs at his efforts to unravel the case.', 127, 4, '1995-09-22', 1, 1, 32, 'se7en.png', 'se7en.png'),
('Gone Girl', 'With his wife''s disappearance having become the focus of an intense media circus, a man sees the spotlight turned on him when it''s suspected that he may not be innocent.', 149, 4, '2014-10-01', 1, 1, 32, 'gone_girl.png', 'gone_girl.png'),
('The Social Network', 'In 2003, Harvard undergrad and computer programmer Mark Zuckerberg begins work on a new concept that eventually turns into the global social network known as Facebook. Six years later, Mark is one of the youngest billionaires ever, but his unprecedented success leads to both personal and legal complications when he ends up on the receiving end of two lawsuits, one involving his former friend.', 121, 4, '2010-10-01', 1, 1, 32, 'the_social_network.png', 'the_social_network.png'),
('Zodiac', 'The Zodiac murders cause the lives of Paul Avery, David Toschi and Robert Graysmith to intersect.', 157, 4, '2007-03-02', 1, 1, 32, 'zodiac.png', 'zodiac.png');

-- MOVIEGENRES
INSERT INTO MovieGenres (MovieID, GenreID) VALUES
(1, 1), (1, 5), (1, 9),
(2, 2), (2, 4),
(3, 3), (3, 6),
(4, 1), (4, 2), (4, 3),
(5, 5), (5, 6),
(6, 1), (6, 7),
(7, 2), (7, 4), (7, 9),
(8, 3), (8, 6),
(9, 1), (9, 2), (9, 5),
(10, 7), (10, 9),
(11, 3), (11, 4),
(12, 6), (12, 8), (12, 9),
(13, 2), (13, 5),
(14, 1), (14, 4), (14, 6),
(15, 7), (15, 9),
(16, 3), (16, 5),
(17, 1), (17, 8),
(18, 2), (18, 4), (18, 9),
(19, 3), (19, 7),
(20, 5), (20, 6), (20, 9),
(21, 1), (21, 3),
(22, 2), (22, 6),
(23, 4), (23, 8), (23, 9),
(24, 1), (24, 5), (24, 7),
(25, 2), (25, 3),
(26, 6), (26, 9),
(27, 1), (27, 4), (27, 8),
(28, 2), (28, 5),
(29, 3), (29, 6), (29, 7),
(30, 1), (30, 2), (30, 9),
(31, 1), (31, 2), (31, 3), (31, 4),
(32, 5), (32, 6), (32, 7), (32, 8),
(33, 1), (33, 9), (33, 2), (33, 6),
(34, 3), (34, 4), (34, 5), (34, 7),
(35, 1), (35, 3), (35, 8), (35, 9),
(36, 2), (36, 4), (36, 5), (36, 6),
(37, 7), (37, 8), (37, 9),
(38, 1), (38, 3), (38, 6), (38, 7),
(39, 2), (39, 5), (39, 9),
(40, 4), (40, 6), (40, 8),
(41, 1), (41, 2), (41, 3),
(42, 4), (42, 7), (42, 9),
(43, 1), (43, 5), (43, 6),
(44, 3), (44, 7), (44, 9),
(45, 2), (45, 5), (45, 6),
(46, 1), (46, 4), (46, 9),
(47, 2), (47, 8), (47, 9),
(48, 5), (48, 7), (48, 8),
(49, 3), (49, 6), (49, 9);

-- SHOWTIMES: Insert 1–5 showtimes per movie for first 49 movies
SET NOCOUNT ON;

DECLARE @movieID INT = 1

WHILE @movieID <= 130
BEGIN
    DECLARE @showCount INT = ABS(CHECKSUM(NEWID())) % 5 + 1  -- 1 to 5 showtimes
    DECLARE @i INT = 1

    WHILE @i <= @showCount
    BEGIN
        INSERT INTO ShowTimes (MovieID, AuditoriumID, StartTime, DurationMinutes, SubtitleLanguageID, Is3D)
        VALUES (
            @movieID,
            ABS(CHECKSUM(NEWID())) % 50 + 1,  -- AuditoriumID 1–50
            DATEADD(HOUR, ABS(CHECKSUM(NEWID())) % 10 + 10, DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 6, '2025-10-10')),
            ABS(CHECKSUM(NEWID())) % 71 + 90, -- Duration: 90–160 mins
            ABS(CHECKSUM(NEWID())) % 4 + 1,   -- SubtitleLanguageID 1–4
            ABS(CHECKSUM(NEWID())) % 2        -- Is3D: 0 or 1
        );

        SET @i += 1
    END

    SET @movieID += 1
END

SET NOCOUNT OFF;


-- TICKETS


-- TICKET PAYMENTS


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
(1, 2, 4, 'Great action scenes, but a bit too long.', 1),
(1, 3, 5, 'One of the best films I have seen!', 1),

(2, 4, 4, 'Hilarious and fun.', 1),
(2, 5, 3, 'It was okay, not my favorite.', 1),
(2, 6, 5, 'Absolutely loved it, will watch again!', 1),

(3, 7, 5, 'A thrilling journey, highly recommended!', 1),
(3, 8, 4, 'Great suspense, but the ending was predictable.', 1),
(3, 9, 5, 'Fantastic, an emotional rollercoaster!', 1),

(4, 10, 4, 'Amazing dialogue and action!', 1),
(4, 11, 3, 'Too much action, not enough character development.', 1),
(4, 12, 5, 'One of the most captivating movies I’ve seen.', 1),

(5, 13, 5, 'Such a touching and emotional story!', 1),
(5, 14, 4, 'Good movie, but could have been better paced.', 1),
(5, 15, 5, 'Simply breathtaking, a masterpiece!', 1),

(6, 16, 4, 'The visuals were stunning, but the story was lacking.', 1),
(6, 17, 3, 'It had its moments, but not great overall.', 1),
(6, 18, 5, 'A must-watch for fans of the genre!', 1),

(7, 19, 4, 'Great cast and direction, a bit predictable.', 1),
(7, 20, 5, 'Loved it, such a beautiful narrative!', 1),
(7, 1, 3, 'It didn’t live up to the hype for me.', 1),

(8, 2, 5, 'A brilliant mix of comedy and drama!', 1),
(8, 3, 4, 'Very funny, but felt a little rushed at times.', 1),
(8, 4, 5, 'I couldn’t stop laughing, amazing movie!', 1),

(9, 5, 5, 'A masterclass in filmmaking, highly recommend!', 1),
(9, 6, 4, 'Fantastic visuals, but the plot was weak.', 1),
(9, 7, 5, 'A perfect movie for a weekend binge.', 1),

(10, 8, 5, 'The best movie of the year, hands down!', 1),
(10, 9, 4, 'Really good, but could have been better developed in some parts.', 1),
(10, 10, 5, 'Incredible film, I’ve watched it twice already!', 1);

INSERT INTO Reviews (MovieID, UserID, Rating, Comment, IsApproved) VALUES
(11, 1, 5, 'Incredible story, loved every moment of it!', 1),
(11, 2, 4, 'A bit slow at times, but still enjoyable.', 1),
(11, 3, 5, 'A true cinematic masterpiece!', 1),

(12, 4, 5, 'Such a great movie, unforgettable characters.', 1),
(12, 5, 4, 'It was good, but felt a bit predictable.', 1),
(12, 6, 5, 'I’m in love with this movie, so well made!', 1),

(13, 7, 4, 'Had some great moments, but could have been better.', 1),
(13, 8, 5, 'A beautiful and emotional story.', 1),
(13, 9, 5, 'One of my favorites, fantastic film!', 1),

(14, 10, 4, 'Loved the action scenes, but the pacing was off.', 1),
(14, 11, 3, 'Couldn’t connect with the characters.', 1),
(14, 12, 5, 'A thrilling and unforgettable experience!', 1),

(15, 13, 5, 'A stunning visual masterpiece, a must-see!', 1),
(15, 14, 4, 'Great plot, but the ending was a little weak.', 1),
(15, 15, 5, 'Perfectly executed, top-tier film!', 1),

(16, 16, 4, 'Interesting concept, but it could’ve been developed more.', 1),
(16, 17, 3, 'Not as good as I expected, but still enjoyable.', 1),
(16, 18, 5, 'Absolutely amazing, I was hooked from start to finish!', 1),

(17, 19, 4, 'Great movie, but could have used more depth.', 1),
(17, 20, 5, 'A powerful movie with great performances!', 1),
(17, 1, 3, 'A bit overrated, I didn’t find it that good.', 1),

(18, 2, 5, 'Absolutely love this film, highly recommend!', 1),
(18, 3, 4, 'It was enjoyable, but I expected more from it.', 1),
(18, 4, 5, 'Incredible storytelling, one of the best films of the year!', 1),

(19, 5, 5, 'Such a beautiful film, the visuals were breathtaking.', 1),
(19, 6, 4, 'Great performances, but the plot was a bit weak.', 1),
(19, 7, 5, 'Amazing film, unforgettable experience!', 1),

(20, 8, 5, 'The best thriller I’ve seen in years, absolutely gripping!', 1),
(20, 9, 4, 'The plot was good, but it could have been tighter.', 1),
(20, 10, 5, 'Mind-blowing movie, I couldn’t look away!', 1),

(21, 11, 5, 'Such a moving and powerful film, really touched my heart.', 1),
(21, 12, 4, 'Great acting, but some parts were slow-paced.', 1),
(21, 13, 5, 'Masterpiece, I was glued to the screen the whole time!', 1),

(22, 14, 4, 'Great chemistry between the leads, but the plot was lacking.', 1),
(22, 15, 3, 'It didn’t live up to the hype for me, a bit disappointing.', 1),
(22, 16, 5, 'Fantastic movie, one of the best in recent years!', 1),

(23, 17, 4, 'Good movie, but a bit predictable at times.', 1),
(23, 18, 5, 'One of the best comedies I’ve seen, hilarious!', 1),
(23, 19, 5, 'Absolutely loved it, so funny!', 1),

(24, 20, 5, 'Amazing performances, loved every minute of it!', 1),
(24, 1, 4, 'Great drama, but the pacing was a little off.', 1),
(24, 2, 5, 'Such a beautiful film, it touched my soul.', 1),

(25, 3, 5, 'A heart-wrenching and emotional movie, will watch again.', 1),
(25, 4, 4, 'It was good, but a little too long for my taste.', 1),
(25, 5, 5, 'An unforgettable experience, I was left speechless!', 1),

(26, 6, 5, 'An amazing adventure, loved the twists and turns!', 1),
(26, 7, 4, 'Really enjoyed the movie, but some scenes felt unnecessary.', 1),
(26, 8, 5, 'A fantastic journey, truly a must-watch!', 1),

(27, 9, 5, 'Such a brilliant and unique movie, loved it!', 1),
(27, 10, 4, 'Very entertaining, but could have been tighter.', 1),
(27, 11, 5, 'A cinematic gem, highly recommend!', 1),

(28, 12, 5, 'Such an emotional rollercoaster, loved every minute!', 1),
(28, 13, 4, 'Good plot, but the pacing was a bit uneven.', 1),
(28, 14, 5, 'One of the best thrillers I’ve ever seen, truly gripping!', 1),

(29, 15, 4, 'Great film, but I expected more suspense.', 1),
(29, 16, 5, 'Incredible movie, highly recommend it to anyone!', 1),
(29, 17, 5, 'Fantastic, I couldn’t take my eyes off the screen!', 1),

(30, 18, 5, 'Such an amazing movie, loved the performances!', 1),
(30, 19, 4, 'Great action, but the story could have been better.', 1),
(30, 20, 5, 'A thrilling experience, one of the best this year!', 1),

(31, 1, 5, 'Such a captivating movie, couldn’t stop watching!', 1),
(31, 2, 4, 'Great plot, but the pacing was a little slow.', 1),
(31, 3, 5, 'Absolutely loved it, definitely one of my favorites!', 1),

(32, 4, 5, 'Incredible performances, an unforgettable experience!', 1),
(32, 5, 4, 'Good movie, but it could have been more exciting.', 1),
(32, 6, 5, 'A visual masterpiece, amazing from start to finish!', 1),

(33, 7, 4, 'Good movie, but felt a bit predictable at times.', 1),
(33, 8, 5, 'Such a great film, amazing plot and acting!', 1),
(33, 9, 5, 'One of the best movies I’ve seen, fantastic direction!', 1),

(34, 10, 4, 'The action was great, but some scenes felt forced.', 1),
(34, 11, 3, 'It didn’t quite live up to the hype for me.', 1),
(34, 12, 5, 'A thrilling ride from start to finish!', 1),

(35, 13, 5, 'A beautiful movie, truly heartwarming!', 1),
(35, 14, 4, 'Good movie, but I expected more from the ending.', 1),
(35, 15, 5, 'Such an amazing story, would highly recommend!', 1),

(36, 16, 4, 'Interesting movie, but it lacked depth in some areas.', 1),
(36, 17, 3, 'Not as good as I thought it would be, but still enjoyable.', 1),
(36, 18, 5, 'One of the best films I’ve seen, truly remarkable!', 1),

(37, 19, 4, 'Good movie, but it could have been better in some places.', 1),
(37, 20, 5, 'A fantastic movie, loved every part of it!', 1),
(37, 1, 3, 'It didn’t quite do it for me, a bit overrated.', 1),

(38, 2, 5, 'Such a gripping movie, I couldn’t look away!', 1),
(38, 3, 4, 'It was good, but I expected a little more from it.', 1),
(38, 4, 5, 'Absolutely incredible, one of the best I’ve seen this year!', 1),

(39, 5, 5, 'What an emotional film, deeply moving.', 1),
(39, 6, 4, 'Great acting, but the plot was a little lacking.', 1),
(39, 7, 5, 'Incredible movie, will definitely watch again!', 1),

(40, 8, 5, 'Best thriller I’ve seen in years, such a ride!', 1),
(40, 9, 4, 'Great plot, but it could have been a little more intense.', 1),
(40, 10, 5, 'A mind-blowing experience, highly recommend!', 1),

(41, 11, 5, 'Such a beautiful film, amazing performances all around!', 1),
(41, 12, 4, 'Great acting, but the pacing was a bit slow at times.', 1),
(41, 13, 5, 'Absolutely amazing, a true masterpiece!', 1),

(42, 14, 4, 'Great chemistry, but the plot was predictable.', 1),
(42, 15, 3, 'It didn’t quite live up to my expectations.', 1),
(42, 16, 5, 'Such a fantastic movie, really well made!', 1),

(43, 17, 4, 'Good movie, but the story was a bit too familiar.', 1),
(43, 18, 5, 'One of the funniest movies I’ve seen in a while, hilarious!', 1),
(43, 19, 5, 'Such a funny film, I loved it!', 1),

(44, 20, 5, 'Amazing movie, great performances and great pacing!', 1),
(44, 1, 4, 'Loved it, but some parts were a bit too slow for me.', 1),
(44, 2, 5, 'Beautiful movie, deeply moving, one of my favorites!', 1),

(45, 3, 5, 'Such an emotional movie, left me speechless!', 1),
(45, 4, 4, 'Good movie, but a little too long for my taste.', 1),
(45, 5, 5, 'Unforgettable, one of the best movies I’ve seen in years!', 1),

(46, 6, 5, 'Such a fantastic journey, absolutely loved it!', 1),
(46, 7, 4, 'Really enjoyed the movie, but some scenes were unnecessary.', 1),
(46, 8, 5, 'An amazing adventure, couldn’t stop watching!', 1),

(47, 9, 5, 'Such a brilliant and unique movie, loved it!', 1),
(47, 10, 4, 'Very entertaining, but could have been a bit more exciting.', 1),
(47, 11, 5, 'Highly recommend, one of the best I’ve seen!', 1),

(48, 12, 5, 'Such an emotional rollercoaster, loved every minute!', 1),
(48, 13, 4, 'Good plot, but the pacing was a bit uneven.', 1),
(48, 14, 5, 'One of the best thrillers, truly gripping!', 1),

(49, 15, 4, 'Great film, but could have had more suspense.', 1),
(49, 16, 5, 'Incredible, a must-see for anyone!', 1),
(49, 17, 5, 'Fantastic, couldn’t take my eyes off the screen!', 1);