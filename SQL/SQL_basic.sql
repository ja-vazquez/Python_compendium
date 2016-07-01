
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


#Renaming a column
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


#Deleting data
DELETE FROM person
WHERE person_id =2 ;