


########################################################################


#Grouping and Aggregates

#GROUP BY

SELECT open_emp_id
FROM account
GROUP BY open_emp_id;


SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id
HAVING COUNT(*) > 4;



###### Aggregate Functions


SELECT MAX(avail_balance) max_balance,
MIN(avail_balance) min_balance,
AVG(avail_balance) avg_balance,
SUM(avail_balance) tot_balance,
COUNT(*) num_accounts
FROM account
WHERE product_cd = 'CHK';


#grouping by products

SELECT product_cd,
MAX(avail_balance) max_balance,
MIN(avail_balance) min_balance,
AVG(avail_balance) avg_balance,
SUM(avail_balance) tot_balance,
COUNT(*) num_accounts
FROM account
GROUP BY product_cd;



###### Counting distinct values

#order all accounts
SELECT account_id, open_emp_id
FROM account
ORDER BY open_emp_id;


#and count distinct ones
SELECT COUNT(DISTINCT open_emp_id)
FROM account;



#Using expressions
SELECT MAX(pending_balance - avail_balance) max_uncleared
FROM account;



########################################################################

###### Generating groups


#Single-column grouping
SELECT product_cd, SUM(avail_balance) prod_balance
FROM account
GROUP BY product_cd;


#Multicolumn grouping
SELECT product_cd, open_branch_id,
SUM(avail_balance) tot_balance
FROM account
GROUP BY product_cd, open_branch_id;


#Grouping via expressions
SELECT EXTRACT(YEAR FROM start_date) year,
COUNT(*) how_many
FROM employee
GROUP BY EXTRACT(YEAR FROM start_date);



#Generating Rollups, sum over the groups
SELECT product_cd, open_branch_id,
SUM(avail_balance) tot_balance
FROM account
GROUP BY product_cd, open_branch_id, WITH ROLLUP;



###### Group Filter conditions

SELECT product_cd, SUM(avail_balance) prod_balance
FROM account
WHERE status = 'ACTIVE'
GROUP BY product_cd
HAVING SUM(avail_balance) >= 10000;
















