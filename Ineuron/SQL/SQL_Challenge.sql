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

-- inserting datar
insert into Views VALUES (1,3,5,'2019-08-01'), (1,3,6,'2019-08-02'), (2,7,7, '2019-08-02'), (2, 7, 6, '2019-08-02'), (4, 7,1, '2019-07-22'),
(3,4,4,'2019-07-21'), (3,4,4,'2019-07-21');