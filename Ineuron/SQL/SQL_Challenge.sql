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
select player_id, min(event_date) from Activity GROUP BY player_id;

-- Q25
-- Ques - Write an SQL query to report the device that is first logged in for each player.
select player_id, device_id from Activity where event_date in (
    select min(event_date) as ed from Activity GROUP BY player_id);

-- Q26
-- Creating TABLE
CREATE Table if not exists Products (
    product_id int,
    product_name VARCHAR(100),
    product_category VARCHAR(100),
    constraint PK_Products PRIMARY KEY (product_id)
);

CREATE Table if NOT exists Orders (
    product_id int,
    order_date DATE,
    unit INT,
    constraint FK_Orders FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- inserting data
INSERT INTO Products VALUES (1,'Leetcode Solutions', 'Book'), 
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');

INSERT INTO Orders VALUES (1,'2020-02-05', 60),
(1,'2020-02-10', 70),
(2,'2020-01-18', 30),
(2,'2020-02-11', 80),
(3,'2020-02-17', 2),
(3,'2020-02-24', 3),
(4, '2020-03-01', 20),
(4,'2020-03-04', 30),
(4,'2020-03-04', 60),
(5,'2020-02-25', 50),
(5,'2020-02-27', 50),
(5,'2020-03-01', 50);

-- Quest - Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select product_name, feb_unit as unit from (
    select product_id, sum(unit) as feb_unit from Orders where Month(order_date) = 2 GROUP BY product_id having feb_unit >= 100) a JOIN
    Products on a.product_id = Products.product_id;

-- Q27
-- Creating TABLE
CREATE Table if not exists Users (
    user_id INT,
    name VARCHAR(100),
    mail VARCHAR(100),
    constraint PK_Users PRIMARY KEY (user_id)
);

-- inserting data
INSERT INTO Users VALUES (1,'Winston', 'winston@leetcode.com'),
(2,'Jonathan', 'jonathanisgreat'),
(3,'Annabelle', 'bella-@leetcode.com'),
(4,'Sally', 'sally.com@leetcode.com'),
(5,'Marwan', 'quarz#2020@leetcode.com'),
(6,'David', 'david69@gmail.com'),
(7,'Shapiro', '.shapo@leetcode.com');

-- Ques - Write an SQL query to find the users who have valid emails. A valid e-mail has a prefix name and a domain where:
--  * The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', 
-- and/or dash '-'. The prefix name must start with a letter.
--  ● The domain is '@leetcode.com'.
select * from Users where mail REGEXP '^[a-z]' and mail REGEXP '@leetcode.com$';

-- Q28
-- creating Customers
CREATE Table if not exists Customers (
    customer_id int,
    name VARCHAR(100),
    country VARCHAR(100),
    constraint PK_Customers PRIMARY KEY (customer_id)
);

--drop table Product;
create Table Product (
    product_id int,
    description VARCHAR(100),
    price VARCHAR(100),
    constraint Pk_Product PRIMARY KEY (product_id)
);

CREATE Table Orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    constraint Pk_Orders PRIMARY KEY (order_id)
);

-- inserting the data
insert INTO Customers VALUES (1,'Winston', 'USA'), (2,'Jonathan', 'Peru'),
(3,'Moustafa', 'Egypt');

insert INTO Product VALUES (10,'LC Phone', 300), (20, 'LC T-Shirt', 10),
(30, 'LC Book', 45), (40, 'LC Keychain', 2);

TRUNCATE Orders;
insert INTO Orders VALUES (1,1,10,'2020-06-10', 1), (2,1,20,'2020-07-01', 1),
(3,1,30,'2020-07-08', 2), (4,2,10,'2020-06-15', 2), (5,2,40,'2020-07-01',10),
(6,3,20,'2020-06-24', 2), (7,3,30,'2020-06-25',2), (9,3,30,'2020-05-08',3);


-- Quse - Write an SQL query to report the customer_id and customer_name of customers who have spent
--        at least $100 in each month of June and July 2020.

Select customer_id from (select customer_id, Sum(quantity*price) as total_price, Month(order_date) as order_month from Orders o JOIN Product p ON
o.product_id = p.product_id GROUP BY order_month, customer_id) t1;

