-- SQL Project 
-- Dataset import from: https://www.kaggle.com/datasets/zahidmughal2343/video-games-sale

-- Primeiro, vamos criar uma cópia da tabela para que possamos limpar os dados, mantendo o original como backup ou caso algo aconteça.
-- First, let's create a copy of the table so we can clean up the data, while keeping the original as a backup or in case something happens.

CREATE TABLE vg_sales_staging
LIKE vg_sales_raw;

INSERT vg_sales_staging
SELECT * FROM vg_sales_raw
; 

SELECT *
FROM vg_sales_staging
;

-- -----------------------------------------------------------------------------------------------

-- 1. Verificando linhas duplicadas
-- Identificar duplicatas com base em todas as colunas, usando ROW_NUMBER
-- Se row_num > 1, significa que há duplicatas exatas

-- 1. checking for duplicate rows
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
-- nenhuma linha duplicada encontrada

-- -----------------------------------------------------------------------------------------------
-- 2- Padronizar Dados
-- Verificar se Nome, Ano, Gênero e Editora possuem valores Nulos ou Vazios

-- 2. Standardize Data
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
-- Não foram encontrados valores Null ou Vazios

-- -----------------------------------------------------------------------------------------------
-- descobrir variações de nomes que precisam ser padronizadas.
-- discover name variations that need to be standardized.

SELECT DISTINCT `Publisher`
FROM vg_sales_staging
order by 1;

-- As variações foram revisadas manualmente a partir dos resultados DISTINCT
-- 23 nomes de publisher precisam ser padronizados

-- Variations were manually reviewed from DISTINCT results
-- 23 publisher names need to be standardized

-- -----------------------------------------------------------------------------------------------
-- Identifica todas as variações do nome "Sony" na coluna Editora
-- Exemplo: "Sony", "Sony BMG", "Sony Interactive Entertainment", etc.

-- Identifies all variations of the name "Sony" in the Publisher column
-- Example: "Sony", "Sony BMG", "Sony Interactive Entertainment", etc.

SELECT DISTINCT `Publisher` FROM vg_sales_staging
WHERE `Publisher` like "%Sony%";

-- Padroniza todas essas variações para "Sony Computer Entertainment"
-- Isso facilita a análise por publisher

UPDATE vg_sales_staging
SET `Publisher` = 'Sony Computer Entertainment'
WHERE `Publisher` like "%Sony%";

-- Esse processo é repetido para todas as 23 publishers que foram encontradas
-- This process is repeated for all 23 publishers that were found.

-- -----------------------------------------------------------------------------------------------

-- Cria uma nova tabela final com os dados já limpos e prontos para análise
-- A tabela 'vg_sales_clean' é uma cópia da tabela 'vg_sales_staging' após a limpeza
-- Isso garante que tenhamos uma versão definitiva e padronizada para usar em análises de EDA,
-- mantendo a tabela 'vg_sales_staging' como um histórico do processo de limpeza

-- Creates a new final table with the data already cleaned and ready for analysis
-- The 'vg_sales_clean' table is a copy of the 'vg_sales_staging' after cleaning
-- This ensures that we have a definitive and standardized version to use in EDA analyses,
-- keeping the 'vg_sales_staging' as a history of the cleaning process

CREATE TABLE vg_sales_clean AS
SELECT * FROM vg_sales_staging;


















