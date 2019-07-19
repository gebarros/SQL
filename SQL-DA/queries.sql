/*######################################
#### Part of LESSSON 1 - BASIC #######
######################################*/
SELECT id, account_id, (standard_amt_usd/standard_qty) as uniq_price
FROM orders
LIMIT 10;


SELECT id, account_id, (poster_amt_usd*100)/(standard_amt_usd+gloss_amt_usd+poster_amt_usd) as prp
FROM orders
LIMIT 10;

SELECT name
FROM accounts
WHERE name LIKE 'C%';

SELECT name
FROM accounts
WHERE name LIKE '%one%';

SELECT name
FROM accounts
WHERE name LIKE '%s';

SELECT  name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

SELECT  name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name NOT LIKE '%s';

SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;


SELECT id 
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000)

SELECT name
FROM accounts
WHERE (name LIKE 'C%' or name LIKE 'W%') AND 
((primary_poc LIKE '%ana%' OR primary_poc LIKE 'Ana%') AND primary_poc NOT LIKE '%eana%');

/*######################################
#### LESSSON 2 - JOINs #######
######################################*/
SELECT *
FROM accounts
INNER JOIN orders 
ON accounts.id = orders.account_id;

SELECT o.standard_qty, o.gloss_qty, 
        o.poster_qty, a.website, 
        a.primary_poc
FROM orders as o 
INNER JOIN accounts as a 
ON o.account_id = a.id;

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
INNER JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

SELECT r.name region, s.name rep, a.name account
FROM region r
INNER JOIN sales_reps s 
ON r.id = s.region_id
INNER JOIN accounts a 
ON s.id = a.sales_rep_id
ORDER BY a.name;

SELECT r.name region, a.name account, (o.total_amt_usd/(o.total+0.01)) as unit_price
FROM orders o
INNER JOIN accounts a
ON o.account_id = a.id 
INNER JOIN sales_reps s 
ON a.sales_rep_id = s.id
INNER JOIN region r 
ON s.region_id = r.id; 

SELECT r.name region, s.name sales, a.name account 
FROM region r 
INNER JOIN sales_reps s
ON r.id = s.region_id
INNER JOIN accounts a 
ON s.id = a.sales_rep_id 
WHERE r.name = 'Midwest'
ORDER BY a.name;

SELECT r.name region, s.name sales, a.name account 
FROM region r 
INNER JOIN sales_reps s
ON r.id = s.region_id
INNER JOIN accounts a 
ON s.id = a.sales_rep_id 
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

SELECT r.name region, s.name sales, a.name account 
FROM region r 
INNER JOIN sales_reps s
ON r.id = s.region_id
INNER JOIN accounts a 
ON s.id = a.sales_rep_id 
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

SELECT r.name region, a.name account, (o.total_amt_usd/(o.total+0.01)) as unit_price
FROM orders o
INNER JOIN accounts a
ON o.account_id = a.id 
INNER JOIN sales_reps s 
ON a.sales_rep_id = s.id
INNER JOIN region r 
ON s.region_id = r.id
WHERE o.standard_qty > 100;

SELECT r.name region, a.name account, (o.total_amt_usd/(o.total+0.01)) as unit_price
FROM orders o
INNER JOIN accounts a
ON o.account_id = a.id 
INNER JOIN sales_reps s 
ON a.sales_rep_id = s.id
INNER JOIN region r 
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price;

SELECT r.name region, a.name account, (o.total_amt_usd/(o.total+0.01)) as unit_price
FROM orders o
INNER JOIN accounts a
ON o.account_id = a.id 
INNER JOIN sales_reps s 
ON a.sales_rep_id = s.id
INNER JOIN region r 
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price DESC;

SELECT DISTINCT w.channel, a.name
FROM accounts a
INNER JOIN web_events w 
ON a.id = w.account_id
WHERE a.id = '1001';

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o 
INNER JOIN accounts a 
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01';

/*######################################
#### LESSSON 3 - AGGREGATION #######
######################################*/

SELECT SUM(poster_qty) AS total_poster_ordered
FROM orders;

SELECT SUM(standard_qty) AS total_standard_ordered
FROM orders;

