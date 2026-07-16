# Cyclistic Bike Share Analysis

## Project Overview

Cyclistic is a bike-share company that provides bicycles for riders across the city. This project analyzes bike usage patterns to understand the differences between annual members and casual riders.

The goal of this analysis was to identify how casual riders and annual members use Cyclistic bikes differently and provide data-driven recommendations that could help increase annual memberships.

Analysis Period:** April 2023 – September 2023

---

## Business Task

The objective of this project was to analyze historical bike trip data and answer the following questions:

 How do annual members and casual riders use Cyclistic bikes differently?
 What patterns can be identified in ride frequency and ride duration?
 How can Cyclistic encourage casual riders to become annual members?

---

## Tools Used

MySQL - Used for importing, cleaning, transforming, and preparing Cyclistic trip data.
Tableau Desktop** - Used to create visualizations and build an interactive dashboard.
Excel/CSV Files** - Used as the original data source format.

---

## Data Preparation

The dataset was prepared before analysis by:

 Importing monthly Cyclistic trip data into MySQL.
 Combining multiple monthly datasets into one analysis table.
 Cleaning and formatting date and time fields.
 Calculating ride length using start and end timestamps.
 Creating additional fields such as day of week and month for analysis.
 Checking and preparing the cleaned data for visualization in Tableau.

---

## Analysis & Insights

### 1. Rider Type Analysis

Members accounted for the majority of rides:

Members: 2,131,682 rides (59.3%)
  Casual riders:** 1,465,832 rides (40.7%)

Insight:
Members generate more rides than casual riders, showing a strong existing membership base. However, casual riders represent a significant opportunity for membership growth.

---

### 2. Average Ride Length Analysis

The average ride duration differed significantly between rider types:

Casual riders:30.27 minutes
Members:13.36 minutes

Insight:
Casual riders have longer average trips compared to members, suggesting they may use Cyclistic bikes more for leisure and recreational activities, while members may use bikes more frequently for shorter everyday trips.

---

### 3. Weekly Ride Pattern Analysis

The highest number of rides occurred on:

Saturday

Insight:
Ride activity increases during weekends, indicating strong demand for recreational bike usage.

---

### 4. Monthly Ride Trend Analysis

The highest number of rides occurred in:

August: 771,436 rides

Insight:
Bike usage peaks during warmer months, creating opportunities for seasonal membership campaigns.

---

## Recommendations

### 1. Convert Casual Riders into Members

Casual riders represent 40.7% of total rides and have longer average ride durations. Cyclistic should target this group with:

 Membership discounts
 Limited-time conversion offers
 Loyalty rewards
 In-app membership promotions

### 2. Focus Marketing During Peak Usage Periods

Saturday had the highest number of rides, and August recorded the highest monthly usage. Cyclistic should increase promotional campaigns during weekends and peak riding months.

### 3. Create Rider-Specific Marketing Strategies

Different riding behaviours require different approaches:

 Promote convenience, savings, and commuting benefits to casual riders who ride frequently.
 Highlight flexibility and recreational benefits to occasional riders.

---

## Conclusion

This analysis shows that Cyclistic has a strong member base, but casual riders provide a significant opportunity for membership growth.

By understanding rider behaviour and applying targeted marketing strategies, Cyclistic can improve casual rider conversion rates and increase annual memberships.

---

## Skills Demonstrated

 Data cleaning and preparation
 SQL data analysis
 Data visualization with Tableau
 Dashboard design
 Business insights generation
 Data storytelling

---

## Project Structure

```
cyclistic-bike-share-analysis

├── README.md
├── SQL
│   └── cyclistic_analysis.sql
├── Tableau
│   └── cyclistic_dashboard.twbx
└── Dashboard
    └── cyclistic_dashboard.png
```
