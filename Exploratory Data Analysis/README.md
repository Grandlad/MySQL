# 📊 Layoffs Exploratory Data Analysis (SQL Project)

## 🧠 Overview
This project performs Exploratory Data Analysis (EDA) on global layoffs data using SQL.

The goal is to identify trends in layoffs across:
- Time (monthly and yearly trends)
- Companies
- Industries
- Countries
- Top affected organizations

---

## 🗂️ Dataset
Table used:
`layoffs_staging2`

Key columns:
- company
- industry
- total_laid_off
- percentage_laid_off
- date
- country

---

## 📈 Monthly Layoffs Trend

```sql
SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC;
```

## 📊 Rolling Total (Cumulative Layoffs)

```sql
WITH Rolling_Total AS (
  SELECT SUBSTRING(`date`,1,7) AS `Month`, 
         SUM(total_laid_off) AS total_off
  FROM layoffs_staging2
  WHERE SUBSTRING(`date`,1,7) IS NOT NULL
  GROUP BY `Month`
)
SELECT `Month`, total_off,
       SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
FROM Rolling_Total;
```

## 🏢 Layoffs by Company (Yearly)

```sql
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;
```

## 🏆 Company Ranking per Year

```sql
WITH Company_Year AS (
  SELECT company, YEAR(`date`) AS years,
         SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`)
)
SELECT *,
       DENSE_RANK() OVER (
         PARTITION BY years
         ORDER BY total_laid_off DESC
       ) AS ranking
FROM Company_Year;
```

## 🥇 Top 5 Companies per Year

```sql
WITH Company_Year AS (
  SELECT company, YEAR(`date`) AS years,
         SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`)
),
Company_Year_Rank AS (
  SELECT *,
         DENSE_RANK() OVER (
           PARTITION BY years
           ORDER BY total_laid_off DESC
         ) AS ranking
  FROM Company_Year
)
SELECT *
FROM Company_Year_Rank
WHERE ranking <= 5;
```
🌍 Layoffs by Country

```sql
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
```

🏭 Layoffs by Industry

```sql
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
```

📆 Yearly Layoff Trends

```sql
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;
```

⚠️ Companies with 100% Layoffs

```sql
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
```

## 📊 Key Insights
* Layoffs are heavily concentrated in specific time periods
* A small number of companies account for a large share of layoffs
* Tech-related industries are among the most impacted
* Some companies experienced full workforce layoffs (100%)
* Rolling totals show continuous growth of layoffs over time


## 🧠 SQL Skills Used
* GROUP BY aggregations
* Window functions (OVER)
* CTEs (Common Table Expressions)
* Ranking functions (DENSE_RANK)
* Date extraction (YEAR, SUBSTRING)

## 🚀 Tools Used
* MySQL

## 📌 Conclusion

* This project demonstrates exploratory data analysis using SQL to uncover trends in global layoffs and understand their impact across industries, companies, and time.
