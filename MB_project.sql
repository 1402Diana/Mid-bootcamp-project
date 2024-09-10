# What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms
FROM house_price
ORDER BY bedrooms;

# What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms
FROM house_price
ORDER BY bathrooms;


# What are the unique values in the column floors?

SELECT DISTINCT floors
FROM house_price
ORDER BY floors;

# What are the unique values in the column condition?

SELECT DISTINCT condition1
FROM house_price
ORDER BY condition1;


# What are the unique values in the column grade?

SELECT DISTINCT grade
FROM house_price
ORDER BY grade;

# Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
SELECT id
FROM house_price
ORDER BY price DESC
LIMIT 10;

# What is the average price of all the properties in your data?

SELECT ROUND(AVG(price),2) AS average_price
FROM house_price;

# What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.

SELECT bedrooms, ROUND(AVG(price),2) AS average_price
FROM house_price
GROUP BY bedrooms
ORDER BY bedrooms ASC;

# What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.

SELECT bedrooms, ROUND(AVG(sqft_living), 2) AS average_sqft_living
FROM house_price
GROUP BY bedrooms
ORDER BY bedrooms ASC;

# What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.

SELECT waterfront, ROUND(AVG(price),2) AS average_price
FROM house_price
GROUP BY waterfront;

# Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

SELECT condition1, ROUND(AVG(grade),2) AS average_grade
FROM house_price
GROUP BY condition1
ORDER BY condition1;

# One of the customers is only interested in the following houses: number of bedrooms either 3 or 4, bathrooms more than 3, one floor, no waterfront, condition should be 3 at least, grade should be 5 at least, price less than 300000
For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

SELECT *
FROM house_price
WHERE bedrooms IN (3, 4)
  AND bathrooms > 3
  AND floors = 1
  AND waterfront = 0
  AND condition1 >= 3
  AND grade >= 5
  AND price < 300000;
  
  # Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
SELECT *
FROM house_price
WHERE price > 2 * (SELECT AVG(price) FROM house_price);


# Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE OR REPLACE VIEW expensive_properties AS
SELECT *
FROM house_price
WHERE price > 2 * (SELECT AVG(price) FROM house_price);

SHOW CREATE VIEW expensive_properties;

# Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?

WITH Average_Prices AS (
    SELECT
        bedrooms,
        ROUND(AVG(price),2) AS average_price
    FROM house_price
    WHERE bedrooms IN (3, 4)
    GROUP BY bedrooms
)
SELECT
    (SELECT average_price FROM Average_Prices WHERE bedrooms = 4) -
    (SELECT average_price FROM Average_Prices WHERE bedrooms = 3) AS price_difference;
    
# What are the different locations where properties are available in your database? (distinct zip codes)
SELECT DISTINCT zipcode
FROM house_price;

# Show the list of all the properties that were renovated.
SELECT *
FROM house_price
WHERE yr_renovated > 0;

# Provide the details of the property that is the 11th most expensive property in your database.
SELECT *
FROM house_price
ORDER BY price DESC
LIMIT 1 OFFSET 10;
