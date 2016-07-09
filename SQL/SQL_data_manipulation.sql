

########################################################################


#Working with String data

#String generation

CREATE TABLE string_tbl
	(char_fld CHAR(30),
	vchar_fld VARCHAR(30),
	text_fld TEXT);


INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This is char data',
	'This is varchar data',
	'This is text data');

#However, when including a very long text an error is produced

UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';


#To check which mode you are in, and then change it

SELECT @@session.sql_mode;
SET sql_mode='ansi';

SHOW WARNINGS;

#Now warning are shown, although the string is still cut off


###### Including single quotes, use double quote

UPDATE string_tbl
SET text_fld = 'This string didn''t work, but it does now'


#To show the quotes, ie. to export data

SELECT quote(text_fld)
FROM string_tbl;



###### Including special characters

SELECT CHAR (97, 98, 128, 138, 148);


#for example
SELECT CONCAT('Hol', CHAR(97));

#or on the other way around
SELECT ASCII('¥')




########################################################################


#String Manipulation

#Let's reset table string_tbl


DELETE FROM string_tbl;

INSERT INTO string_tbl(char_fld, vchar_fld, text_fld)
VALUES ('This string is 28 characters',
	'This string is 28 characters',
	'This string is 28 characters');



###### String functions that return numbers

SELECT LENGTH(char_fld) char_length
FROM string_tbl;


# POSITION: to show the position of certain character

SELECT POSITION('characters' IN vchar_fld)
FROM string_tbl;


# LOCATE: same as POSITION but allows a start position

SELECT LOCATE('is', vchar_fld, 5)
FROM string_tbl;


# STRCMP: String compare:
# returns -1 if string 1 comes before string 2
#          0 if string 1 identical to string 2
#          1 if string 1 comes after string 2

SELECT STRCMP('123', '234');


#LIKE adn REGEXP are also allowed

SELECT name, name LIKE '%ns' end_in_ns
FROM department;


#return 1 if fed_id matches pattern
SELECT cust_id, cust_type_cd, fed_id,
	fed_id REGEXP '.{3}-.{2}-.{4}' is_ss_no_format
FROM customer;



###### String functions that return strings

SELECT CONCAT(fname, ' ', lname, ' has been a ',
	title, ' since ', start_date) emp_narrative
FROM employee
WHERE title = 'Teller' OR title = 'Head Teller';



#INSERT, takes 4 arguments: the original string, the position at start
# the number of chars to replace, and the replacement string

SELECT INSERT('goodbye world', 9, 0, 'cruel ') string;



#to extract characters: SUBSTRING

SELECT SUBSTRING('goodbye cruel world', 9, 5);




########################################################################

#Working with numeric data


#Performing arithmetic functions


SELECT (37/59)/(78 - (8*6));
SELECT MOD(10, 4);
SELECT POW(2, 8);


#Controlling Number Precision

SELECT CEIL(72.445), FLOOR(72.445);
SELECT ROUND(72.5001);
SELECT ROUND(72.0909, 3);
SELECT TRUNCATE(72.0909, 3);

SELECT ROUND(17, -1), TRUNCATE(17, -1);




########################################################################

#Working with temporal data

#MySQL keeps two time zones: global time zone, and a session time zone


SELECT @@global.time_zone, @@session.time_zone;

SET time_zone = 'Europe/Zurich';


#String-to-date conversions

SELECT CAST('2008-09-17 15:30:00' AS DATETIME);


SELECT CAST('2008-09-17' as DATE) date_field,
	CAST('108:17:57' AS TIME) time_field;


#Fuctions for generating dates

#UPDATE individual
#SET birht_date = STR_TO_DATE('September 17, 2008', '%M %d %Y')
#WHERE cust_id = 9999;

SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();




########################################################################

#Manipulating temporal data

#Temporal functions that return dates

#DATE_ADD: add any kind of interval

SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);


#UPDATE employee
#SET birth_date = DATE_ADD(birth_date, INTERVAL '9-11' YEAR_MONTH)
#WHERE emp_id = 4789;



#Last day of the month
SELECT LAST_DAY('2008-09-17');


SELECT CURRENT_TIMESTAMP() current_est,
CONVERT_TZ(CURRENT_TIMESTAMP(), 'US/Eastern', 'UTC') current_utc;

#returns day of the week
SELECT DAYNAME('2008-09-18');


#get the year
SELECT EXTRACT(YEAR FROM '2008-09-18 22:19:05');


#Difference between dates
SELECT DATEDIFF('2009-09-03', '2009-06-24');