SELECT SUM(total_amt_usd) AS total_usd
FROM orders;

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS per_unit
FROM orders;

SELECT MIN(occurred_at) AS earliest_order
FROM orders;

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT MAX(occurred_at) AS latest_event
FROM web_events;

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

SELECT AVG(standard_qty) AS avg_standard_qty,
       AVG(gloss_qty) AS avg_gloss_qty,
       AVG(poster_qty) AS avg_poster_qty,
       AVG(standard_amt_usd) AS avg_standard_usd,
       AVG(gloss_amt_usd) AS avg_gloss_usd,
       AVG(poster_amt_usd) AS avg_poster_usd
FROM orders;

/*Option to calculate median, but its not the best solution*/

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

SELECT a.name as account, o.occurred_at as date_order
FROM accounts as a 
INNER JOIN orders as o
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) AS total_sales 
FROM accounts as a 
INNER JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name; 

SELECT a.name, w.channel, w.occurred_at
FROM web_events AS w 
INNER JOIN accounts AS a 
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;

SELECT channel, count(*)
FROM web_events
GROUP BY channel;

SELECT a.primary_poc
FROM accounts AS a 
INNER JOIN web_events AS w 
ON a.id = w.account_id
ORDER BY w.occurred_at 
LIMIT 1;

SELECT a.name, MIN(o.total_amt_usd) AS smallest_order 
FROM accounts as a 
INNER JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

SELECT r.name, count(*) AS total_reps
FROM region AS r 
INNER JOIN sales_reps AS s 
ON r.id = s.region_id
GROUP BY r.name
ORDER BY total_reps;

SELECT a.name, AVG(o.standard_qty) AS avg_standard_qty ,
               AVG(o.gloss_qty) AS avg_gloss_qty,
               AVG(o.poster_qty) AS avg_poster_qty
FROM accounts AS a 
INNER JOIN orders AS o 
ON a.id = o.account_id
GROUP BY a.name;

SELECT a.name, AVG(o.standard_amt_usd) AS avg_standard_usd ,
               AVG(o.gloss_amt_usd) AS avg_gloss_usd,
               AVG(o.poster_amt_usd) AS avg_poster_usd
FROM accounts AS a 
INNER JOIN orders AS o 
ON a.id = o.account_id
GROUP BY a.name;

SELECT s.name, w.channel, COUNT(*) AS total_occur
FROM sales_reps AS s 
INNER JOIN accounts AS a 
ON s.id = a.sales_rep_id
INNER JOIN web_events AS w 
ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY total_occur DESC;

SELECT r.name, w.channel, COUNT(*) AS total
FROM region AS r 
INNER JOIN sales_reps AS s 
ON r.id = s.region_id
INNER JOIN accounts AS a 
ON s.id = a.sales_rep_id
INNER JOIN web_events AS w 
ON a.id = w.account_id
GROUP BY r.name, w.channel
ORDER BY total DESC;

/*################################################################*/
SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id; 

/*AND*/

SELECT DISTINCT id, name
FROM accounts;

/*################################################################*/
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

/*AND*/

SELECT DISTINCT id, name
FROM sales_reps;

/*################################################################*/
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

SELECT a.name AS account, SUM(o.total_amt_usd) AS usd_total
FROM accounts AS a 
INNER JOIN orders AS o 
ON a.id = o.account_id
GROUP BY a.name
ORDER BY usd_total DESC
LIMIT 1;

SELECT a.name AS account, SUM(o.total_amt_usd) AS usd_total
FROM accounts AS a 
INNER JOIN orders AS o 
ON a.id = o.account_id
GROUP BY a.name
ORDER BY usd_total 
LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;

/*DATE*/
SELECT DATE_PART('year', occurred_at), SUM(total_amt_usd) AS total_usd 
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC; 

SELECT DATE_PART('year', occurred_at), COUNT(*) AS total_orders 
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC; 

SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o 
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*CASE*/
/*1- Write a query to display for each order, the account ID, total amount of the order,
 and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 
 or more, or smaller than $3000.*/

SELECT account_id, total,
CASE WHEN total > 3000 THEN 'Large'
ELSE 'Small' END AS order_level
FROM orders;

