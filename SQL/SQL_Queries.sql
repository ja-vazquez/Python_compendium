


########################################################################
#Query Clauses

########################################################################
#The SELECT clause
# The select clause determines which of all possible columns should be included
# in the query s result set.

SELECT dept_id, name
FROM department;


# we can show 'whatever' we want
SELECT emp_id,
'ACTIVE',
emp_id* 3.1415,
UPPER(lname)
FROM employee;

#some built in functions
SELECT VERSION(),
    USER(),
    DATABASE();

#different ids
SELECT DISTINCT cust_id
    FROM account;


########################################################################

#The FROM clause
#The from clause defines the tables used by a query, along with the means
#of linking the tables together.


#Defining Table Aliases
SELECT e.emp_id, e.fname, e.lname,
	d.name dept_name
FROM employee AS e INNER JOIN department AS d
	ON e.dept_id = d.dept_id;




########################################################################

#The WHERE clause
#The where clause is the mechanism for filtering out unwanted rows from
#your result set

SELECT emp_id, fname, start_date, title
	FROM employee
	WHERE title='Head Teller'
		AND start_date > '2003-01-01';



########################################################################

#The GROUP BY and HAVING clauses
#Group the data by column values
#Having clause, which allows to filter group data in the same way the where clause
#lets you filter raw data


SELECT d.name, count(e.emp_id) num_employees
FROM department AS d INNER JOIN employee AS e
	ON d.dept_id = e.dept_id
GROUP BY d.name
HAVING count(e.emp_id) > 2;




