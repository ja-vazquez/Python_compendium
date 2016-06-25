

########################################################################

#Condition types


########################################################################

# Equality Conditions   =

SELECT pt.name product_type, p.name product
FROM product AS p INNER JOIN product_type AS pt
  ON p.product_type_cd = pt.product_type_cd
WHERE pt.name = 'Customer Accounts';



 #Inequality conditions  != or <>

SELECT pt.name product_type, p.name product
FROM product AS p INNER JOIN product_type AS pt
  ON p.product_type_cd = pt.product_type_cd
WHERE pt.name <> 'Customer Accounts';



#Range conditions

SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date < '2002-01-01'
  AND start_date > '2000-01-01';



#The BETWEEN operator

SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date BETWEEN '2000-01-01'  AND '2002-01-01';


SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE avail_balance BETWEEN 3000 AND 5000;


#string ranges

SELECT cust_id, fed_id
FROM customer
WHERE cust_type_cd = 'I'
  AND fed_id BETWEEN '500-00-0000' AND '999-99-9999';



########################################################################

#Membership conditions

#IN or NOT IN
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN ('CHK', 'SAV', 'CD', 'MM');


#Using subqueries
#The subquery returns a set of four values, and the main query checks to see
#whether the value of the product_cd column can be found in the set that the
#subquery returned.

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN (SELECT product_cd FROM product
  WHERE product_type_cd = 'ACCOUNT');



########################################################################

#Matching conditions

SELECT emp_id, fname, lname
FROM employee
WHERE LEFT(lname, 1) = 'T';


#using wildcards with LIKE

# _ exactly one character
# % any number of characters
#     F% strings beginning with F, %t string ending with t


SELECT emp_id, fname, lname
FROM employee
WHERE lname LIKE 'F%' OR lname LIKE 'G%';


#Using regular expressions REGEXP

SELECT emp_id, fname, lname
FROM employee
WHERE lname REGEXP '^[FG]';



#IS NULL

SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NULL;