/*2 Write a query to display the number of orders in each of three categories, based on the 'total' amount of each order.
 The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.*/
SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
   WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
   ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;

/*3-We would like to understand 3 different levels of customers based on the amount associated with their purchases. 
The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd.
 Provide a table that includes the level associated with each account. 
You should provide the account name, the total sales of all orders for the customer, and the level.
 Order with the top spending customers listed first.*/
SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC; 

/*4- We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. 
Keep the same levels as in the previous question. Order with the top spending customers listed first. */
SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31' 
GROUP BY 1
ORDER BY 2 DESC;  

/*5- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. 
Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders.
Place the top sales people first in your final table.*/
SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;

/*6- The previous didn't account for the middle, nor the dollar amount associated with the sales. 
Management decides they want to see these characteristics represented as well. 
We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. 
The middle group has any rep with more than 150 orders or 500000 in sales. 
Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. 
Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!*/
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;

/*##########################################*/
/*SUBQUERIES*/
/*##########################################*/

/*1*/
SELECT DATE_TRUNC('day',occurred_at) AS day,
     channel, COUNT(*) AS events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;

SELECT *
FROM
(SELECT DATE_TRUNC('day',occurred_at) AS day,
     channel, COUNT(*) AS events
FROM web_events
GROUP BY 1,2) sub;

SELECT channel,
	AVG(events) AS avg_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
     channel, COUNT(*) AS events
     FROM web_events
     GROUP BY 1,2) sub
GROUP BY 1;

/*2*/
SELECT DATE_TRUNC('month', occurred_at) AS month_order,
       AVG(standard_qty) AS avg_standard_qty,
       AVG(gloss_qty) AS avg_gloss_qty,
       AVG(poster_qty) AS avg_poster_qty,
       SUM(total_amt_usd) AS total_usd
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
     (SELECT MIN(DATE_TRUNC('month',occurred_at))
     FROM orders)
GROUP BY 1;

/*Option: MIN(DATE_TRUNC('month',occurred_at) or DATE_TRUNC('month', MIN(occurred_at)) */

/*3- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/
SELECT t2.region, t2.max_sales, t3.sales_name
FROM
     (SELECT region, MAX(total_sales) AS max_sales
     FROM (
          SELECT s.name AS sales_name,
               r.name AS region,
               SUM(o.total_amt_usd) AS total_sales 
          FROM sales_reps s 
          INNER JOIN region r 
          ON s.region_id = r.id
          INNER JOIN accounts a 
          ON a.sales_rep_id = s.id
          INNER JOIN orders o 
          ON a.id = o.account_id
          GROUP BY 1, 2
          ORDER BY 3 DESC) t1 
     GROUP BY 1) t2
INNER JOIN (
     SELECT s.name AS sales_name,
          r.name AS region,
          SUM(o.total_amt_usd) AS total_sales 
     FROM sales_reps s 
     INNER JOIN region r 
     ON s.region_id = r.id
     INNER JOIN accounts a 
     ON a.sales_rep_id = s.id
     INNER JOIN orders o 
     ON a.id = o.account_id
     GROUP BY 1, 2
     ORDER BY 3 DESC) t3
ON t2.region = t3.region AND t2.max_sales = t3.total_sales
GROUP BY 1, 2, 3
ORDER BY 3 DESC;

/*For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?*/

SELECT r.name AS region_name,
       SUM(o.total_amt_usd) as total_sales, 
       COUNT(*) AS total
FROM region r 
INNER JOIN sales_reps s 
ON r.id = s.region_id
INNER JOIN accounts a 
ON s.id = a.sales_rep_id
INNER JOIN orders o 
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*How many accounts had more total purchases than the account name which has bought 
the most standard_qty paper throughout their lifetime as a customer?*/
SELECT COUNT(*)
FROM (SELECT a.name
       FROM orders o
       JOIN accounts a
       ON a.id = o.account_id
       GROUP BY 1
       HAVING SUM(o.total) > (SELECT total 
                   FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                         FROM accounts a
                         JOIN orders o
                         ON o.account_id = a.id
                         GROUP BY 1
                         ORDER BY 2 DESC
                         LIMIT 1) inner_tab)
             ) counter_tab;

