SELECT *
FROM layoffs;

-- 1. Duplicates Cleaning
-- 2. Standarization of the Data
-- 3. Cleaning Blank/Null values
-- 4. Removing unnessesary columns and rows

-- Creating backup table

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 1. Duplicates cleaning
-- 1.1. Finding Duplicates

WITH duplicate_cte AS  
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- 1.2. Deleting duplicates

CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging3;

-- Adding a row num to the table and deleting duplicates

INSERT INTO layoffs_staging3
SELECT 
	company,
    location,
    industry,
    total_laid_off,
    percentage_laid_off,
    STR_TO_DATE(`date`, '%m/%d/%Y') AS `date`,
    stage,
    country,
    funds_raised_millions,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage,
country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging3
WHERE row_num > 1;

SELECT *
FROM layoffs_staging3
WHERE row_num > 1;

-- 2. Standarization of the Data

SELECT company
FROM layoffs_staging3;

-- 2.1. Cleaning whitespaces

UPDATE layoffs_staging3
SET company = TRIM(company);

SELECT DISTINCT country
FROM layoffs_staging3
Order by 1;

-- 2.2. Unifying industry

UPDATE layoffs_staging3
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;

-- 2.3. Unifying countries

SELECT DISTINCT country
FROM layoffs_staging3
Order by 1;

UPDATE layoffs_staging3
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'
;

-- 2.4. Changing format of the date

SELECT `date`
FROM layoffs_staging3
;

 UPDATE layoffs_staging3
 SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
 ;

-- 2.5. Changing data type

ALTER TABLE layoffs_staging3
MODIFY COLUMN `date` DATE
;

-- 2.6. Sorting out Nulls

SELECT *
FROM layoffs_staging3
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging3
WHERE company = 'Airbnb';

-- 3. Cleaning Blank/Null values

SELECT *
FROM layoffs_staging3
WHERE company = 'Airbnb'
;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''
;

SELECT t1.industry, t2.industry
FROM layoffs_staging3 t1
JOIN layoffs_staging3 t2
	ON t1.company = t2.company
    AND t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL
;

UPDATE layoffs_staging3 t1
JOIN layoffs_staging3 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL
;



-- 4. Removing unnessesary columns and rows

SELECT *
FROM layoffs_staging3
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE 
FROM layoffs_staging3
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging3
;

ALTER TABLE layoffs_staging3
DROP COLUMN row_num
;
