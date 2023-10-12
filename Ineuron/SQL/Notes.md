SQL NOTES CONTENT
1. [Intro](#chap1)
2. [SYNTAX](#chap2)
3. [DATABASE](#chap3)


<a id="chap1"></a>
## Section 1: Intro

<p>
SQL is a Standard - BUT....there are different versions of the SQL language.

However, to be compliant with the ANSI standard, they all support at least the major commands (such as SELECT, UPDATE, DELETE, INSERT, WHERE) in a similar manner.

SQL keywords are NOT case sensitive: select is the same as SELECT
</p>

<p>
RDBMS - Relational Database Management System.
RDBMS is the basis for SQL, and for all modern database systems such as MS SQL Server, IBM DB2, Oracle, MySQL, and Microsoft Access.

The data in RDBMS is stored in database objects called tables.<br>
A table is a collection of related data entries and it consists of columns and rows.
</p>

Most Important SQL Commands
 - SELECT - extracts data from a database
 - UPDATE - updates data in a database
 - DELETE - deletes data from a database
 - INSERT INTO - inserts new data into a database
 - CREATE DATABASE - creates a new database
 - ALTER DATABASE - modifies a database
 - CREATE TABLE - creates a new table
 - ALTER TABLE - modifies a table
 - DROP TABLE - deletes a table
 - CREATE INDEX - creates an index (search key)
 - DROP INDEX - deletes an index

<a id="chap2"></a>
## Section 2: SQL Syntax

- SELECT - used to select data from a database. To fast query result, use column names with Select
- SELECT DISTINCT - used to return only distinct values.
- WHERE - used to filter records. For faster query result, use indexed cols
- ORDER BY - used to sort the result-set in ascending or desc order.
- INSERT INTO - used to insert new records in a table. Syntax (INSERT INTO table_name (col1, col2, col3) VALUES (val1, val2) or INSERT INTO table_name values (val1, val2))
- NULL - a field with no value. use (is null or is not null instead =)
- UPDATE - used to modify the existing records in a table.
- DELETE - used to delete existing records in a table. (DELETE FROM table_name WHERE condition). To delete table completely, use DROP statement.
- SELECT TOP - used to specify # records to return. No all db support this.
    - SQL server/ MS access:
    ```
    SELECT TOP number|percent column_name(s) 
    FROM table_name
    WHERE condition;
    ```
    - MySQL syntax:
    ```
    SELECT column_name(s)
    FROM table_name
    WHERE condition
    LIMIT number;
    ```
    - Oracle 12:
    ```
    SELECT column_name(s)
    FROM table_name
    ORDER BY column_name(s)
    FETCH FIRST number ROWS ONLY;
    ```
    - Oracle 12 older version:
    ```
    SELECT *
    FROM (SELECT column_name(s) FROM table_name ORDER BY column_name(s))
    WHERE ROWNUM <= number;
    ```
- AGGREGATION FUNCTIONS
    - MIN(), MAX()
    - COUNT()
    - SUM()
    - AVG()
- LIKE - used in a WHERE clause to search for a specified pattern in a col. There are 2 wildcards often used in conjunction with LIKE operator (% represents zero, one, or multiple characters. _ represents one, single char)
- WILDCARDS CHAR
    - [] - represent any single char within the brackets. eg. '[arb]%'
    - ^ - represent any char not in the brackets. 
    - \- represent any single char within the specified range.
    - {} - represent any escaped character.
- IN - used to specify multiple values in a where clause.
- BETWEEN - used to specify a range (begin and end value)
<BR>

    **SQL Aliases**
    <BR> used to give a table, or a col, a temporary name. created with AS keyword. if alias have space character eg. table 2 then use like [table 2] or "table 2".

    **SQL JOINS**
    <br>
    - Types:
        - (INNER) JOIN - matching values in both tables.
        - LEFT (OUTER) JOIN - all rec from left and matched rec from right.
        - RIGHT (OUTER) JOIN - all rec from right and matched rec from left.
        - FULL (OUTER) JOIN - all records from both tables.
        - SELF JOIN - a regular join, but the table is joined with itself.
        ```
        SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
        FROM Customers A, Customers B
        WHERE A.CustomerID <> B.CustomerID
        AND A.City = B.City
        ```

- UNION - used to combine the result-set of two or more SELECT statements. all select statement have same # columns and same data types.
- UNION ALL - UNION selects only distinct values by default. To allow duplicate values, use UNION ALL.
- GROUP BY - group rows that have the same values. It is often used with aggregate functions to group the result-set.
- HAVING - used with GROUP BY as where clause can't be used with aggregate functions.
- EXISTS - used to test for the existence of any record in a subquery. It return TRUE if subquery returns one or more records.
    ```
    SELECT column_name(s)
    FROM table_name
    WHERE EXISTS
    (SELECT column_name FROM table_name WHERE condition);
    ```
- ANY and ALL - allows to perform a comparison between a single column value and a range of other values.
    - ANY - means that the condition will be true if the operation is true for any of the values in the range.
        ```
        SELECT column_name(s)
        FROM table_name
        WHERE column_name operator ANY
        (SELECT column_name
        FROM table_name
        WHERE condition);
        ```
    - ALL - returns TRUE if ALL of the subquery values meet the condition. used with SELECT, WHERE & HAVING statements.
- SELECT INTO - used to copy data from one table into a new table.
    ```
    SELECT *
    INTO newtable [IN externaldb]
    FROM oldtable
    WHERE condition;
    ```
    - To move data from more than one table use below query
        ```
        SELECT Customers.CustomerName, Orders.OrderID
        INTO CustomersOrderBackup2017
        FROM Customers
        LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
        ```
- INSERT INTO SELECT - copies data from one table and insert it into another table.
- CASE Expression - goes through conditions and returns a value when the first condition is met. So, once a condition is true, it will stop reading and return the result. if no condition are true, it returns the value in the ELSE clause. If no else part, then return null.
    ```
    CASE
        WHEN condition1 THEN result1
        WHEN condition2 THEN result2
        WHEN conditionN THEN resultN
        ELSE result
    END;
    ```
- NULL Functions: 
    - IFNULL() - lets return alternative value & can use in MySQL. eg. IFNULL(col1, 0)
    - ISNULL() - same as IFNULL BUT use this in SQL server.
    - COALESCE() - same as IFNULL() but can be used in all. eg. COALESCE(col1, 0)
    - NVL() - same as IFNULL but used in Oracle only.

    **STORED PROCEDURE**
    - Stored procedure is like function except that stored procedures are written once then they can be called many times without having the overhead associated with each call.
    - CREATE PROCEDURE - creates procedure that is stored on the database server side.
        - SYNTAX
        ```
        CREATE PROCEDURE procedure_name
        AS
        sql_statement
        GO;

        EXEC procedure_name
        ```
        - with one parameter:
        ```
        CREATE PROCEDURE SelectAllCustomers @City nvarchar(30)
        AS
        SELECT * FROM Customers WHERE City = @City
        GO;

        EXEC SelectAllCustomers @City = 'London';
        ```
- COMMENTS - (-) - single line, (/*...*/) - multiline


<a id="chap3"></a>
## Section 3: DATABASE operations

- CREATE DATABASE dbname - create a db.
- SHOW DATABASES - to show all available dbs.
- DROP DATABASE dbname - drop an existing db.
- BACKUP DATABASE dbname TO DISK = 'filepath' - to create a full backup of an existing db.
- BACKUP DATABASE dbname TO DISK = 'filepath' WITH DIFFERENTIAL - take backup of the part that have changed since the last full backup.
- CREATE TABLE - create a new table
    - SYNTAX:
    ```
    CREATE TABLE Persons (
        PersonID int,
        LastName varchar(255),
        FirstName varchar(255),
        Address varchar(255),
        City varchar(255)
    );
    ```
    - CTAS using another table: new table will be filled with existing values from the old table.
    ```
    CREATE TABLE TestTable AS
    SELECT customername, contactname
    FROM customers;
    ```
- DROP TABLE table_name - used to drop an existing table in a database.
- TRUNCATE TABLE table_name - used to delete the data not table.
- ALTER TABLE - used to add, delete, or modify columns. also to add and drop various constraints.
    - SYNTAX:
    ```
    #ADD STATEMENT:
    ALTER TABLE Customers
    ADD Email varchar(255);

    #DROP COL:
    ALTER TABLE Customers
    DROP COLUMN Email;

    #RENAME COL:
    ALTER TABLE table_name
    RENAME COLUMN old_name to new_name;

    #ALTER TABLE - ALTER/MODIFY DATATYPE:
    for SQL server/ MS access:
    ALTER TABLE table_name
    ALTER COLUMN column_name datatype;

    for MySQL/Oracle (prior):
    ALTER TABLE table_name
    MODIFY COLUMN column_name datatype;

    for Oracle 10G and later:
    ALTER TABLE table_name
    MODIFY column_name datatype;
    ```
- CREATE Constraints - used to specify rules for data in a table.
    - SYNTAX:
    ``` 
    CREATE TABLE table_name (
        column1 datatype constraint,
        column2 datatype constraint,
        column3 datatype constraint,
        ....
    );
    ```
    **NOT NULL** - Ensures that a column cannot have a NULL value
    ```
    CREATE TABLE Products (
        ID INT NOT NULL,
        NAME VARCHAR(255) NOT NULL,
        AGE INT
    );

    ALTER TABLE PRODUCTS
    ALTER COLUMN AGE INT NOT NULL;
    ```

    **UNIQUE** - Ensures that all values in a column are different
    ```
    #SQL Server / Oracle / MS access:
    CREATE TABLE Products (
        ID INT NOT NULL UNIQUE,
        NAME VARCHAR(255) NOT NULL,
        AGE INT
    );

    #MySQL
    CREATE TABLE Products (
        ID INT NOT NULL,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        UNIQUE(ID)
    );

    #UNIQUE Constraint on Multiple columns (works on all sql)
    CREATE TABLE Products (
        ID INT NOT NULL UNIQUE,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        CONSTRAINT UC_Products UNIQUE (ID, NAME)
    );

    # ADD CONSTRAINT IN AN EXISTING TABLE
    ALTER TABLE Products
    ADD UNIQUE(ID);

    #MULTIPLE COLUMNS
    ALTER TABLE Products
    ADD CONSTRAINT UC_Products UNIQUE(ID, NAME);

    #DROP UNIQUE CONSTRAINT
    #MySQL
    ALTER TABLE Products
    DROP INDEX UC_Products

    #SQL Server / Oracle / MS access:
    ALTER TABLE Products
    DROP CONSTRAINT UC_Products
    ```
    **PRIMARY KEY** - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
    ```
    #SQL Server / Oracle / MS access:
    CREATE TABLE Products (
        ID INT NOT NULL PRIMARY KEY,
        NAME VARCHAR(255) NOT NULL,
        AGE INT
    );

    #MySQL
    CREATE TABLE Products (
        ID INT NOT NULL,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        PRIMARY KEY (ID)
    );

    #UNIQUE Constraint on Multiple columns (works on all sql)
    CREATE TABLE Products (
        ID INT NOT NULL UNIQUE,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        CONSTRAINT PK_Products PRIMARY KEY (ID, NAME)
    );
    **HERE only one primary key (PK_Products) (made up of two columns)

    # ADD CONSTRAINT IN AN EXISTING TABLE
    ALTER TABLE Products
    ADD PRIMARY KEY (ID);

    #MULTIPLE COLUMNS
    ALTER TABLE Products
    ADD CONSTRAINT PK_Products PRIMARY KEY (ID, NAME);

    #DROP PRIMARY KEY CONSTRAINT
    #MySQL
    ALTER TABLE Products
    DROP PRIMARY KEY;

    #SQL Server / Oracle / MS access:
    ALTER TABLE Products
    DROP CONSTRAINT PK_Products;
    ```
    **FOREIGN KEY** - Prevents actions that would destroy links between tables
    ```
    #SQL Server / Oracle / MS access:
    CREATE TABLE Orders (
        OrderID int NOT NULL PRIMARY KEY,
        OrderNumber int NOT NULL,
        PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
    );

    #MySQL
    CREATE TABLE Orders (
        OrderID int NOT NULL,
        OrderNumber int NOT NULL,
        PersonID int,
        PRIMARY KEY (OrderID),
        FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
    );

    #UNIQUE Constraint on Multiple columns (works on all sql)
    CREATE TABLE Orders (
        OrderID int NOT NULL,
        OrderNumber int NOT NULL,
        PersonID int,
        PRIMARY KEY (OrderID),
        CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
    );
    **HERE only one primary key (PK_Products) (made up of two columns)

    #alter table
    ALTER TABLE Orders
    ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

    ALTER TABLE Orders
    ADD CONSTRAINT FK_PersonOrder
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
    ```
    **CHECK** - Ensures that the values in a column satisfies a specific condition
    ```
    #SQL Server / Oracle / MS access:
    CREATE TABLE Products (
        ID INT NOT NULL PRIMARY KEY,
        NAME VARCHAR(255) NOT NULL,
        AGE INT CHECK (AGE>=18)
    );

    #MySQL
    CREATE TABLE Products (
        ID INT NOT NULL,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        PRIMARY KEY (ID),
        CHECK (AGE>=18)
    );

    #UNIQUE Constraint on Multiple columns (works on all sql)
    CREATE TABLE Products (
        ID INT NOT NULL UNIQUE,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        CITY VARCHAR(255),
        CONSTRAINT CHK_Products CHECK (AGE>=18 AND CITY='GURUGRAM')
    );

    # ADD AND DROP CONSTRAINT is same as primary key
    ```
    **DEFAULT** - Sets a default value for a column if no value is specified
    ```
    CREATE TABLE Products (
        ID INT NOT NULL UNIQUE,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        CITY VARCHAR(255) DEFAULT 'GURUGRAM',
        CONSTRAINT CHK_Products CHECK (AGE>=18 AND CITY='GURUGRAM')
    );
    ```
    **CREATE INDEX** - Used to create and retrieve data from the database very quickly.
    ```
    # create index where duplicate values are allowed
    CREATE INDEX index_name
    ON table_name (col1, col2, col3,...);

    #create unique index where no duplicate allowed
    CREATE UNIQUE INDEX index_name
    ON table_name (col1, col2, col3,...);

    #MySQL
    ALTER TABLE table_name
    DROP INDEX index_name;
    ```
- AUTO INCREMENT Field: allows a unique no to be generated automatically when a new record is inserted into a table.
    ```
    CREATE TABLE Products (
        ID INT NOT NULL AUTO_INCREMENT,
        NAME VARCHAR(255) NOT NULL,
        AGE INT,
        CITY VARCHAR(255) DEFAULT 'GURUGRAM',
        CONSTRAINT CHK_Products CHECK (AGE>=18 AND CITY='GURUGRAM')
    );

    #BY default, it starts from 1 but can be changed:
    ALTER TABLE Products AUTO_INCREMENT=100;
    ```
- Working with Dates - 
    - SQL DATE DATA TYPES:(1. MySQL, then SQL server)
        - DATE - format YYYY-MM-DD
        - DATETIME - format YYYY-MM-DD HH:MI:SS
        - TIMESTAMP - format YYYY-MM-DD HH:MI:SS
        - YEAR - format YYYY or YY
        <br>
        sql server
        - DATE - format YYYY-MM-DD
        - DATETIME - format YYYY-MM-DD HH:MI:SS
        - SMALLDATETIME - format YYYY-MM-DD HH:MI:SS
        - TIMESTAMP - format: a unique number
- VIEWS - a virtual table based on the result set of an SQL statement
    ```
    #create a view
    CREATE VIEW view_name AS
    SELECT col1, col2, ...
    FROM table_name
    WHERE condition;

    #create or replace view syntax
    CREATE OR REPLACE VIEW view_name AS
    SELECT col1, col2,...
    FROM table_name
    where condition;

    #drop a view
    DROP VIEW IF EXISTS view_name;
    ```


    