-- Q29
-- create table
create Table if NOT exists TVProgram (
    program_date DATE,
    content_id INT,
    channel VARCHAR(100),
    constraint PK_TVProgram PRIMARY KEY (program_date, content_id)
);

CREATE Table Content (
    content_id VARCHAR(100),
    title VARCHAR(100),
    Kids_content ENUM('Y', 'N'),
    content_type VARCHAR(100),
    constraint PK_Content PRIMARY KEY (content_id)
);

-- inserting data
INSERT INTO TVProgram VALUES ('2020-06-10 08:00', 1,'LC-Channel'),
('2020-05-11 12:00', 2, 'LC-Channel'),
('2020-05-12 12:00', 3, 'LC-Channel'),
('2020-05-13 14:00', 4, 'Disney Ch'),
('2020-06-18 14:00', 4, 'Disney Ch'),
('2020-07-15 16:00', 5, 'Disney Ch');

INSERT INTO Content VALUES (1,'Leetcode Movie', 'N', 'Movies'),
(2,'Alg. for Kids', 'Y', 'Series'),
(3,'Database Sols', 'N', 'Series'),
(4,'Aladdin', 'Y', 'Movies'),
(5,'Cinderella', 'Y', 'Movies');

-- Ques - Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
select Distinct title from Content c JOIN TVProgram t on c.content_id = t.content_id where Kids_content = 'Y' and Month(program_date) = 6;

-- Q30
-- creating tables
CREATE Table NPV (
    id int,
    year int,
    npv int,
    constraint PK_npv PRIMARY KEY (id, year)
);

CREATE Table queries (
    id int,
    year int,
    constraint PK_queries PRIMARY KEY (id, year)
);

-- inserting data
INSERT INTO NPV VALUES (1,2018,100),
(7,2020,30), (13,2019,40), (1,2019,113), (2,2008, 121),
(3,2009,12), (11,2020,99), (7,2019,0);

INSERT INTO queries VALUES (1,2019), (2,2008), (3,2009), (7,2018), (7,2019),
(7,2020), (13,2019);

-- ques - Write an SQL query to find the npv of each query of the Queries table.
select q.id, q.year, npv from  NPV n JOIN queries q on n.id = q.id and n.year = q.year;

-- Q31
-- ques - Write an SQL query to find the npv of each query of the Queries table.
-- same as 30

-- Q32
-- Creating tables
CREATE Table Employees (
    id int,
    name VARCHAR(100),
    constraint PK_emp PRIMARY KEY (id)
);

CREATE Table EmployeeUNI (
    id INT,
    unique_id INT,
    constraint PK_empUNI PRIMARY KEY (id, unique_id)
);

-- inserting data
INSERT INTO Employees VALUES (1,'Alice'), (7,'Bob'), (11,'Meir'), (90,'Winston'),
(3, 'Jonathan');

INSERT INTO EmployeeUNI VALUES (3,1), (11,1), (90,3);

-- ques - Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.
select u.unique_id, e.name from Employees e LEFT JOIN EmployeeUNI u ON e.id = u.id;

-- Q33
-- Creating tables
CREATE Table Users (
    id int, name VARCHAR(100), constraint PK_user PRIMARY KEY (id)
);

CREATE Table Rides (
    id int, user_id int, distance INT, constraint PK_rides PRIMARY KEY (id)
);

-- inserting data
INSERT INTO Users VALUES (1, 'Alice'), (2,'Bob'), (3,'Alex'), (4,'Donald'), (7,'Lee'),
(13, 'Jonathan'), (19, 'Elvis');

INSERT INTO Rides VALUES (1,1,120), (2,2,317), (3,3,222), (4,7,100), (5,13,312), (6,19,50),
(7,7,120), (8,19,400), (9,7,230);

-- Ques - Write an SQL query to report the distance travelled by each user. Return the result table ordered
-- by travelled_distance in descending order, if two or more users travelled the same distance, order them by their name in ascending order.

with temptable(user_id, travelled_distance) as (select user_id, sum(distance) as travelled_distance from Rides GROUP BY user_id)
select name, case when travelled_distance is NULL then 0
else travelled_distance
end as travelled_distance from Users u LEFT JOIN temptable t on u.id = t.user_id ORDER BY travelled_distance desc, name;

