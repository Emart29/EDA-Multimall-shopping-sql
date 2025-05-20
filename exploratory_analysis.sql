-- Get the total number of unique customers
SELECT 
 COUNT(DISTINCT customer_id) AS unique_customers
FROM 
 customers.dbo.customer_shopping_data;

-- Preview the first 10 rows of the dataset
SELECT TOP 10
 *
FROM 
 customers.dbo.customer_shopping_data;

-- Calculate the total revenue generated
SELECT 
 SUM(total_amount) AS total_revenue
FROM 
 customers.dbo.customer_shopping_data;

-- Retrieve the top 5 shopping malls by total revenue
SELECT TOP 5 
 shopping_mall, SUM(total_amount) AS mall_revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 shopping_mall
ORDER BY 
 mall_revenue DESC;

-- Retrieve the top 5 product categories by quantity sold
SELECT TOP 5 
 category, SUM(quantity) AS total_quantity
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 category
ORDER BY 
 total_quantity DESC;

-- Count the number of unique customers by gender
SELECT 
 gender, COUNT(DISTINCT customer_id) AS total_customers
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 gender;

-- Calculate the average age of customers
SELECT 
 AVG(age) AS avg_age 
FROM 
 customers.dbo.customer_shopping_data

-- Group revenue by defined age groups
SELECT 
  CASE 
    WHEN age < 20 THEN 'Under 20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+'
  END AS age_group,
  SUM(total_amount) AS revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY
  CASE 
    WHEN age < 20 THEN 'Under 20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+'
  END
ORDER BY 
 revenue DESC;

-- Count the number of purchases by each payment method
SELECT 
 payment_method, COUNT(*) AS count
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 payment_method
ORDER BY 
 count DESC;

-- Analyze monthly revenue trends
SELECT 
 FORMAT(invoice_date, 'yyyy-MM') AS sale_month, SUM(total_amount) AS revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 FORMAT(invoice_date, 'yyyy-MM')
ORDER BY 
 sale_month;

-- Evaluate revenue by weekday
SELECT 
 DATENAME(WEEKDAY, invoice_date) AS weekday, SUM(total_amount) AS revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 DATENAME(WEEKDAY, invoice_date)
ORDER BY 
 revenue DESC;

-- Group revenue by gender
SELECT 
 gender, SUM(total_amount) AS revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 gender
ORDER BY 
 revenue DESC;

-- Revenue breakdown by shopping mall and gender
SELECT 
 shopping_mall, gender, SUM(total_amount) AS revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 gender, shopping_mall
ORDER BY 
 gender, shopping_mall;

-- Analyze payment method usage across different age groups
SELECT 
  CASE 
    WHEN age < 20 THEN 'Under 20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+'
  END AS age_group,
  payment_method,
  COUNT(*) AS method_count
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
  CASE 
    WHEN age < 20 THEN 'Under 20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+'
  END,
  payment_method
ORDER BY 
age_group;

-- Monthly transaction volume analysis
SELECT 
 FORMAT(invoice_date, 'yyyy-MM') AS month, COUNT(*) AS transaction_count
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 FORMAT(invoice_date, 'yyyy-MM')
ORDER BY 
 month;

-- Product category analysis for female customers
SELECT 
 category, SUM(quantity) AS quantity_sold_to_female_customers
FROM 
 customers.dbo.customer_shopping_data
WHERE 
 gender = 'Female'
GROUP BY 
 category
ORDER BY 
 quantity_sold_to_female_customers DESC;

-- Product category analysis for male customers
SELECT 
 category, SUM(quantity) AS quantity_sold_to_male_customers
FROM 
 customers.dbo.customer_shopping_data
WHERE 
 gender = 'Male'
GROUP BY 
 category
ORDER BY 
 quantity_sold_to_male_customers DESC;

-- Compute average number of items per transaction (basket size)
SELECT 
  AVG(items_per_transaction) AS avg_basket_size
FROM (
  SELECT 
   invoice_no, SUM(quantity) AS items_per_transaction
  FROM 
   customers.dbo.customer_shopping_data
  GROUP BY 
   invoice_no
) AS 
 basket;

-- Analyze spending behavior by exact age
SELECT 
  age,
  COUNT(*) AS transactions,
  AVG(total_amount) AS avg_spending
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 age
ORDER BY 
 age;

-- Determine peak shopping days by mall
SELECT 
  shopping_mall,
  DATENAME(WEEKDAY, invoice_date) AS weekday,
  SUM(total_amount) AS revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 shopping_mall, DATENAME(WEEKDAY, invoice_date)
ORDER BY 
 shopping_mall, revenue DESC;

-- Identify top-performing categories by mall revenue
SELECT 
  shopping_mall,
  category,
  SUM(total_amount) AS category_revenue
FROM 
 customers.dbo.customer_shopping_data
GROUP BY 
 shopping_mall, category
ORDER BY 
 shopping_mall, category_revenue DESC;
