/*=========================================================
MUSEUM COLLECTION INSIGHTS
SQL ANALYSIS PROJECT
=========================================================*/


/*=========================================================
0. DATA CLEANING
QUESTION:
How can we extract a valid artwork year from messy date values?

PURPOSE:
The Date column contains values like:
"1967", "c. 1967", "1970-71", etc.
We extract the first valid 4-digit year.
=========================================================*/
-- CHECK IF THE COLUMN EXISTS
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Artworks';
-- CHECK IF THE COLUMN EXISTS
--CREATE THE COLUMN
ALTER TABLE Artworks
ADD ArtworkYear INT;
-- CHECK IF THE COLUMN EXISTS
--CREATE THE COLUMN
-- FILL THE COLUMN WITH CLEAN YEARS
UPDATE Artworks
SET ArtworkYear =
    TRY_CAST(
        SUBSTRING(
            [Date],
            PATINDEX('%[0-9][0-9][0-9][0-9]%', [Date]),
            4
        ) AS INT
    )
WHERE PATINDEX('%[0-9][0-9][0-9][0-9]%', [Date]) > 0;


-- 
SELECT
    CASE
        WHEN ArtworkYear < 1900 THEN 'Before 1900'
        WHEN ArtworkYear BETWEEN 1900 AND 1949 THEN '1900-1949'
        WHEN ArtworkYear BETWEEN 1950 AND 1999 THEN '1950-1999'
        ELSE '2000+'
    END AS ArtworkPeriod,
    COUNT(*) AS ArtworkCount
FROM Artworks
WHERE ArtworkYear IS NOT NULL
GROUP BY
    CASE
        WHEN ArtworkYear < 1900 THEN 'Before 1900'
        WHEN ArtworkYear BETWEEN 1900 AND 1949 THEN '1900-1949'
        WHEN ArtworkYear BETWEEN 1950 AND 1999 THEN '1950-1999'
        ELSE '2000+'
    END
ORDER BY ArtworkCount DESC;






/*=========================================================
2. WHICH ARTISTS ARE FEATURED THE MOST?
QUESTION:
Which artists have the highest number of artworks
in the museum collection?

PURPOSE:
Identify the most represented artists.
=========================================================*/

SELECT TOP 10
    Artist,
    COUNT(*) AS ArtworkCount
FROM Artworks
WHERE Artist IS NOT NULL
    AND LTRIM(RTRIM(Artist)) <> ''
GROUP BY Artist
ORDER BY ArtworkCount DESC;



/*=========================================================
3. WHAT TYPES OF ARTWORK ARE MOST COMMON?
QUESTION:
Which artwork classifications dominate the collection?

PURPOSE:
Understand the composition of the museum collection.
=========================================================*/

SELECT
    Classification,
    COUNT(*) AS ArtworkCount
FROM Artworks
WHERE Classification IS NOT NULL
    AND LTRIM(RTRIM(Classification)) <> ''
GROUP BY Classification
ORDER BY ArtworkCount DESC;



/*=========================================================
4. ARE THERE ANY TRENDS IN ACQUISITION DATES?
QUESTION:
How has artwork acquisition changed over time?

PURPOSE:
Analyze museum acquisition activity by year.
=========================================================*/

SELECT
    YEAR(DateAcquired) AS AcquisitionYear,
    COUNT(*) AS ArtworkCount
FROM Artworks
WHERE DateAcquired IS NOT NULL
GROUP BY YEAR(DateAcquired)
ORDER BY AcquisitionYear;



/*=========================================================
5. ARTIST DIVERSITY ANALYSIS
QUESTION:
How diverse is the artist population in terms of
nationality and gender?

PURPOSE:
Evaluate artist representation and diversity.
=========================================================*/


/*----- 5A. Nationality Diversity -----*/

SELECT
    Nationality,
    COUNT(*) AS ArtistCount
FROM Artists
WHERE Nationality IS NOT NULL
    AND LTRIM(RTRIM(Nationality)) <> ''
GROUP BY Nationality
ORDER BY ArtistCount DESC;


/*----- 5B. Gender Diversity -----*/

SELECT
    Gender,
    COUNT(*) AS ArtistCount
FROM Artists
WHERE Gender IS NOT NULL
    AND LTRIM(RTRIM(Gender)) <> ''
GROUP BY Gender
ORDER BY ArtistCount DESC;



/*=========================================================
BONUS ANALYSIS (OPTIONAL)
QUESTION:
Which museum departments contain the largest number
of artworks?

PURPOSE:
Understand departmental distribution of artworks.
=========================================================*/

SELECT
    Department,
    COUNT(*) AS ArtworkCount
FROM Artworks
WHERE Department IS NOT NULL
    AND LTRIM(RTRIM(Department)) <> ''
GROUP BY Department
ORDER BY ArtworkCount DESC;

ALTER TABLE Artworks
ADD ArtworkYear INT;
