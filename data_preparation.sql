-- Add a computed column 'total_amount' to the table
-- This column calculates the total revenue per transaction by multiplying price and quantity
-- ROUND is used to ensure the result is limited to two decimal places for financial accuracy
-- PERSISTED ensures the computed value is physically stored in the table, improving query performance

ALTER TABLE customer_shopping_data
ADD total_amount AS (ROUND(price * quantity, 2)) PERSISTED;

-- Retrieve all records from the customer_shopping_data table
-- Useful for verifying that the new computed column has been added and calculated correctly

SELECT *
FROM customers.dbo.customer_shopping_data
