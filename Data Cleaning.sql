-- SQL Project 
-- Dataset import from: https://www.kaggle.com/datasets/zahidmughal2343/video-games-sale

-- First, let's create a copy of the table so we can clean up the data, while keeping the original as a backup or in case something happens.
CREATE TABLE vg_sales_staging
LIKE vg_sales_raw;

INSERT vg_sales_staging
SELECT * FROM vg_sales_raw
; 

SELECT *
FROM vg_sales_staging
;


-- 1- checking for duplicate rows
-- Identify duplicates based on all columns, using ROW_NUMBER
-- If row_num > 1, it means there are exact duplicates

SELECT *
FROM (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY `Rank`, `Name`, `Platform`, `Year`, `Genre`, `Publisher`, `NA_Sales`, `EU_Sales`, `JP_Sales`, `Other_Sales`, `Global_Sales`) AS row_num
	FROM vg_sales_staging
    )duplicates
WHERE 	row_num > 1;

-- no duplicates founds


-- 2- Standardize Data
-- Check if Name, Year, Genre, Publisher have Null or Empty values

SELECT *
FROM vg_sales_staging
WHERE `Name` IS NULL 
OR `Name` = ''
ORDER BY `Name`;

SELECT *
FROM vg_sales_staging
WHERE `Year` IS NULL 
OR `Year` = ''
ORDER BY `Year`;

SELECT *
FROM vg_sales_staging
WHERE `Genre` IS NULL 
OR `Genre` = ''
ORDER BY `Genre`;

SELECT *
FROM vg_sales_staging
WHERE `Publisher` IS NULL 
OR `Publisher` = ''
ORDER BY `Publisher`;

-- No Null or Empty values ​​were found


-- discover name variations that need to be standardized.
SELECT DISTINCT `Publisher`
FROM vg_sales_staging
order by 1;

-- Variations were manually reviewed from DISTINCT results
-- 23 publisher names were standardized



-- Identifies all variations of the name "Sony" in the Publisher column
-- Example: "Sony", "Sony BMG", "Sony Interactive Entertainment", etc.
SELECT DISTINCT `Publisher` FROM vg_sales_staging
WHERE `Publisher` like "%Sony%";

-- Standardizes all such variations to "Sony Computer Entertainment"
-- This makes it easier to analyze by publisher
UPDATE vg_sales_staging
SET `Publisher` = 'Sony Computer Entertainment'
WHERE `Publisher` like "%Sony%";



-- Creates a new final table with the data already cleaned and ready for analysis
-- The 'vg_sales_clean' table is a copy of the 'vg_sales_staging' after cleaning
-- This ensures that we have a definitive and standardized version to use in EDA analyses,
-- keeping the 'vg_sales_staging' as a history of the cleaning process

CREATE TABLE vg_sales_clean AS
SELECT * FROM vg_sales_staging;


