/*For the customer that spent the most (in total over their lifetime as a customer) 
total_amt_usd, how many web_events did they have for each channel?*/

SELECT t1.id, t1.name, t2.channel, t2.total
FROM (SELECT a.id AS id, a.name AS name, 
             SUM(total_amt_usd) AS total_usd 
     FROM accounts a 
     INNER JOIN orders o
     ON a.id = o.account_id 
     GROUP BY 1,2
     ORDER BY 3 DESC
     LIMIT 1) t1
INNER JOIN ( 
          SELECT a.id AS id, a.name AS name, w.channel AS channel, COUNT(*) AS total
          FROM web_events w 
          INNER JOIN accounts a 
          ON w.account_id = a.id
          GROUP BY 1,2,3
          ORDER BY 1) t2 
ON  t1.id = t2.id AND t1.name = t2.name
ORDER BY 4 DESC;

/*What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*/
SELECT AVG(total_usd)
FROM (SELECT a.id AS id, a.name AS name, 
             SUM(total_amt_usd) AS total_usd 
     FROM accounts a 
     INNER JOIN orders o
     ON a.id = o.account_id 
     GROUP BY 1,2
     ORDER BY 3 DESC
     LIMIT 10) t1;

/*What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order,
 on average, than the average of all orders.*/
SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
    FROM orders o
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                   FROM orders o)) temp_table;


/* Common Table Expression: WITH statement*/

WITH events AS (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2)

SELECT channel, AVG(events) AS average_events
FROM events
GROUP BY channel
ORDER BY 2 DESC;

/* WITH: sintaxe para 2 ou mais tabelas*/
WITH table1 AS (
          SELECT *
          FROM web_events),

     table2 AS (
          SELECT *
          FROM accounts)

SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;

/*WITH: 1- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/
WITH t1 AS (
          SELECT s.name AS sales_name,
               r.name AS region,
               SUM(o.total_amt_usd) AS total_sales 
          FROM sales_reps s 
          INNER JOIN region r 
          ON s.region_id = r.id
          INNER JOIN accounts a 
          ON a.sales_rep_id = s.id
          INNER JOIN orders o 
          ON a.id = o.account_id
          GROUP BY 1, 2
          ORDER BY 3 DESC),

     t2 AS (SELECT region, MAX(total_sales) AS max_sales
            FROM  t1 
            GROUP BY 1),

     t3 AS (
          SELECT s.name AS sales_name,
               r.name AS region,
               SUM(o.total_amt_usd) AS total_sales 
          FROM sales_reps s 
          INNER JOIN region r 
          ON s.region_id = r.id
          INNER JOIN accounts a 
          ON a.sales_rep_id = s.id
          INNER JOIN orders o 
          ON a.id = o.account_id
          GROUP BY 1, 2
          ORDER BY 3 DESC)

SELECT t2.region, t2.max_sales, t3.sales_name
FROM t2
INNER JOIN t3
ON t2.region = t3.region AND t2.max_sales = t3.total_sales
GROUP BY 1, 2, 3
ORDER BY 3 DESC;

/*WITH: 3- How many accounts had more total purchases than the account name which has bought 
the most standard_qty paper throughout their lifetime as a customer?*/
WITH inner_tab AS ( SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                    FROM accounts a
                    JOIN orders o
                    ON o.account_id = a.id
                    GROUP BY 1
                    ORDER BY 2 DESC
                    LIMIT 1),
     counter_tab AS (SELECT a.name
                    FROM orders o
                    JOIN accounts a
                    ON a.id = o.account_id
                    GROUP BY 1
                    HAVING SUM(o.total) > (SELECT total 
                              FROM  inner_tab)
                         )
                    
SELECT COUNT(*)
FROM  counter_tab;

/*WITH: 4- For the customer that spent the most (in total over their lifetime as a customer) 
total_amt_usd, how many web_events did they have for each channel?*/

