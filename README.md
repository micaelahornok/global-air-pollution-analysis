# Global Air Pollution Analysis

## Overview

This project analyzes historical air quality data from 2010 to 2017 for 240 countries, focusing on PM2.5 (fine particulate matter). The dataset, sourced from Kaggle, provides mean annual exposure levels of PM2.5 in micrograms per cubic meter. The goal of this analysis is to identify and visualize trends and patterns in global air pollution, highlighting variations in pollution levels across different countries and over time.

## Data Source

The dataset used in this project is:

**Title:** PM2.5 Global Air Pollution 2010-2017  
**Description:** Mean Annual Exposure for 240 Countries

**Citation:**

- **Title:** PM2.5 Global Air Pollution 2010-2017
- **Source:** [Kaggle - PM2.5 Global Air Pollution 2010-2017](https://www.kaggle.com/datasets/sanaulla2/pm25-global-air-pollution-20102017)
- **Date Accessed:** August 3, 2024
  
## Tools

- MySQL Workbench
- Tableau

## Data Cleaning and Preparation
In preparing the dataset for analysis, several steps were taken to ensure data quality and usability. Below is an overview of the data cleaning and preparation process:

### 1. Data Import

The dataset was downloaded from Kaggle and imported into MySQL Workbench using 'Table Data Import Wizard' for initial processing and analysis.

### 2. Table Creation

A new table, PollutionData1, was created to store the PM2.5 pollution data. This table includes columns for country names, country codes, and PM2.5 levels for each year from 2010 to 2017.

### 3. Data Cleaning and Preparation

**Missing Values** - Checked for missing values across all years.

**Data Type Conversion** - Ensured that all date and numerical columns were in the correct format for accurate analysis.

**Data Transformation** - Transformed the dataset from a wide format to a long format using SQL. This step involved creating the LongFormatPollutionData table to consolidate yearly PM2.5 data into a single column, making it easier to perform analysis.

## Exploratory Data Analysis (EDA)
In the EDA phase, several key questions were addressed to uncover insights and patterns within the dataset. The following questions guided the analysis:

- What are the average PM2.5 levels for each country between 2010-2017?
- How do PM2.5 levels vary by year for each country?
- Which countries have the highest/lowest PM2.5 levels?
- What is the geographic distribution of PM2.5 levels?

## Data Analysis

**To determine the average PM2.5 levels for each country over the study period, the following SQL query was used:**

```SQL
SELECT Country_Name, Country_Code,
       AVG(PM2_5) AS Avg_PM2_5
FROM LongFormatPollutionData
GROUP BY Country_Name, Country_Code
;
```

This query computed the average PM2.5 levels for each country, providing insights into which countries had higher or lower average pollution levels over the years.

**To identify countries with the most significant increases in PM2.5 levels, the following SQL code was used:**

```SQL
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
```
This query calculated the difference between the initial and final PM2.5 levels for each country, highlighting those with the highest increases in pollution over the study period.

## Data Visualization
After performing data cleaning and analysis using SQL, the results were imported into Tableau for interactive visualization. The following visualizations were created to provide insights into global PM2.5 levels:

**Interactive Map** - A map color-coded based on the average PM2.5 levels across different countries. This visualization allows for geographic comparison of air pollution levels.

**Line Graph** - A line graph displaying the mean annual exposure PM2.5 levels for all countries from 2010 to 2017. This graph enables the comparison of trends over time across different countries.

**Bar Chart** - A bar chart showing the average PM2.5 levels for each country between 2010-2017. This chart provides a summary view of the average pollution levels for each country across the years studied.

These visualizations help in understanding the spatial and temporal distribution of air pollution, and facilitate the comparison of PM2.5 levels across countries and over time.

## Results
The data analysis and visualization reveal several key insights into global PM2.5 pollution levels from 2010 to 2017:

### Countries with the Highest Increase in PM2.5 Levels (2010-2017)

The SQL query to identify the countries with the highest increase in PM2.5 levels revealed the following top countries with the most significant increases in pollution levels over the study period:

- Cameroon: +20.3 µg/m³
- Sri Lanka: +20.1 µg/m³
- China: +18.3 µg/m³
  
These countries experienced the largest rises in PM2.5 levels, indicating a notable deterioration in air quality.

### Countries with the Lowest Average PM2.5 Levels (2010-2017)

The analysis of average PM2.5 levels for each country revealed the countries with the lowest average pollution levels:

- Finland: 6.5 µg/m³
- Brunei Darussalam: 6.7 µg/m³
- Iceland: 7.2 µg/m³

These countries had the lowest average PM2.5 levels, indicating relatively better air quality compared to others.

### Countries with the Highest Average PM2.5 Levels (2010-2017)

The analysis also highlighted the countries with the highest average PM2.5 levels:

- India: 91.6 µg/m³
- Egypt: 79.6 µg/m³
- Bahrain: 67.9 µg/m³
  
These countries had the highest average PM2.5 levels, reflecting more severe air quality issues.

### Geographic Distribution

An interactive map visualized the geographic distribution of PM2.5 levels across different countries. This map, color-coded based on average PM2.5 levels, facilitated a geographic comparison of air pollution and highlighted regions with severe air quality issues.

### Temporal Trends

The line graph displays the mean annual PM2.5 levels for all countries from 2010 to 2017. This visualization enables comparison of pollution trends across different countries, highlighting how air quality has changed over time and identifying any patterns of increase or decrease in pollution levels.

### Annual Averages

The bar chart presents the average PM2.5 levels for each country across the years 2010 to 2017. This chart provides a summary view of the average annual air pollution levels for each country, allowing for an easy comparison of overall pollution levels between countries on a yearly basis.

### Additional Insights

**Countries with Notable Decreases** - The analysis did not specifically identify countries with the largest decreases in PM2.5 levels, but such data could provide insights into successful air quality improvement initiatives.

**Trends Over Time** - While the temporal trends highlight changes in air quality over time, future analysis could benefit from identifying specific factors contributing to significant year-to-year variations.
