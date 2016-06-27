


########################################################################

# Querying Multiple Tables


# INNER JOINS


SELECT e.fname, e.lname, d.name
FROM employee AS e INNER JOIN department d
ON e.dept_id = d.dept_id;

#If the names of the columns used to join the two tables are identical
#you can use the USING subclause instead

SELECT e.fname, e.lname, d.name
FROM employee AS e INNER JOIN department d
    USING (dept_id);


########################################################################

# Joinning Three or More Tables

SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM account AS a INNER JOIN customer AS c
	ON a.cust_id = c.cust_id
	INNER JOIN employee AS e
	ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

#same result if changed the order of joints



#Using Subqueries AS Tables

SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account AS a INNER JOIN
	(SELECT emp_id, assigned_branch_id
		FROM employee
		WHERE start_date < '2007-01-01'
			AND (title = 'Teller' OR title = 'Head Teller')) AS e
ON a.open_emp_id = e.emp_id INNER JOIN
	(SELECT branch_id
		FROM branch
		WHERE name= 'Woburn Branch') AS b
ON e.assigned_branch_id = b.branch_id;



#Using the same Table Twice

SELECT a.account_id, e.emp_id,
	b_a.name open_brach, b_e.name emp_branch
FROM account AS a INNER JOIN branch AS b_a
	ON a.open_branch_id = b_a.branch_id
	INNER JOIN employee AS e
	ON a.open_emp_id = e.emp_id
	INNER JOIN branch AS b_e
	ON e.assigned_branch_id = b_e.branch_id
WHERE a.product_cd = 'CHK';




########################################################################

#Self-Joins

SELECT e.fname, e.lname,
	e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee AS e INNER JOIN employee AS e_mgr
	ON e.superior_emp_id = e_mgr.emp_id;


########################################################################


#Equi-Joins Versus Non-Equi-Joins
# This query joins two tables that have no foreign key relationship

SELECT e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
FROM employee AS e1 INNER JOIN employee AS 	e2
	ON e1.emp_id < e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';



########################################################################

#Join Conditions Versus Filter Conditions

SELECT a.account_id, a.product_cd, c.fed_id
FROM account AS a INNER JOIN customer AS c
	ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = 'B';

#same as

SELECT a.account_id, a.product_cd, c.fed_id
FROM account AS a INNER JOIN customer AS c
	ON a.cust_id = c.cust_id
AND c.cust_type_cd = 'B';

#or

SELECT a.account_id, a.product_cd, c.fed_id
FROM account AS a INNER JOIN customer AS c
WHERE a.cust_id = c.cust_id
	AND c.cust_type_cd = 'B';