WITH t1 AS (SELECT a.id AS id, a.name AS name, 
             SUM(total_amt_usd) AS total_usd 
          FROM accounts a 
          INNER JOIN orders o
          ON a.id = o.account_id 
          GROUP BY 1,2
          ORDER BY 3 DESC
          LIMIT 1),
     
     t2 AS ( 
          SELECT a.id AS id, a.name AS name, w.channel AS channel, COUNT(*) AS total
          FROM web_events w 
          INNER JOIN accounts a 
          ON w.account_id = a.id
          GROUP BY 1,2,3
          ORDER BY 1)

SELECT t1.id, t1.name, t2.channel, t2.total
FROM  t1
INNER JOIN  t2 
ON  t1.id = t2.id AND t1.name = t2.name
ORDER BY 4 DESC;

/*WITH: 5- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*/
WITH t1 as (SELECT a.id AS id, a.name AS name, 
             SUM(total_amt_usd) AS total_usd 
          FROM accounts a 
          INNER JOIN orders o
          ON a.id = o.account_id 
          GROUP BY 1,2
          ORDER BY 3 DESC
          LIMIT 10)

SELECT AVG(total_usd)
FROM  t1;

/*WITH: 6- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order,
 on average, than the average of all orders.*/
WITH t1 AS (
          SELECT AVG(o.total_amt_usd) avg_all
          FROM orders o
          JOIN accounts a
          ON a.id = o.account_id),
     t2 AS (
          SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
          FROM orders o
          GROUP BY 1
          HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
          
SELECT AVG(avg_amt)
FROM t2;

/*##########################################*/
/*Cleaning Data: LEFT and RIGHT / UPPER e LOWER*/
/*##########################################*/

/*1- In the accounts table, there is a column holding the website for each company. 
The last three digits specify what type of web address they are using. 
A list of extensions (and pricing) is provided here. 
Pull these extensions and provide how many of each website type exist in the accounts table.*/

SELECT RIGHT(website, 3) AS type,
       COUNT(*) AS num_type
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*2- There is much debate about how much the name (or even the first letter of a company name) matters. 
Use the accounts table to pull the first letter of each company name to see the distribution of company
 names that begin with each letter (or number). */
SELECT LEFT(UPPER(name), 1) AS first_letter,
       COUNT(*) AS num 
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*3- Use the accounts table and a CASE statement to create two groups: 
one group of company names that start with a number and a second group of those company names that start with a letter.
 What proportion of company names start with a letter?*/
SELECT SUM(num) AS nums, SUM(letter) AS letter
FROM(SELECT name,
          CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END AS num,
          CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 0 ELSE 1 END AS letter
     FROM accounts) sub;

/*4- Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, 
and what percent start with anything else?*/
SELECT SUM(vowels) AS vowels, SUM(non_vowels) AS non_vowels
FROM(SELECT name,
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') THEN 1 ELSE 0 END AS vowels,
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') THEN 0 ELSE 1 END AS non_vowels
     FROM accounts) sub;

/*Cleaning Data: POSITION e STRPOS*/

/*1- Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc. */
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first_name,
       RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name  
FROM accounts;

/*Now see if you can do the same thing for every rep name in the sales_reps table.
 Again provide first and last name columns.*/
SELECT LEFT(name, STRPOS(name, ' ')-1) AS first_name,
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) AS last_name  
FROM sales_reps;

/*Cleaning Data: CONCAT*/

/*1 and 2- Each company in the accounts table wants to create an email address for each primary_poc. 
The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.*/
SELECT CONCAT(LOWER(first_name),'.',LOWER(last_name),'@',webname,'.com') AS email
FROM(SELECT REPLACE(LOWER(name), ' ', '') AS webname,
          LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first_name,
          RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name  
     FROM accounts) sub
ORDER BY 1;

/*3- We would also like to create an initial password, which they will change after their first log in. 
The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase),
 the first letter of their last name (lowercase), the last letter of their last name (lowercase), 
the number of letters in their first name, the number of letters in their last name, 
and then the name of the company they are working with, all capitalized with no spaces.*/

