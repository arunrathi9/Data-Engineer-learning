-- Active: 1669433216308@@127.0.0.1@3306
-- City-Dataset:https://docs.google.com/spreadsheets/d/1dk9kRwcMxj5USuJqxtITD05S-aOUD6fzNzV W41dcpgc/edit?usp=sharing
-- Q1. Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
-- The CITY table is described as follows:

CREATE DATABASE Challenge_set1
    DEFAULT CHARACTER SET = 'utf8mb4';

USE Challenge_set1;

-- Q17
-- table - Product
create table if not exists Product (
    product_id int,
    product_name VARCHAR(500),
    unit_price int,
    constraint PK_Product PRIMARY KEY (product_id)
);

-- table - Sales
CREATE Table if not exists Sales (
    seller_id int,
    product_id int,
    buyer_id int,
    sale_date DATE,
    quantity int,
    price int,
    constraint FK_Sales FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Q17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

-- Inserting the DATA
insert into Product values (1,'S8', 1000), (2, 'G4', 800), (3, 'iPhone', 1400);
select * from Product;

insert into Sales values (1,1,1,'2019-01-21', 2, 2000), (1,2,2,'2019-02-17', 1, 800), (2,2,3,'2019-06-02', 1, 800), (3,3,4,'2019-05-13', 2,2800);

-- Answer
select product_id, product_name from `Challenge_set1`.`Product` where product_id not in (
    select product_id from `Challenge_set1`.`Sales` where (sale_date < '2019-01-01' OR sale_date > '2019-03-31'));

-- Q18
-- Creating table
create table if not exists Views (
    article_id INT,
    authod_id INT,
    viewer_id INT,
    view_date DATE
);

-- inserting data
insert into Views VALUES (1,3,5,'2019-08-01'), (1,3,6,'2019-08-02'), (2,7,7, '2019-08-02'), (2, 7, 6, '2019-08-02'), (4, 7,1, '2019-07-22'),
(3,4,4,'2019-07-21'), (3,4,4,'2019-07-21');

select * from `Challenge_set1`.`Views`;

-- Ques - Write an SQL query to find all the authors that viewed at least one of their own articles. 
--          Return the result table sorted by id in ascending order.
select Distinct authod_id from `Challenge_set1`.`Views` where authod_id = viewer_id order by authod_id;

-- Ques 19
-- Creating table - Delivery

create table if not exists Delivery (
    delivery_id int,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE,
    constraint PK_Delivery PRIMARY KEY (delivery_id)
);

-- inserting data in Delivery TABLE
INSERT INTO `Challenge_set1`.`Delivery` VALUES (1,1,'2019-08-01', '2019-08-02'), (2,5,'2019-08-02', '2019-08-02'), 
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24', '2019-08-26'),
(5,4,'2019-08-21', '2019-08-22'),
(6,2,'2019-08-11', '2019-08-13');
select * from `Challenge_set1`.`Delivery`;

-- Immediate if order_date and customer_pref_delivery_date is same else scheduled
-- Ques - Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
with immediateOrder(counts) as (SELECT count(delivery_id) from `Challenge_set1`.`Delivery` where order_date = customer_pref_delivery_date),
allOrder(total) as (SELECT count(*) FROM Delivery)
select cast((i.counts/a.total) * 100 as Decimal(4,2)) as immediate_percentage from allOrder a, immediateOrder i;

-- Ques 20
-- Creating TABLE Ads
CREATE Table if NOT exists Ads (
    ad_id int,
    user_id int,
    action ENUM ('Clicked', 'Viewed', 'Ignored'),
    constraint PK_Ads PRIMARY KEY (ad_id, user_id)
);

-- inserting data
INSERT INTO Ads VALUES (1,1,'Clicked'),
(2,2,'Clicked'),
(3,3,'Viewed'),
(5,5,'Ignored'),
(1,7,'Ignored'),
(2,7,'Viewed'),
(3,5,'Clicked'),
(1,4,'Viewed'),
(2,11,'Viewed'),
(1,2,'Clicked');
select * from Ads;

-- Click-Through Rate (CTR)
-- formula - ctr = 0, if ad total clicks + Ad total views = 0 else = (ad total clicks/(ad total clicks + ad total views))*100
-- Ques - Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
--      Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.


-- ******************* Need to check further *********************

-- Q 21
-- Creating table Employee
CREATE Table if NOT exists Employee (
    employee_id int,
    team_id int,
    constraint PK_Employee PRIMARY key (employee_id)
);

-- inserting data
INSERT INTO Employee VALUES (1,8), (2,8), (3,8), (4,7), (5, 9), (6,9);

-- Statement - Write an SQL query to find the team size of each of the employees. Return result table in any order.
with countTable(team_id, team_size) as (select team_id, count(*) from Employee group by team_id)
select employee_id, team_size from Employee e join countTable c on e.team_id = c.team_id;


-- Q22  
-- Creating the table Countries
CREATE Table if NOT exists Countries (
    country_id int,
    country_name VARCHAR(50),
    constraint PK_Countries PRIMARY KEY (country_id)
);

-- Creating the table Weather
CREATE Table if NOT exists Weather (
    country_id int,
    weather_state int,
    day DATE,
    constraint PK_Weather PRIMARY KEY (country_id, day)
);

-- inserting the data
INSERT INTO Countries VALUES (2, 'USA'), (3, 'Australia'), (7, 'Peru'), (5, 'China'), (8, 'Morocco'), (9, 'Spain');
INSERT INTO Weather VALUES (2, 15, '2019-11-01'), (2, 12, '2019-10-28'), (2,12,'2019-10-27'),
(3,-2,'2019-11-10'), (3,0,'2019-11-11'), (3,3,'2019-11-12'), (5,16,'2019-11-07'),
(5,18,'2019-11-09'), (5,21,'2019-11-23'), (7,25,'2019-11-28'), (7,22,'2019-12-01'),
(7,20,'2019-12-02'), (8,25,'2019-11-05'), (8,27,'2019-11-15'), (8,31,'2019-11-25'),
(9,7,'2019-10-23'), (9, 3, '2019-12-23');

-- Ques - Write an SQL query to find the type of weather in each country for November 2019. The type of weather is:
-- * Cold if avg weather_state <= 15
-- * Hot if avg weather_state >= 25, and
-- * Warm otherwise
select country_name, 
case when avg(weather_state) <= 15 then 'Cold'
when avg(weather_state) >= 25 then 'Hot'
else 'Warm'
end as weather_type
from Countries c join Weather w on c.country_id = w.country_id where Month(w.day) = 11 GROUP BY w.country_id;

-- Q23
-- creating table Prices
CREATE Table if NOT exists Prices (
    product_id int,
    start_date DATE,
    end_date DATE,
    pricec int,
    constraint PK_Prices PRIMARY KEY (product_id, start_date, end_date)
);

CREATE Table if NOT exists UnitsSold (
    product_id int,
    purchase_date DATE,
    units INT
);

-- inserting the data
INSERT INTO Prices VALUES (1,'2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);

INSERT INTO UnitsSold VALUES (1,'2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);

-- Ques - Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
select product_id, CAst(sum(sales)/sum(units) as Decimal(7,2)) as average_price from (
    select p.product_id, price, units, price*units as sales from Prices p
JOIN UnitsSold u on p.product_id = u.product_id and (
    start_date <= purchase_date and end_date >= purchase_date)) a GROUP BY product_id;
    
-- Q24
-- creating table
CREATE Table if NOT exists Activity (
    player_id int,
    device_id int,
    event_date DATE,
    games_played INT,
    constraint PK_Activity PRIMARY KEY (player_id, event_date)
);

-- inserting the data
INSERT INTO Activity VALUES (1,2,'2016-03-01', 5),
(1,2,'2016-05-02', 6),
(2,3,'2017-06-25', 1),
(3,1,'2016-03-02', 0),
(3,4,'2018-07-03', 5);

-- Ques - Write an SQL query to report the first login date for each player


-- Q25
-- Ques - Write an SQL query to report the device that is first logged in for each player.
