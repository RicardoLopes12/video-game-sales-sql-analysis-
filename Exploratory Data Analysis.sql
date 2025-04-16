-- Selected the highest-selling game(s) globally for each year
SELECT Year, Name, Platform, Publisher, Global_Sales
FROM (
    SELECT *,
	RANK() OVER (PARTITION BY Year ORDER BY Global_Sales DESC) AS sales_rank
    FROM vg_sales_clean
    WHERE Year IS NOT NULL
) ranked_games
WHERE sales_rank = 1
ORDER BY Year;

-- -----------------------------------------------------------------------------------------------

-- A basic query for the 10 best-selling games globally
SELECT Year, Name, Genre, Platform, Publisher, Global_Sales
FROM vg_sales_clean
ORDER BY Global_Sales DESC
LIMIT 10;

-- -----------------------------------------------------------------------------------------------

--  A query showing the best-selling genres globally
SELECT Genre, ROUND(SUM(Global_Sales), 2) All_Sales
FROM vg_sales_clean
GROUP BY Genre
ORDER BY All_Sales DESC;

-- -----------------------------------------------------------------------------------------------

-- This query aggregates total global sales by platform, rounds the totals for clarity, and then orders the platforms from highest to lowest sales.
-- Finally, it returns the top 10 platforms based on global sales
SELECT Platform, ROUND(SUM(Global_Sales), 2) All_Sales
FROM vg_sales_clean
GROUP BY Platform
ORDER BY All_Sales DESC
LIMIT 10;

-- -----------------------------------------------------------------------------------------------

-- Total sales by region
-- This shows which market consumes the most games overall
-- The values ​​are rounded for readability
-- Restructures the data to have one row per region
SELECT Region, Total_Sales, Round(Total_Sales / Global_Total * 100, 2) Percentage
FROM ( 
SELECT "NA" as Region, Round(SUM(NA_Sales), 2) AS Total_Sales FROM vg_sales_clean
UNION
SELECT "EU" as Region, Round(SUM(EU_Sales), 2) AS Total_Sales FROM vg_sales_clean
UNION
SELECT "JP" as Region, Round(SUM(JP_Sales), 2) AS Total_Sales FROM vg_sales_clean
UNION
SELECT "OTHER" as Region, Round(SUM(Other_Sales), 2) AS Total_Sales FROM vg_sales_clean
) AS Regional_Sales
CROSS JOIN (
SELECT SUM(Global_Sales) AS Global_Total
FROM vg_sales_clean
) AS Total;

-- -----------------------------------------------------------------------------------------------

-- This query shows the distribution of video game sales across different regions (North America, Europe, Japan, and Others) over the years.
-- It helps to identify regional trends and how sales have evolved annually.

SELECT Year, 
Round(SUM(NA_Sales), 2) NA_Sales, 
Round(SUM(EU_Sales), 2) EU_Sales, 
Round(SUM(JP_Sales), 2)  JP_Sales, 
Round(SUM(Other_Sales), 2) Other_Sales,
Round(SUM(Global_Sales), 2) Global_Sales
FROM vg_sales_clean
GROUP BY Year
Order BY Year;

-- -----------------------------------------------------------------------------------------------

-- This query compares the sales performance of each game genre across all major regions (North America, Europe, Japan, and Others),
-- and also includes the total global sales. It helps to understand which genres are most popular and where.
SELECT Genre, 
Round(SUM(NA_Sales), 2) NA_Sales, 
Round(SUM(EU_Sales), 2) EU_Sales, 
Round(SUM(JP_Sales), 2)  JP_Sales, 
Round(SUM(Other_Sales), 2) Other_Sales,
Round(SUM(Global_Sales), 2) Global_Sales
FROM vg_sales_clean
GROUP BY Genre
ORDER BY Global_Sales DESC;

-- -----------------------------------------------------------------------------------------------

-- Favorite genre by region
-- This query identifies the most popular game genre in each region (North America, Europe, Japan, and Others)
-- by calculating total sales per genre and selecting the top-selling one for each region.
-- It uses subqueries with GROUP BY and ORDER BY to isolate the highest-selling genre per region.

