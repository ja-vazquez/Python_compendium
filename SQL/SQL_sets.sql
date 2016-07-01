

########################################################################

# Working with Sets


SELECT 1 num, 'abc' str
UNION
SELECT 9 num, 'xyz' str;

#The UNION operator
#The UNION and UNION ALL operators allow you to combine multiple data sets.
#UNION sorts the combined set and removes duplicates, whereas UNION ALL does not.


SELECT 'IND' type_cd, cust_id, lname name
FROM individual
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
FROM business;


#to show that union all doesn't remove duplicates

SELECT 'IND' type_cd, cust_id, lname name
FROM individual
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
FROM business
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
FROM business;


#Using a compound query

SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
	AND (title = 'Teller' OR title = 'Head Teller')
UNION ALL
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;


########################################################################

# The INTERSECT operator

# The EXCEPT operator



########################################################################

# Set Operation Rules

#Sorting compound queries Results
# You will need to choose from the column names in the first query of the compound query


SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller'
UNION
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV'
ORDER BY emp_id;


#Set operation Precedence

#In general compound queries containing three or more queries are evaluated in order from top to bottom.
#- Ypu can use multiple parentheses to combine queries
# -- Need to be careful about the order to place queries


SELECT cust_id
FROM account
WHERE product_cd IN ('SAV', 'MM')
UNION
SELECT a.cust_id
FROM account AS a INNER JOIN branch AS b
	ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch'
UNION ALL
SELECT cust_id
FROM account
WHERE avail_balance BETWEEN 500 AND 2500;

