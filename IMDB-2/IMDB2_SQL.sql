CREATE DATABASE IMDB2
USE IMDB2
  ----1 create Directors
  CREATE TABLE Directors(
  Id int PRIMARY KEY,
  [Name] nvarchar(33)
  )

   ----2 create Actors
   CREATE TABLE Actors(
  Id int PRIMARY KEY,
  [Name] nvarchar(33)
  )

      ----3 create Genres
   CREATE TABLE Genres(
  Id int PRIMARY KEY,
  [Name] nvarchar(33)
  )

    CREATE TABLE Movies(
  Id int PRIMARY KEY,
  [Name] nvarchar(33),
  ImdbPoint int,
  )

    CREATE TABLE MovieDirectorActorGenres(
	Id int identity PRIMARY KEY,
	MovieId int REFERENCES Movies(Id),
	DirectorId int REFERENCES Directors(Id),
	ActorId int REFERENCES Actors(Id),
	GenreId int REFERENCES Genres(Id),
	)
  ALTER TABLE Movies ALTER COLUMN ImdbPoint decimal(18,2)  


  -------1) Imdb point-i 6-dan yuxarı olan filmlərin adını, imdb dəyərini, Genre adını,Director adını və aktyor adı

  SELECT mov.Name MovieName,mov.ImdbPoint IMDBPoint,
  ge.Name MovieGenre,
  dir.Name MovieDirector,
  ac.Name ActorName
  FROM MovieDirectorActorGenres mdag
  JOIN Movies mov
  ON mdag.MovieId=mov.Id
  JOIN Genres ge
  ON mdag.GenreId=ge.Id
   JOIN Directors dir
  ON mdag.DirectorId=dir.Id
   JOIN Actors ac
  ON mdag.ActorId=ac.Id
  WHERE mov.ImdbPoint>6


  ---2) Genre adında "a" hərfi olan bütün filmlərin adını, imdb dəyərini, Genre adı

  SELECT mov.Name MovieName,mov.ImdbPoint IMDBPoint,
  ge.Name MovieGenre
  FROM MovieDirectorActorGenres mdag
    JOIN Movies mov
  ON mdag.MovieId=mov.Id
    JOIN Genres ge
  ON mdag.GenreId=ge.Id
  WHERE ge.Name LIKE '%a%'


  -----3) Film adının uzunluğu 10-dan böyük olan və film adının sonu "n" hərfiylə bitən bütün filmlərin adını, imdb dəyərini,  Genre adı
     
  SELECT mov.Name MovieName,mov.ImdbPoint IMDBPoint,
  ge.Name MovieGenre
  FROM MovieDirectorActorGenres mdag
    JOIN Movies mov
  ON mdag.MovieId=mov.Id
    JOIN Genres ge
  ON mdag.GenreId=ge.Id
  WHERE  LEN(mov.Name)>10 AND mov.Name LIKE '%n'
  


	 
	 ---4) Imdb point-i ümumi filmlərin imdb point-lərini ortalamasından böyük olan filmlərin
         --adını, imdb dəyərini, Genre adını, Director adını və aktyor adını gətirən və imdb dəyərinə görə azalan sırayla
  SELECT mov.Name MovieName,mov.ImdbPoint IMDBPoint,
  ge.Name MovieGenre,
  dir.Name MovieDirector,
  ac.Name ActorName
  FROM MovieDirectorActorGenres mdag
  JOIN Movies mov
  ON mdag.MovieId=mov.Id
  JOIN Genres ge
  ON mdag.GenreId=ge.Id
   JOIN Directors dir
  ON mdag.DirectorId=dir.Id
   JOIN Actors ac
  ON mdag.ActorId=ac.Id
  WHERE mov.ImdbPoint>( SELECT AVG(ImdbPoint)  FROM Movies) ORDER BY(ImdbPoint) DESC