WITH sub AS (
     SELECT LEFT(LOWER(primary_poc), 1) AS first_letter_name,
          RIGHT(LEFT(LOWER(primary_poc), STRPOS(primary_poc, ' ')-1), 1) AS last_letter_name,
          LEFT(RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - STRPOS(primary_poc, ' ')),1) AS first_letter_sec_name,
          RIGHT(RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - STRPOS(primary_poc, ' ')),1) AS last_letter_sec_name,
          LENGTH(LEFT(LOWER(primary_poc), STRPOS(primary_poc, ' ')-1)) AS size_first_name,
          LENGTH(RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - STRPOS(primary_poc, ' '))) AS size_second_name,
          REPLACE(UPPER(name), ' ', '') AS company
     FROM accounts
)

SELECT CONCAT(first_letter_name,last_letter_name,first_letter_sec_name,
              last_letter_sec_name,size_first_name,size_second_name,company) AS pass
FROM sub;

/*Cleaning Data: CAST ou :: */
/*1*/
SELECT date,
     SUBSTRING(LEFT(date, STRPOS(date, ' ')-1) from 4 for 2) AS day,
     LEFT(date, 2) AS month,
     RIGHT(LEFT(date, STRPOS(date, ' ') -1), 4) AS year
     
FROM sf_crime_data;

/*OU*/

SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data;

/*2*/
WITH sub AS (
     SELECT date,
          SUBSTRING(LEFT(date, STRPOS(date, ' ')-1) from 4 for 2) AS day,
          LEFT(date, 2) AS month,
          RIGHT(LEFT(date, STRPOS(date, ' ') -1), 4) AS year
     FROM sf_crime_data)

SELECT CAST(CONCAT(year,'-',month,'-',day) AS date) AS formatted_date
FROM sub;

/*OU*/
SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data;


/*Cleaning Data: COALESCE */
/*Query para checar se há valores nulos*/
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
       COALESCE(o.account_id, a.id) account_id, o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, 
       o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
       COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, 
       COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, 
       COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
       COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT COUNT(*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
     COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, 
     COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, 
     COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
     COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

/*##########################################*/
      /*SQL Window Functions [Advanced]*/
/*##########################################*/
/*1- Create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. 
Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.*/
SELECT standard_amt_usd,
     SUM(standard_amt_usd) OVER(ORDER BY occurred_at) AS running_total
FROM orders;

/*2- Now, modify your query from the previous quiz to include partitions. 
Still create a running total of standard_amt_usd (in the orders table) over order time, but this time, 
date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. 
Your final table should have three columns: One with the amount being added for each row, one for the truncated date,
 and a final column with the running total within each year.*/

 SELECT standard_amt_usd,
     DATE_TRUNC('year', occurred_at) AS year,
     SUM(standard_amt_usd) OVER(PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders;

/* ROW_NUMBER e RANK*/

/*Select the id, account_id, and total variable from the orders table,
 then create a column called total_rank that ranks this total amount of paper ordered 
 (from highest to lowest) for each account using a partition. Your final table should have these four columns.*/
 SELECT id, account_id, total,
        RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders



/* Alias para multiplas WF*/
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER wf AS dense_rank,
       SUM(standard_qty) OVER wf AS sum_std_qty,
       COUNT(standard_qty) OVER wf AS count_std_qty,
       AVG(standard_qty) OVER wf AS avg_std_qty,
       MIN(standard_qty) OVER wf AS min_std_qty,
       MAX(standard_qty) OVER wf AS max_std_qty
FROM orders
WINDOW wf AS (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at))

SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))

/* Comparando uma linha com a linha anterior: LAG - Ex.:*/
SELECT account_id,
       standard_sum,
       LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag
FROM   (
        SELECT   account_id,
                 SUM(standard_qty) AS standard_sum
        FROM     demo.orders
        GROUP BY 1
       ) sub

SELECT account_id,
       standard_sum,
       LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag,
       standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference
FROM (
       SELECT account_id,
       SUM(standard_qty) AS standard_sum
       FROM orders 
       GROUP BY 1
      ) sub

/* Comparando uma linha com a linha seguinte: LEAD - Ex.:*/
SELECT account_id,
       standard_sum,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead
