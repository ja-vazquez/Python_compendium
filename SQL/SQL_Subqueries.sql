


########################################################################

# Subqueries


SELECT MAX(account_id) FROM account;


SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE account_id = (SELECT MAX(account_id) FROM account);


# Subquery types
# Non correlated subqueries.


SELECT e.emp_id
FROM employee e INNER JOIN branch b
ON e.assigned_branch_id = b.branch_id
	WHERE e.title = 'Head Teller' AND b.city = 'Woburn';


SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE open_emp_id <> (SELECT e.emp_id
	FROM employee e INNER JOIN branch b
	ON e.assigned_branch_id = b.branch_id
		WHERE e.title = 'Head Teller' AND b.city = 'Woburn');





######### Multiple-row, Single-column queries

SELECT branch_id, name, city
FROM branch
WHERE name IN ('Headquarters', 'Quincy Branch');


SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id IN (SELECT superior_emp_id
	FROM employee);


#Careful with missing values
SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id NOT IN (SELECT superior_emp_id
	FROM employee
	WHERE superior_emp_id IS NOT NULL);



######### The ALL operator

# allows you to make comparisons between a single
# value and every value in a set


SELECT emp_id, fname, lname, title
FROM employee
	WHERE emp_id <> ALL (SELECT superior_emp_id
		FROM employee
		WHERE superior_emp_id IS NOT NULL);



SELECT account_id, cust_id, product_cd, avail_balance
FROM account
WHERE avail_balance < ALL (SELECT a.avail_balance
	FROM account a INNER JOIN individual i
		ON a.cust_id = i.cust_id
	WHERE i.fname = 'Frank' AND i.lname = 'Tucker');



######### The ANY operator

SELECT account_id, cust_id, product_cd, avail_balance
FROM account
WHERE avail_balance > ANY (SELECT a.avail_balance
	FROM account a INNER JOIN individual i
		ON a.cust_id = i.cust_id
	WHERE i.fname = 'Frank' AND i.lname = 'Tucker');




######### Multicolumn Subqueries


SELECT account_id, product_cd, cust_id
FROM account
WHERE open_branch_id = (SELECT branch_id
	FROM branch
	WHERE name = 'Woburn Branch')
	AND open_emp_id IN (SELECT emp_id
	FROM employee
	WHERE title = 'Teller' OR title = 'Head Teller');



#######################################################################


# Correlated Subqueries


SELECT c.cust_id, c.cust_type_cd, c.city
	FROM customer c
	WHERE 2 = (SELECT COUNT(*)
		FROM account a
		WHERE a.cust_id = c.cust_id);



SELECT c.cust_id, c.cust_type_cd, c.city
FROM customer c
WHERE (SELECT SUM(a.avail_balance)
	FROM account a
	WHERE a.cust_id = c.cust_id)
	BETWEEN 5000 AND 10000;



######### The EXISTS Operator

#when you want to identify that a relationship exists without
# regard for the quantity


SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance
FROM account a
WHERE EXISTS (SELECT 1
	FROM transaction t
	WHERE t.account_id = a.account_id
		AND t.txn_date < '2002-09-22');


#Subqueries are used heavily in UPDATE, DELETE and INSERT statements as well.


#dont run it
UPDATE account a
SET a.last_activity_date =
	(SELECT MAX(t.txn_date)
	FROM transaction t
	WHERE t.account_id = a.account_id)
WHERE EXISTS (SELECT 1
	FROM transaction t
	WHERE t.account_id = a.account_id);













