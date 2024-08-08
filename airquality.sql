CREATE DATABASE AirQuality;
USE AirQuality;
CREATE TABLE PollutionData1 (
    Country_Name VARCHAR(255),
    Country_Code VARCHAR(3),
    Pollution2010 FLOAT,
	Pollution2011 FLOAT,
    Pollution2012 FLOAT,
    Pollution2013 FLOAT,
    Pollution2014 FLOAT,
    Pollution2015 FLOAT,
    Pollution2016 FLOAT,
    Pollution2017 FLOAT
);

SELECT *
FROM PollutionData1
;

-- Data cleaing: Checking for missing values.

SELECT Country_Name, Country_Code,
       SUM(CASE WHEN Pollution2010 IS NULL THEN 1 ELSE 0 END) AS Missing_2010,
       SUM(CASE WHEN Pollution2011 IS NULL THEN 1 ELSE 0 END) AS Missing_2011,
       SUM(CASE WHEN Pollution2012 IS NULL THEN 1 ELSE 0 END) AS Missing_2012,
       SUM(CASE WHEN Pollution2013 IS NULL THEN 1 ELSE 0 END) AS Missing_2013,
       SUM(CASE WHEN Pollution2014 IS NULL THEN 1 ELSE 0 END) AS Missing_2014,
       SUM(CASE WHEN Pollution2015 IS NULL THEN 1 ELSE 0 END) AS Missing_2015,
       SUM(CASE WHEN Pollution2016 IS NULL THEN 1 ELSE 0 END) AS Missing_2016,
       SUM(CASE WHEN Pollution2017 IS NULL THEN 1 ELSE 0 END) AS Missing_2017
FROM PollutionData1
GROUP BY Country_Name, Country_Code
;

-- Transform to long format for easier analysis

CREATE TABLE LongFormatPollutionData AS
SELECT Country_Name, Country_Code, '2010' AS Year, Pollution2010 AS PM2_5
FROM PollutionData1
UNION ALL
SELECT Country_Name, Country_Code, '2011' AS Year, Pollution2011 AS PM2_5
FROM PollutionData1
UNION ALL
SELECT Country_Name, Country_Code, '2012' AS Year, Pollution2012 AS PM2_5
FROM PollutionData1
UNION ALL
SELECT Country_Name, Country_Code, '2013' AS Year, Pollution2013 AS PM2_5
FROM PollutionData1
UNION ALL
SELECT Country_Name, Country_Code, '2014' AS Year, Pollution2014 AS PM2_5
FROM PollutionData1
UNION ALL
SELECT Country_Name, Country_Code, '2015' AS Year, Pollution2015 AS PM2_5
FROM PollutionData1
UNION ALL
SELECT Country_Name, Country_Code, '2016' AS Year, Pollution2016 AS PM2_5
FROM PollutionData1
UNION ALL
SELECT Country_Name, Country_Code, '2017' AS Year, Pollution2017 AS PM2_5
FROM PollutionData1
;

SELECT *
FROM LongFormatPollutionData
;

-- Calculate average PM2.5 levels by country

SELECT Country_Name, Country_Code,
       AVG(PM2_5) AS Avg_PM2_5
FROM LongFormatPollutionData
GROUP BY Country_Name, Country_Code
;

-- Identify countries with the highest increase in PM2.5 levels

WITH InitialFinalPM AS (
    SELECT Country_Name, 
           MIN(Year) AS Initial_Year, MIN(PM2_5) AS Initial_PM,
           MAX(Year) AS Final_Year, MAX(PM2_5) AS Final_PM
    FROM LongFormatPollutionData
    GROUP BY Country_Name
)
SELECT Country_Name, Initial_Year, Final_Year, 
       (Final_PM - Initial_PM) AS PM_Increase
FROM InitialFinalPM
ORDER BY PM_Increase DESC
;


