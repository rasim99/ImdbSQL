
  CREATE DATABASE IMDB
  USE IMDB
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
     ----4 create Movies
  CREATE TABLE Movies(
  Id int PRIMARY KEY,
  [Name] nvarchar(33),
  ImdbPoint int,
  GenresId int REFERENCES Genres(Id),
   ActorsId int REFERENCES Actors(Id),
   DirectorsId int REFERENCES Directors(Id)
  )

  ALTER TABLE Movies ALTER COLUMN ImdbPoint decimal(2,2)  
  ALTER TABLE Movies DROP COLUMN ImdbPoint
   ALTER TABLE Movies ADD  ImdbPoint decimal(10,2)
  ------------insert////select queries
  SELECT * FROM Movies

  -----Directors
   SELECT * FROM Directors
   INSERT INTO Directors VALUES(
   5,
   'DirectorE'
   )

   ----Actors
   SELECT * FROM Actors
   INSERT INTO Actors VALUES(
   5,
   'ActorU'
   )

      ----Genres
   SELECT * FROM Genres
   INSERT INTO Genres VALUES(
   5,
   'GenresO'
   )

  ----Movies
   SELECT * FROM Movies
 UPDATE Movies SET  ImdbPoint=9.3 WHERE Id=1
  UPDATE Movies SET  [Name]='KinoAdI2' WHERE Id=2
  UPDATE Movies SET  [Name]='KinoAdI3' WHERE Id=3
  UPDATE Movies SET  ImdbPoint=8.5 WHERE Id=4

  -------1) Imdb point-i 6-dan yuxarı olan filmlərin adını, imdb dəyərini, Genre adını,Director adını və aktyor adı
   SELECT mo.[Name] as MovieName,
   mo.ImdbPoint as MovieImdbPoint,
   ge.[Name]  as GenreName,
   di.Name as DirectorName,
    ac.Name as ActorName
   FROM Movies mo
   JOIN Genres ge
   ON  mo.GenresId=ge.Id
      JOIN Directors di
   ON  mo.DirectorsId=di.Id
      JOIN Actors ac
   ON  mo.ActorsId=ac.Id
   WHERE ImdbPoint >6
  
  ---2) Genre adında "a" hərfi olan bütün filmlərin adını, imdb dəyərini, Genre adı
     SELECT mo.Name MovieName ,mo.ImdbPoint MovieImdbPoint ,ge.Name MovieGenre
   FROM Movies mo
   JOIN Genres ge
   ON  
   mo.GenresId=ge.Id
   WHERE ge.Name LIKE '%a%'
   
   ---4) Imdb point-i ümumi filmlərin imdb point-lərini ortalamasından böyük olan filmlərin
         --adını, imdb dəyərini, Genre adını, Director adını və aktyor adını gətirən və imdb dəyərinə
      ----görə azalan sırayla düzən select query-i yazın
	  SELECT AVG(ImdbPoint) as avgImdbPoint FROM Movies
	  SELECT mov.Name MOVIENAME,
	  mov.ImdbPoint MOVIEIMDBPOINT,
	  gen.Name MOVIEGENRE,
	  dir.Name DIRECTORNAME,
	  act.Name ACTERNAME
	  FROM Movies mov
	  JOIN Genres gen
	  ON  mov.GenresId=gen.Id
	  JOIN Directors dir
	  ON mov.DirectorsId=dir.Id
	  JOIN Actors act
	  ON mov.ActorsId=act.Id
	  WHERE mov.ImdbPoint> ( SELECT AVG(ImdbPoint) as avgImdbPoint FROM Movies)
	  ORDER BY (ImdbPoint) DESC