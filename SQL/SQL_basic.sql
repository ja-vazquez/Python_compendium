
########################################################################

# basic Mysql commands
#Used on Sequel-Pro
#with Mysql 5.7.13

#to log in in to MySQL system
mysql -u root -p

#\h for help


# list databases
SHOW databases;
USE name_of_db;

#or create a database
CREATE DATABASE publications;
USE publications;


#Canceling a command  \c will ignore everything you typed
meaningless giberrish to mysql \c


#Creating users
GRANT PRIVILEGES ON database.object TO 'username'@'hostname'
    IDENTIFIED BY password


# list tables
SHOW tables;


#or Creating a table
CREATE TABLE classics(
	author VARCHAR(128),
	title VARCHAR(128),
	type VARCHAR(16),
	year CHAR(4)) ENGINE MyISAM;



# to look at the table definitions
DESCRIBE classics;


#The AUTO_INCREMENT data type
ALTER TABLE classics
ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT KEY;


#Removing columns
ALTER TABLE classics
	DROP id;


#Adding data to the table
INSERT INTO classics (author, title, type, year)
	VALUES('Mark Twain', 'The adventures of Tom Sawyer', 'Fiction', '1876');
INSERT INTO classics (author, title, type, year)
	VALUES('Jane Austen', 'Pride and Prejdice', 'Fiction', '1811');
INSERT INTO classics (author, title, type, year)
	VALUES('Charles Darwin', 'The evolution of Species', 'Non-Fiction', '1856');


#Show content
SELECT * FROM classics;


#or
SELECT author, title, type, year
FROM classics
WHERE author='Vazquez';



#Renaming a Table
ALTER TABLE classics RENAME pre1900;


#Changing the data type of a column
ALTER TABLE classics MODIFY year SMALLINT;


#Adding a new column
ALTER TABLE classics ADD pages SMALLINT UNSIGNED;


#Renaming a column (type -> category)
ALTER TABLE classics CHANGE type category VARCHAR(16);


#Removing a column
ALTER TABLE classics DROP pages;


#Deleting a table
DROP TABLE disposable;


#Creating an INDEX
#The way to achieve fast searches is to add an index.
ALTER TABLE classics ADD INDEX(author(20));
#or
CREATE INDEX author ON classics(author(20));



#Updating data
UPDATE person
SET street = '122 st',
    city = 'Boston',
    country='usa',
    postal_code='02138'
WHERE person_id=1;


ALTER TABLE classics ADD isbn CHAR(13);
UPDATE classics SET isbn='12345' WHERE year ='1876';
UPDATE classics SET isbn='23456' WHERE year ='1811';
UPDATE classics SET isbn='34567' WHERE year ='1856';
UPDATE classics SET isbn='45678' WHERE year ='1841';



########################################################################

# Querying a MySQL Database

#SELECT
SELECT author, title FROM classics;
SELECT title, isbn FROM classics;


#SELECT COUNT
#displays the number of rows in the table
SELECT COUNT(*) c_all from classics;


#SELECT DISTINCT
INSERT INTO classics(author, title, category, year, isbn)
VALUES('Charles Dickens', 'Little Dorrit', 'Fiction', '1857', '56789');

SELECT author FROM classics;
SELECT DISTINCT author FROM classics;


#DELETE
DELETE FROM classics WHERE title='Little Dorrit';


#WHERE
SELECT author, title FROM classics WHERE author='Mark Twain';
SELECT author, title FROM classics WHERE isbn='12345';


#LIKE
SELECT author, title FROM classics WHERE author LIKE 'Charles%';
SELECT author, title FROM classics WHERE title LIKE '%and%';



#LIMIT (where should start the display, how many to return)
SELECT author, title FROM classics LIMIT 3;
SELECT author, title FROM classics LIMIT 1,2;
SELECT author, title FROM classics LIMIT 3,1;


#FULLTEXT
#allows super-fast searches of entire columns of text
ALTER TABLE classics ADD FULLTEXT(author,title);



#MATCH AGAINST
#It lets you enter multiple words in a search query
#and check them against all words in the FULLTEXT

SELECT author, title FROM classics
WHERE MATCH(author, title) AGAINST ('curiosity shop');

SELECT author, title FROM classics
WHERE MATCH(author, title) AGAINST ('tom sawyer');



#MATCH AGAINST ... IN Boolean mode
# + must be included, - excluded

SELECT author, title FROM classics
WHERE MATCH(author, title)
AGAINST('+charles -species' IN BOOLEAN MODE);



#UPDATE SET
UPDATE classics
SET category='Classic Fiction'
WHERE category='Classic Fictional';


#ORDER BY
SELECT author, title FROM classics ORDER BY author;
SELECT author, title FROM classics ORDER BY title DESC;

SELECT author, title, year FROM classics ORDER BY author ASC, year DESC;



#GROUP BY
SELECT category, COUNT(author) FROM classics GROUP BY category;




########################################################################

#Joining Tables

CREATE TABLE customers(
name VARCHAR(128),
isbn VARCHAR(13),
PRIMARY KEY (isbn)) ENGINE MyISAM;

INSERT INTO customers(name, isbn) VALUES
('Jose Bloggs', '12345'),
('Mary Smith', '23456'),
('Jack Wilson', '34567');

SELECT * FROM customers;


#Joining two tables into a single SELECT
SELECT name,author, title FROM customers, classics
WHERE customers.isbn = classics.isbn;


#NATURAL JOIN
#joins columns that have the same name
SELECT name, author, title FROM customers NATURAL JOIN classics;


#JOIN ON
#to specify the column on which you want to join two tables
SELECT name, author, title FROM customers
JOIN classics ON customers.isbn = classics.isbn;



#USING AS
#to save some typing in long queries
SELECT name, author, title
FROM customers AS cust, classics AS class
WHERE cust.isbn = class.isbn;




#Using Logical Operators
SELECT author, title FROM classics
WHERE author LIKE 'Charles%' AND author LIKE '%Darwin';



########################################################################

#TRANSACTION
#In some applications, it is vitally important that a sequence of queries runs in the correct order and that
#every singles query successfully completes.
#you have to be using MySQL's InnoDB storage engine.


CREATE TABLE accounts(
number INT, balance FLOAT, PRIMARY KEY(number)
) ENGINE InnoDB;

DESCRIBE accounts;

INSERT INTO accounts(number, balance) VALUES(12345, 1025.50);
INSERT INTO accounts(number, balance) VALUES(67890, 140.50);



#Transactions in MySQL start with either a BEGIN
#or a START TRANSACTION statement.


#BEGIN
BEGIN;
UPDATE accounts SET balance=balance + 25.11 WHERE number=12345;

#COMMIT
#When you are satisfied that a series of queries in a transaction has
#successfully completed.

COMMIT;
SELECT * FROM accounts;


#using ROLLBACK
BEGIN;
UPDATE accounts SET balance= balance - 250 WHERE number =12345;
UPDATE accounts SET balance= balance + 250 WHERE number =67890;

SELECT * FROM accounts;


#Let s assume that something went wrong and you wish to undo this transaction

ROLLBACK;
SELECT * FROM accounts;


#EXPLAIN
#Using explain, you can get a snapshot of any query to find out whether you
#could issue it in a better or more efficient way.


EXPLAIN SELECT * FROM accounts WHERE number='12345';




