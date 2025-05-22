-- Table Structure
CREATE TABLE Users (
            UserID INT PRIMARY KEY,
            UserName VARCHAR(50),
            JoinDate DATE,
            SubscriptionType VARCHAR(20)
        );

CREATE TABLE Movies (
            MovieID INT PRIMARY KEY,
            Title VARCHAR(100),
            Genre VARCHAR(50),
            Duration INT,
            ReleaseYear INT
        );

CREATE TABLE WatchHistory (
            WatchID INT PRIMARY KEY,
            UserID INT,
            MovieID INT,
            WatchDate DATE,
            WatchDuration INT,
            FOREIGN KEY (UserID) REFERENCES Users(UserID),
            FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
        );

-- Beginner Level
SELECT COUNT(*) AS TotalUsers FROM Users;

SELECT AVG(Duration) AS AvgMovieDuration FROM Movies;

SELECT SUM(WatchDuration) AS TotalWatchTime FROM WatchHistory;

SELECT Genre, COUNT(*) AS MovieCount FROM Movies GROUP BY Genre;

SELECT MIN(JoinDate) AS EarliestJoinDate FROM Users;

SELECT MAX(ReleaseYear) AS LatestReleaseYear FROM Movies;

-- Intermediate Level
SELECT SubscriptionType, COUNT(*) AS UserCount FROM Users GROUP BY SubscriptionType;

SELECT UserID, SUM(WatchDuration) AS TotalWatchTime FROM WatchHistory GROUP BY UserID;

SELECT MovieID, AVG(WatchDuration) AS AvgWatchDuration FROM WatchHistory GROUP BY MovieID;

SELECT U.SubscriptionType, AVG(W.WatchDuration) AS AvgWatchTime FROM Users U JOIN WatchHistory W ON U.UserID = W.UserID GROUP BY U.SubscriptionType;

SELECT M.MovieID, M.Title, COUNT(W.WatchID) AS ViewCount
           FROM Movies M
           LEFT JOIN WatchHistory W ON M.MovieID = W.MovieID
           GROUP BY M.MovieID, M.Title;

SELECT ReleaseYear, AVG(Duration) AS AvgDuration FROM Movies GROUP BY ReleaseYear;

-- Advanced Level
SELECT TOP 1 M.MovieID, M.Title, SUM(W.WatchDuration) AS TotalWatch
           FROM Movies M
           JOIN WatchHistory W ON M.MovieID = W.MovieID
           GROUP BY M.MovieID, M.Title
           ORDER BY TotalWatch DESC;

		   SELECT TOP 2 M.MovieID, M.Title, SUM(W.WatchDuration) AS TotalWatch
           FROM Movies M
           JOIN WatchHistory W ON M.MovieID = W.MovieID
           GROUP BY M.MovieID, M.Title
           ORDER BY TotalWatch DESC;
		   -- extra indivisual task from me for practice 

SELECT UserID, SUM(WatchDuration) AS TotalWatchTime
           FROM WatchHistory
           GROUP BY UserID
           HAVING SUM(WatchDuration) > 100;

SELECT M.Genre, SUM(W.WatchDuration) AS GenreWatchTime
           FROM Movies M
           JOIN WatchHistory W ON M.MovieID = W.MovieID
           GROUP BY M.Genre;

SELECT UserID, WatchDate, COUNT(DISTINCT MovieID) AS MoviesWatched
           FROM WatchHistory
           GROUP BY UserID, WatchDate
           HAVING COUNT(DISTINCT MovieID) >= 2;

SELECT Genre, SUM(W.WatchDuration) AS TotalDuration
           FROM Movies M
           JOIN WatchHistory W ON M.MovieID = W.MovieID
           GROUP BY Genre
           ORDER BY TotalDuration DESC;

SELECT FORMAT(JoinDate, 'yyyy-MM') AS JoinMonth, COUNT(*) AS UserCount
           FROM Users
           GROUP BY FORMAT(JoinDate, 'yyyy-MM');

		   -- Sample data for Users

INSERT INTO Users (UserID, UserName, JoinDate, SubscriptionType) VALUES
    (1, 'Alice', '2023-01-15', 'Basic'),
    (2, 'Bob', '2023-02-20', 'Premium'),
    (3, 'Charlie', '2023-03-10', 'Basic'),
    (4, 'Diana', '2023-04-05', 'Standard');

-- Sample data for Movies

INSERT INTO Movies (MovieID, Title, Genre, Duration, ReleaseYear) VALUES
    (101, 'Movie A', 'Action', 120, 2022),
    (102, 'Movie B', 'Drama', 90, 2021),
    (103, 'Movie C', 'Comedy', 110, 2023),
    (104, 'Movie D', 'Action', 95, 2020),
    (105, 'Movie E', 'Drama', 100, 2023);

-- Sample data for WatchHistory

INSERT INTO WatchHistory (WatchID, UserID, MovieID, WatchDate, WatchDuration) VALUES
    (1001, 1, 101, '2023-04-10', 120),
    (1002, 1, 103, '2023-04-10', 110),
    (1003, 2, 102, '2023-04-11', 90),
    (1004, 3, 104, '2023-04-12', 95),
    (1005, 3, 105, '2023-04-13', 100),
    (1006, 4, 103, '2023-04-14', 100),
    (1007, 4, 101, '2023-04-14', 120);