FROM   (
        SELECT   account_id,
                 SUM(standard_qty) AS standard_sum
        FROM     demo.orders
        GROUP BY 1
       ) sub

SELECT account_id,
       standard_sum,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_difference
FROM (
SELECT account_id,
       SUM(standard_qty) AS standard_sum
       FROM orders 
       GROUP BY 1
     ) sub

/* Imagine que você é um analista da Parch & Posey e deseja determinar como a receita total do pedido atual 
("total", significando das vendas de todos os tipos de papel) se compara à receita total do próximo pedido.*/

SELECT occurred_at,
     total_amt_usd,
     LEAD(total_amt_usd) OVER(ORDER BY occurred_at) AS lead,
     LEAD(total_amt_usd) OVER(ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM (
     SELECT occurred_at,
          SUM(total_amt_usd) AS total_amt_usd
     FROM orders
     GROUP BY 1
     ) sub;

/*Percentis: NTILE*/
/*UUse the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. 
Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, 
and one of four levels in a standard_quartile column.*/

SELECT account_id,
     occurred_at,
     standard_qty,
     NTILE(4) OVER(PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
FROM orders
ORDER BY 1 DESC;

/*Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders. 
Your resulting table should have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, 
and one of two levels in a gloss_half column*/
SELECT
       account_id,
       occurred_at,
       gloss_qty,
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
  FROM orders 
 ORDER BY account_id DESC;

/*Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders.
 Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and 
 one of 100 levels in a total_percentile column*/
SELECT
       account_id,
       occurred_at,
       total_amt_usd,
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
  FROM orders 
 ORDER BY account_id DESC;

/*##########################################*/
 /*SQL Advanced Joins & Performance Tuning*/
/*##########################################*/
/*FULL OUTER JOIN*/
SELECT * 
FROM sales_reps s 
FULL OUTER JOIN accounts a 
ON s.id= a.sales_rep_id;

/*If unmatched rows existed (they don't for this query), you could isolate them by adding the following line to the end of the query:*/
SELECT * 
FROM sales_reps s 
FULL OUTER JOIN accounts a 
ON s.id= a.sales_rep_id;
WHERE accounts.sales_rep_id IS NULL OR sales_reps.id IS NULL;

/*Write a query that left joins the accounts table and the sales_reps tables on each sale rep's ID number and joins it using the < comparison operator on 
accounts.primary_poc and sales_reps.name, like so:*/

SELECT a.name AS account, a.primary_poc, s.name AS rep_name
FROM accounts a 
LEFT JOIN sales_reps s 
ON a.sales_rep_id = s.id AND a.primary_poc < s.name;

/**/
/*Self JOIN*/
SELECT t1.id AS t1_id,
     t1.account_id AS t1_account_id,
     t1.occurred_at AS t1_occurred_at,
     t1.channel AS t1_channel,
     t2.id AS t2_id,
     t2.account_id AS t2_account_id,
     t2.occurred_at AS t2_occurred_at,
     t2.channel AS t2_channel
FROM web_events t1 
LEFT JOIN web_events t2 
ON t1.account_id = t2.account_id 
AND t1.occurred_at > t2.occurred_at
AND t1.occurred_at <= t2.occurred_at + INTERVAL '1 day'
ORDER BY t1.account_id, t2.occurred_at;

/*UNION*/
/*Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table. 
Then inspect the results and answer the subsequent quiz.*/
SELECT * 
FROM accounts
UNION all 
SELECT *
FROM accounts;

/*Add a WHERE clause to each of the tables that you unioned in the query above, 
filtering the first table where name equals Walmart and filtering the second table where name equals Disney. 
Inspect the results then answer the subsequent quiz.*/
SELECT *
    FROM accounts

UNION ALL

SELECT *
  FROM accounts;


SELECT * 
FROM accounts
WHERE name = 'Walmart'

UNION all 

SELECT *
FROM accounts
WHERE name = 'Disney';


WITH double_accounts AS (
    SELECT *
      FROM accounts

    UNION ALL

    SELECT *
      FROM accounts
)

SELECT name,
       COUNT(*) AS name_count
 FROM double_accounts 
GROUP BY 1
ORDER BY 2 DESC