SELECT "NA" as Region,(
SELECT Genre from vg_sales_clean
Group By Genre
Order By SUM(NA_Sales) DESC
Limit 1) as Favorite_Genre
UNION ALL
SELECT "EU" as Region,(
SELECT Genre from vg_sales_clean
Group By Genre
Order By SUM(EU_Sales) DESC
Limit 1) as Favorite_Genre
UNION ALL
SELECT "JP" as Region,(
SELECT Genre from vg_sales_clean
Group By Genre
Order By SUM(JP_Sales) DESC
Limit 1) as Favorite_Genre
UNION ALL
SELECT "Other" as Region,(
SELECT Genre from vg_sales_clean
Group By Genre
Order By SUM(Other_Sales) DESC
Limit 1) as Favorite_Genre;


-- -----------------------------------------------------------------------------------------------

-- This query compares total sales of each gaming platform across different regions (North America, Europe, Japan, and Others),
-- along with the overall global sales. It helps identify which platforms perform best in each region and globally.
SELECT Platform, 
Round(SUM(NA_Sales), 2) NA_Sales, 
Round(SUM(EU_Sales), 2) EU_Sales, 
Round(SUM(JP_Sales), 2)  JP_Sales, 
Round(SUM(Other_Sales), 2) Other_Sales,
Round(SUM(Global_Sales), 2) Global_Sales
FROM vg_sales_clean
GROUP BY Platform
ORDER BY Global_Sales DESC;

-- -----------------------------------------------------------------------------------------------

-- Favorite Platform by region
-- For each region, select the platform with the highest total sales by grouping the data and ordering by the sum of regional sales, limiting the result to the top entry.

SELECT "NA" as Region,(
SELECT Platform from vg_sales_clean
Group By Platform
Order By SUM(NA_Sales) DESC
Limit 1) as Favorite_Platform
UNION ALL
SELECT "EU" as Region,(
SELECT Platform from vg_sales_clean
Group By Platform
Order By SUM(EU_Sales) DESC
Limit 1) as Favorite_Platform
UNION ALL
SELECT "JP" as Region,(
SELECT Platform from vg_sales_clean
Group By Platform
Order By SUM(JP_Sales) DESC
Limit 1) as Favorite_Platform
UNION ALL
SELECT "Other" as Region,(
SELECT Platform from vg_sales_clean
Group By Platform
Order By SUM(Other_Sales) DESC
Limit 1) as Favorite_Platform;

-- -----------------------------------------------------------------------------------------------

-- This query retrieves the top 5 games with the highest sales for each region separately.
-- Each subquery is enclosed in parentheses to allow individual ORDER BY and LIMIT clauses.
-- The constant ("NA" or "EU") is added to each row to identify the region.
-- UNION ALL is used to combine the results from both regions without eliminating duplicate rows.

(SELECT "NA" AS Region, Name 
FROM vg_sales_clean
ORDER BY NA_Sales DESC
LIMIT 5)
UNION all
(SELECT "EU" AS Region, Name 
FROM vg_sales_clean
ORDER BY EU_Sales DESC
LIMIT 5)
UNION all
(SELECT "JP" AS Region, Name 
FROM vg_sales_clean
ORDER BY JP_Sales DESC
LIMIT 5)
UNION all
(SELECT "Other" AS Region, Name 
FROM vg_sales_clean
ORDER BY Other_Sales DESC
LIMIT 5);

-- -----------------------------------------------------------------------------------------------

-- This query compares total sales from each publisher across major regions (North America, Europe, Japan, and Others),
-- as well as global sales. It helps identify the top-performing publishers in terms of sales.
-- The result is limited to the top 20 publishers based on global sales.

SELECT Publisher, 
Round(SUM(NA_Sales), 2) NA_Sales, 
Round(SUM(EU_Sales), 2) EU_Sales, 
Round(SUM(JP_Sales), 2)  JP_Sales, 
Round(SUM(Other_Sales), 2) Other_Sales,
Round(SUM(Global_Sales), 2) Global_Sales
FROM vg_sales_clean
GROUP BY Publisher
ORDER BY Global_Sales DESC
Limit 20;

-- -----------------------------------------------------------------------------------------------


















