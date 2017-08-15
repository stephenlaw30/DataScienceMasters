--Query all columns for all American cities with populations larger than 100000 (MS SQL + MySQL)
SELECT * FROM CITY WHERE POPULATION > 100000 AND COUNTRYCODE = 'USA'

--Query names of all American cities with populations larger than 120000 (MS SQL + MySQL)
SELECT NAME FROM CITY WHERE POPULATION > 120000 AND COUNTRYCODE = 'USA'

--Query all columns (attributes) for every row in the CITY table.
SELECT * FROM CITY

--Query all columns for a city in CITY with the ID 1661.
SELECT * FROM CITY WHERE ID = 1661

--Query all attributes of every Japanese city in the CITY table
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN'

--Query names of every Japanese city in the CITY table
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN'

--*********STATION************

--Query a list of CITY and STATE from the STATION table.
SELECT CITY, STATE FROM STATION

--Query a list of CITY names from STATION with even ID numbers only. 
--May print the results in any order, but must exclude duplicates.
SELECT DISTINCT CITY FROM STATION WHERE ID % 2 = 0

--Let N = number of CITY entries in STATION, and let N' =  number of distinct CITY names in STATION
--Query the value of N-N' from STATION (find the difference between the total number of CITY entries 
--	in the table and the number of distinct CITY entries in the table
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS 'DIFFERENCE' FROM STATION

--Query the 2 cities in STATION with the shortest and longest CITY names, as well as their respective lengths
-- (i.e.: number of characters in the name). 
--If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
SELECT TOP 1 CITY, MAX(LEN(CITY)) FROM STATION
GROUP BY CITY
ORDER BY MAX(LEN(CITY)) DESC, CITY ASC;

SELECT TOP 1 CITY, MIN(LEN(CITY)) FROM STATION
GROUP BY CITY
ORDER BY MIN(LEN(CITY)), CITY ASC;

