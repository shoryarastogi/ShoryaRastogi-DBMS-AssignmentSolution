CREATE SCHEMA if not exists TravelAndGo;
USE  TravelAndGo;

-- Q-1  Creating the Table 

CREATE TABLE if not exists Passenger (
    Passenger_name VARCHAR(50),
    Category VARCHAR(15),
    Gender VARCHAR(1),
    Boarding_City VARCHAR(25),
    Destination_City VARCHAR(25),
    Distance INT,
    Bus_Type VARCHAR(10)
);

CREATE TABLE if not exists Price (
    Bus_Type VARCHAR(10),
    Distance INT,
    Price INT
);

-- Q-2 Inserting Data into Table  

insert into Passenger values
("Sejal","AC", "F","Bengaluru","Chennai",350,"Sleeper"),
("Anmol","Non-AC","M","Mumbai","Hyderabad",700,"Sitting"),
("Pallavi","AC","F","Panaji","Bengaluru", 600,"Sleeper"),
("Khusboo","AC","F","Chennai","Mumbai", 1500,"Sleeper"),
("Udit","Non-AC","M","Trivandrum","Panaji",1000,"Sleeper"),
("Ankur","AC","M","Nagpur","Hyderabad", 500,"Sitting"),
("Hemant","Non-AC","M","Panaji","Mumbai", 700,"Sleeper"),
("Manish","Non-AC","M","Hyderabad","Bengaluru",500,"Sitting"),
("Piyush","AC","M","Pune","Nagpur", 700,"Sitting");

select * from Passenger;

insert into Price values("Sleeper", 350, 770),
("Sleeper",  500, 1100),
("Sleeper",  600 ,1320),
("Sleeper",  700, 1540),
("Sleeper",  1000, 2200),
("Sleeper",  1200, 2640),
("Sleeper",  1500, 2700),
("Sitting",  500 ,620),
("Sitting",  600, 744),
("Sitting",  700, 868),
("Sitting",  1000, 1240),
("Sitting",  1200, 1488),
("Sitting", 1500, 1860);


-- Q-3  How many females and how many male passengers travelled for a minimum distance of 600 KM s?

SELECT 
    Gender, COUNT(Gender)
FROM
    Passenger
WHERE
    Distance >= 600
GROUP BY Gender;

-- Q-4  Find the minimum ticket price for Sleeper Bus.

SELECT 
    MIN(Price) AS MinimumPrice
FROM
    Price
WHERE
    Bus_Type = 'Sleeper';


-- Q-5 Select passenger names whose names start with character 'S' 

SELECT 
    Passenger_name
FROM
    Passenger
WHERE
    Passenger_name LIKE 'S%';

-- Q-6 Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

SELECT 
    Passenger.Passenger_name,
    Passenger.Boarding_City,
    Passenger.Destination_City,
    Passenger.Distance,
    Price.Bus_Type,
    Price.Price
FROM
    Passenger
        INNER JOIN
    Price
WHERE
    Passenger.Bus_Type = Price.Bus_Type
        AND Passenger.Distance = Price.Distance; 

-- Q-7  What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s 

SELECT 
    Passenger.Passenger_name,
    Price.Price,
    Price.Distance,
    Passenger.Bus_Type
FROM
    Passenger,
    Price
WHERE
    Passenger.Bus_Type = Price.Bus_Type
        AND Passenger.Distance = Price.Distance
		AND Passenger.Bus_Type = 'Sitting'
        AND Price.Distance = 1000; 

-- Q-8 What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

SELECT 
    Price.Bus_Type, Price.Price
FROM
    Price
WHERE
    Price.Distance = (SELECT 
            Passenger.Distance
        FROM
            Passenger
        WHERE
            Passenger.Passenger_name = 'Pallavi');

-- Q-9 List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.

SELECT DISTINCT
    Passenger.Distance
FROM
    Passenger
ORDER BY Passenger.Distance DESC;

-- Q-10 Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
 SELECT 
    Passenger.Passenger_name,
    (Passenger.Distance / (SELECT 
            SUM(Passenger.Distance)
        FROM
            Passenger)) * 100 PercentAge
FROM
    Passenger;

-- Q-11 Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise

SELECT 
    Price.Distance,
    Price.Price,
    CASE
        WHEN Price.Price > 1000 THEN 'Expensive'
        WHEN Price.Price < 1000 AND Price.Price > 500 THEN 'Average'
        ELSE 'Cheap'
    END AS Remark
FROM
    Price;
