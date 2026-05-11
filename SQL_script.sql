-- SECTION 1: JOINS

-- Join only matching values from orders and customers tables
SELECT o."Order No", c."Customer Name", o."Sales"
FROM orders o
INNER JOIN customers c ON o."Customer ID" = c."Customer ID";


-- Join all values from customers and their orders including those with no orders
SELECT o."Order No", c."Customer Name", o."Sales"
FROM customers c
LEFT JOIN orders o ON o."Customer ID" = c."Customer ID";


-- Show all orders and their customer including orders with no customers
SELECT o."Order No",c."Customer Name"
FROM orders o
RIGHT JOIN customers c ON o."Customer ID" = c."Customer ID"


-- Join Customers and orders table, showing unmatched records too 
SELECT o."Order No", c."Customer Name", o."Sales"
FROM customers c
FULL OUTER JOIN orders o ON o."Customer ID" = c."Customer ID";


-- Find customers from same sales region
SELECT a."Customer Name", b."Customer Name", a."Sales Region ID"
FROM customers a
JOIN customers b ON a."Sales Region ID" = b."Sales Region ID"
AND a."Customer ID" <> b."Customer ID";


-- SECTION 2: COMMON TABLE EXPRESSIONS (CTEs) 

-- Aggregate Sales per Customer 
WITH customer_sales AS(
	SELECT "Customer ID", SUM("Sales") AS total_sales
	FROM orders
	GROUP BY "Customer ID"
)
SELECT "Customer ID", total_sales
FROM customer_sales
ORDER BY total_sales DESC;


-- find customers with above overall average sales
WITH customer_sales AS (
	SELECT "Customer ID",
		   SUM("Sales") AS total_sales
    FROM orders
	GROUP BY "Customer ID"
    ), -- agg table 1
	overall_avg AS (
	SELECT AVG(total_sales) AS avg_sales
	FROM customer_sales
	) -- agg table 2
SELECT "Customer ID", total_sales
FROM customer_sales cs, overall_avg oa
WHERE cs.total_sales > oa.avg_sales; -- compare total sales with avg sales


-- SECTION 3: WINDOW FUNCTIONS

-- Running total by Month
SELECT 
	DATE_TRUNC('month',"Order_Date"):: date AS month,
	SUM("Sales") AS monthly_sales,
	SUM(SUM("Sales")) OVER (ORDER BY DATE_TRUNC('month',"Order_Date")) AS running_total
FROM orders
GROUP BY DATE_TRUNC('month',"Order_Date")
ORDER BY monthly_sales DESC;


-- Rolling 3 month average
WITH monthly_sales AS (
	SELECT 
		DATE_TRUNC('month',"Order_Date"):: date AS month,
		SUM("Sales") AS monthly_sales
	FROM orders
	GROUP BY DATE_TRUNC('month',"Order_Date")
)
SELECT month,
	   monthly_sales,
	   ROUND(AVG(monthly_sales) OVER (ORDER BY month
	   							ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_3m_avg
FROM monthly_sales;


-- Rank customers by sales
SELECT "Customer ID",
		SUM("Sales") AS total_sales
		RANK() OVER (ORDER BY SUM("Sales") DESC) AS customer_rnk
FROM orders
GROUP BY "Customer ID";


-- seggregate customers in group of 4 basis sales
SELECT "Customer ID",
		SUM("Sales") AS total_sales,
		NTILE(4) OVER (ORDER BY SUM("Sales")) AS quartile
FROM orders
GROUP BY "Customer ID";


-- seggregate customers in group of 4 and percent rank (between 0 & 1) basis sales
SELECT "Customer ID",
		SUM("Sales") AS total_sales,
		PERCENT_RANK() OVER (ORDER BY SUM("Sales")) AS pct_rnk
FROM orders
GROUP BY "Customer ID";


-- compare sales with previous month
WITH monthly_sales AS (
	SELECT 
		  DATE_TRUNC('month',"Order_Date") AS month,
		  SUM("Sales") AS monthly_sales
	FROM orders
	GROUP BY DATE_TRUNC('month',"Order_Date")
)
SELECT 
	  month,
	  monthly_sales,
	  LAG(monthly_sales) OVER (ORDER BY month DESC) AS prev_month_sales,
	  monthly_sales -LAG(monthly_sales) OVER (ORDER BY month DESC) AS sales_vs_prev
FROM monthly_sales;


-- compare sales with next month
WITH monthly_sales AS(
	 SELECT 
		   DATE_TRUNC('month',"Order_Date")::date AS month,
		   SUM("Sales") AS monthly_sales
	 FROM orders
	 GROUP BY DATE_TRUNC('month',"Order_Date")	 
)
SELECT month,
	   monthly_sales,
	   LEAD(monthly_sales) OVER (ORDER BY month DESC) AS nxt_month_sales,
	   LEAD(monthly_sales) OVER (ORDER BY month DESC) - monthly_sales AS sales_vs_nxt
FROM monthly_sales;


-- ADVANCE SALES
-- Customers percentage sales on each port zone
WITH customer_sales AS(
	 SELECT
	 	   c."Customer ID",
		   SUM(CASE WHEN pz."Port Zone" = 'HUB' THEN o."Sales" ELSE 0 END) AS hub_sales,
		   SUM(CASE WHEN pz."Port Zone" = 'TRANS' THEN o."Sales" ELSE 0 END) AS trans_sales,
		   SUM(CASE WHEN pz."Port Zone" = 'REMOTE' THEN o."Sales" ELSE 0 END) AS remote_sales,
		   SUM("Sales") AS total_sales
	 FROM orders o
	 JOIN customers c ON o."Customer ID" = c."Customer ID"
     JOIN ports p ON o."Port Code" = p."Port Code"
	 JOIN port_zone pz ON p."Zone ID" = pz."Zone ID"
	 GROUP BY c."Customer ID"
	)
SELECT "Customer ID",
	   ROUND(100.0 * hub_sales / total_sales, 2) AS hub_pct,
       ROUND(100.0 * remote_sales / total_sales, 2) AS remote_pct,
       ROUND(100.0 * trans_sales / total_sales, 2) AS transit_pct
FROM customer_sales;
