-- Display All Tables
SELECT * FROM vixproject11.ProductCategory; -- Primary key of ProductCategory table is "CategoryID"
SELECT * FROM vixproject11.Customer; -- Primary key of Customer table is "CustomerID"
SELECT * FROM vixproject11.Orders; -- Primary key of Orders table is "OrderID"
SELECT * FROM vixproject11.Products; -- Primary key of Products table is "ProdNumber"


-- Add constrain primary key for all table
ALTER TABLE vixproject11.ProductCategory
  ADD PRIMARY KEY (CategoryID) NOT ENFORCED;

ALTER TABLE vixproject11.Customer
  ADD PRIMARY KEY (CustomerID) NOT ENFORCED;

ALTER TABLE vixproject11.Orders
  ADD PRIMARY KEY (OrderID) NOT ENFORCED;

ALTER TABLE vixproject11.Products
  ADD PRIMARY KEY (ProdNumber) NOT ENFORCED;

-- Check Missing Values
SELECT *
FROM vixproject11.ProductCategory
WHERE CategoryAbbreviation IS NULL
   OR CategoryID IS NULL
   OR CategoryName IS NULL;  -- No missing values found

SELECT *
FROM vixproject11.Customer
WHERE CustomerID IS NULL
   OR FirstName IS NULL
   OR LastName IS NULL
   OR CustomerEmail IS NULL
   OR CustomerPhone IS NULL
   OR CustomerAddress IS NULL
   OR CustomerCity IS NULL
   OR CustomerState IS NULL
   OR CustomerZip IS NULL; -- No missing values found

SELECT *
FROM vixproject11.Orders
WHERE CustomerID IS NULL
   OR OrderID IS NULL
   OR Date IS NULL
   OR ProdNumber IS NULL
   OR Quantity IS NULL; -- No missing values found

SELECT *
FROM vixproject11.Products
WHERE ProdNumber IS NULL
   OR Category IS NULL
   OR Price IS NULL; -- No missing values found

-- Define relations between tables in vixproject11 dataset
-- Orders table has a relation with Customer table on "CustomerID" and Products table on "ProdNumber"
-- Products table has a relation with ProductCategory table on "CategoryID"

-- Create master table with necessary columns:
-- CustomerEmail (cust_email), CustomerCity (cust_city), OrderDate (order_date), OrderQty (order_qty),
-- ProductName (product_name), ProductPrice (product_price), ProductCategoryName (category_name), and TotalSales (total_sales).

SELECT 
  os.Date AS order_date,
  py.CategoryName AS category_name,
  ps.ProdName AS product_name,
  ps.Price AS product_price,
  os.Quantity AS order_qty,
  ps.Price * os.Quantity AS total_sales,
  cr.CustomerEmail AS cust_email,
  cr.CustomerCity AS cust_city
FROM 
  vixproject11.Orders AS os
JOIN 
  vixproject11.Customer AS cr 
  ON os.CustomerID = cr.CustomerID
JOIN 
  vixproject11.Products AS ps 
  ON os.ProdNumber = ps.ProdNumber
JOIN 
  vixproject11.ProductCategory AS py 
  ON ps.Category = py.CategoryID
ORDER BY 
  order_date ASC;
