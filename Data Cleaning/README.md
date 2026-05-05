# 🧹 Data Cleaning Project (SQL) – Layoffs Dataset

## 🧠 Overview
This project focuses on **data cleaning and preprocessing** using SQL on a layoffs dataset.

The goal is to transform raw data into a clean, structured dataset by:

- Removing duplicates  
- Standardizing values  
- Handling null/blank data  
- Fixing data types  
- Removing unnecessary rows and columns  

---

## 🗂️ Dataset
Main table:
`layoffs`

Working tables created:
- `layoffs_staging`
- `layoffs_staging3`

---

## 🧱 1. Creating a Backup Table

```sql id="a7k1zp"
SELECT *
FROM layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;
```

## 🧾 2. Removing Duplicates
🔍 Step 1: Identify duplicates

```sql
WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
`date`, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;
```

🏗️ Step 2: Create staging table with row numbers

```sql
CREATE TABLE layoffs_staging3 (
  company text,
  location text,
  industry text,
  total_laid_off int DEFAULT NULL,
  percentage_laid_off text,
  date text,
  stage text,
  country text,
  funds_raised_millions int DEFAULT NULL,
  row_num INT
);
```

📥 Step 3: Insert data with row numbers

```sql
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
    PARTITION BY company, location, industry, total_laid_off,
    percentage_laid_off, `date`, stage, country, funds_raised_millions
  ) AS row_num
FROM layoffs_staging;
```

🗑️ Step 4: Delete duplicates

```sql
DELETE
FROM layoffs_staging3
WHERE row_num > 1;
```

## ✏️ 3. Data Standardization
🧼 Trim whitespace

```sql
UPDATE layoffs_staging3
SET company = TRIM(company);
```

🧪 Standardize industry values
``` sql
UPDATE layoffs_staging3
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
```

🌍 Clean country names

```sql
UPDATE layoffs_staging3
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';
```

📅 Fix date format

```sql
UPDATE layoffs_staging3
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
```

🔄 Convert date column type
```sql
ALTER TABLE layoffs_staging3
MODIFY COLUMN `date` DATE;
```

## 🧩 4. Handling Null / Blank Values
🔍 Find missing values

```sql
SELECT *
FROM layoffs_staging3
WHERE industry IS NULL
OR industry = '';
```

🔗 Fill missing industry values using other rows

```sql
UPDATE layoffs_staging3 t1
JOIN layoffs_staging3 t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
```

## 🧹 5. Removing Unnecessary Data
❌ Remove rows with no useful data

```sql
DELETE
FROM layoffs_staging3
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
```

🧾 Drop helper column
```sql
ALTER TABLE layoffs_staging3
DROP COLUMN row_num;
```

## 🧠 Key Concepts Used
* Data duplication handling (ROW_NUMBER())
* CTEs (Common Table Expressions)
* Data standardization (TRIM, LIKE, string cleanup)
* Date formatting (STR_TO_DATE)
* Data type conversion
* NULL handling strategies
* SQL JOIN for data imputation

## 🚀 Outcome

The dataset is now:
* Cleaned
* Standardized
* Free of duplicates
* Properly formatted
* Ready for Exploratory Data Analysis (EDA)

## 📌 Final Note

This project demonstrates a full data cleaning pipeline using SQL, which is a critical step before any data analysis or visualization.
