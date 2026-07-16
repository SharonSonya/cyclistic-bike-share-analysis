# Cyclistic Bike Share Analysis

## Project Overview

Cyclistic is a bike-share company that provides bicycles for riders across the city. This project analyzes bike usage patterns to understand the differences between annual members and casual riders.

The goal of this analysis was to identify how casual riders and annual members use Cyclistic bikes differently and provide data-driven recommendations that could help increase annual memberships.

## Business Task

The objective of this project was to analyze historical bike trip data and answer:

- How do annual members and casual riders use Cyclistic bikes differently?
- What patterns can be identified in ride frequency and ride duration?
- How can Cyclistic encourage casual riders to become annual members?

- ## Tools Used

- **MySQL** - Used for importing, cleaning, and preparing the Cyclistic trip data.
- **Tableau** - Used to create visualizations and build an interactive dashboard.
- **Excel/CSV Files** - Used as the original data source format.

## Data Preparation

The dataset was prepared before analysis by:

- Importing monthly Cyclistic trip data into MySQL.
- Combining multiple monthly datasets into one analysis table.
- Cleaning and formatting date and time fields.
- Calculating ride length using start and end timestamps.
- Creating additional fields such as day of the week and month for analysis.
- Checking and preparing the data for visualization in Tableau.

- ## Analysis & Insights

### 1. Rider Type Analysis

Annual members accounted for the majority of rides:

- Annual members: 2,131,682 rides (59.3%)
- Casual riders: 1,465,832 rides (40.7%)

**Insight:**  
Annual members generate more rides than casual riders, showing a strong existing membership base. However, casual riders represent a significant opportunity for membership growth.

---

### 2. Average Ride Length Analysis

The average ride duration differed significantly between rider types:

- Casual riders: 30.27 minutes
- Annual members: 13.36 minutes

**Insight:**  
Casual riders spend more time on each trip compared to annual members, suggesting they may use Cyclistic bikes mainly for leisure or recreational purposes.

---

### 3. Weekly Ride Pattern Analysis

The highest number of rides occurred on:

- Saturday

**Insight:**  
Ride activity increases during weekends, indicating strong demand for leisure and recreational bike usage.

---

### 4. Monthly Ride Trend Analysis

The highest number of rides occurred in:

- August: 771,436 rides

**Insight:**  
Bike usage peaks during warmer months, creating an opportunity for targeted seasonal marketing campaigns.

## Recommendations

Based on the analysis, the following recommendations can help Cyclistic increase annual memberships:

### 1. Convert Casual Riders into Annual Members

Casual riders represent 40.7% of total rides and have longer average ride durations compared to members. Cyclistic should target this group with membership campaigns, discounts, and incentives to encourage conversion.

### 2. Focus Marketing During Peak Usage Periods

Saturday had the highest number of rides, and August recorded the highest monthly usage. Cyclistic should increase promotions during weekends and peak riding months when customer engagement is highest.

### 3. Create Rider-Specific Marketing Strategies

Annual members and casual riders demonstrate different riding behaviours. Cyclistic should promote convenience and cost savings to members while highlighting flexibility and recreational benefits to casual riders.

## Conclusion

This analysis shows that Cyclistic has a strong annual membership base, but casual riders provide a significant opportunity for growth. By understanding rider behaviour and applying targeted marketing strategies, Cyclistic can increase casual rider conversions and grow its membership program.

## Skills Demonstrated

- Data cleaning and preparation
- SQL data analysis
- Data visualization with Tableau
- Dashboard design
- Business insights and recommendations
- Data storytelling

- ## Project Structure

cyclistic-bike-share-analysis

- README.md
- SQL
  - cyclistic_analysis.sql
- Tableau
  - cyclistic_dashboard.twbx
- Dashboard
  - cyclistic_dashboard.png
