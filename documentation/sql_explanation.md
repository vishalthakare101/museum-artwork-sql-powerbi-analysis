# SQL Explanation – Museum Artwork Analysis

This document explains the SQL logic used in the project, including data cleaning, transformation, and analytical queries.

---

## 1. Data Cleaning
The raw dataset contained inconsistent date formats, missing values, and non‑numeric year fields.  
Key cleaning steps included:

- Extracting numeric year values from the `date` column  
- Handling null or unknown years  
- Standardizing artist names  
- Creating a clean `clean_year` column for analysis  

Example logic:
- Using CASE statements to handle invalid years  
- Using SUBSTRING and PATINDEX to extract numeric values  

---

## 2. Analytical Queries

### Question 1: How modern are the artworks?
- Calculated distribution of artworks by year  
- Grouped artworks into time periods  
- Used `clean_year` for accurate analysis  

### Question 2: Which artists are featured the most?
- Counted artworks per artist  
- Sorted in descending order  
- Identified top contributors  

### Question 3: What types of artwork are most common?
- Grouped by `classification`  
- Counted total artworks per category  

### Question 4: Acquisition trends
- Grouped artworks by `acquisition_year`  
- Identified growth patterns over decades  

### Question 5: Artist diversity
- Analyzed gender and nationality fields  
- Counted representation across categories  

---

## 3. Output
The cleaned dataset and SQL insights were used as the foundation for the Power BI dashboard.

