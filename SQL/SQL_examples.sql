
####################################

# basic Mysql commands
#Used on Sequel-Pro
#with Mysql 5.7.13

#\h for help

# list databases
SHOW databases;
USE name_of_db;


# list tables
SHOW tables;

# to look at the table definitions
DESC name_of_table;


#The insert statement
INSERT INTO person
    (person_id, fname, lname, gender, birth_date)
VALUES (null, 'Jose', 'Vazquez', 'M', '1982-09-06');


#Show content
SELECT * FROM person;

#or
SELECT person_id, fname, lname, birth_date
FROM person
WHERE lname='Vazquez';


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