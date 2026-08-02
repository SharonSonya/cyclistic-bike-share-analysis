-- ==========================================
-- GOOGLE DATA ANALYTICS CAPSTONE PROJECT
-- Cyclistic Bike-Share Analysis
-- Author: Sharon Kam'mambala
-- ==========================================

-- Dataset:
-- Cyclistic bike trips from April 2023 to September 2023.

USE cyclistic_2023;

-- =====================================================
-- STEP 1: DATA QUALITY ASSESSMENT
-- =====================================================

-- 1. Total number of records
SELECT COUNT(*) AS total_rows
FROM cyclistic_2023_trips;

-- 2. Check for duplicate ride IDs

-- 3. Check for NULL values in important columns

-- 4. Check rider types

-- 5. Check bike types

-- 6. Check for invalid trip times
SELECT COUNT(*) AS invalid_time_rows
FROM cyclistic_2023_trips
WHERE ended_at <= started_at;

-- =====================================================
-- STEP 2: DATA CLEANING
-- =====================================================

-- Remove trips where the end time is earlier than or equal to the start time
DELETE FROM cyclistic_2023_trips
WHERE ended_at <= started_at;

-- Verify remaining records
SELECT COUNT(*) AS remaining_rows
FROM cyclistic_2023_trips;

-- Check for missing timestamps

SELECT
    SUM(started_at IS NULL) AS missing_started_at,
    SUM(ended_at IS NULL) AS missing_ended_at
FROM cyclistic_2023_trips;

-- Check for missing rider type

SELECT
    SUM(member_casual IS NULL) AS missing_member_type
FROM cyclistic_2023_trips;

-- Check rider types

SELECT
    member_casual,
    COUNT(*) AS total_rides
FROM cyclistic_2023_trips
GROUP BY member_casual;

SELECT
    rideable_type,
    COUNT(*) AS total_rides
FROM cyclistic_2023_trips
GROUP BY rideable_type;

-- =====================================================
-- STEP 1 COMPLETE: DATA QUALITY ASSESSMENT
-- =====================================================

-- Summary:
-- • Total records imported: 3,598,358
-- • Duplicate ride_id values: None found
-- • Missing started_at values: 0
-- • Missing ended_at values: 0
-- • Missing member_casual values: 0
-- • Valid rider types: member, casual
-- • Valid bike types: classic_bike, electric_bike, docked_bike
-- • Invalid trips identified: 844
-- • Invalid trips removed: 844
-- • Final cleaned dataset: 3,597,514 records

-- Data Quality Assessment completed successfully.


-- =====================================================
-- STEP 2: CREATE ANALYSIS DATASET
-- =====================================================
-- Objective:
-- Create a separate analysis table to preserve the cleaned
-- source dataset while allowing feature engineering and
-- exploratory data analysis without modifying the original data.
-- =====================================================

CREATE TABLE cyclistic_2023_analysis AS
SELECT *
FROM cyclistic_2023_trips;

SHOW TABLES;

SELECT COUNT(*) AS total_rows
FROM cyclistic_2023_analysis;

-- =====================================================
-- STEP 2 COMPLETE: ANALYSIS DATASET CREATED
-- =====================================================
--
-- Summary:
-- • Analysis dataset successfully created.
-- • Total records copied: 3,597,514
-- • Original cleaned dataset preserved.
-- • Analysis dataset ready for feature engineering.
-- =====================================================

-- =====================================================
-- STEP 3: FEATURE ENGINEERING
-- =====================================================
--
-- Objective:
-- Create new variables to support exploratory data analysis
-- and business insights.
-- =====================================================

ALTER TABLE cyclistic_2023_analysis
ADD COLUMN ride_length_minutes INT;

UPDATE cyclistic_2023_analysis
SET ride_length_minutes =
TIMESTAMPDIFF(MINUTE, started_at, ended_at);

SELECT
    COUNT(*) AS rows_updated
FROM cyclistic_2023_analysis
WHERE ride_length_minutes IS NOT NULL;

DESCRIBE cyclistic_2023_analysis;

ALTER TABLE cyclistic_2023_analysis
MODIFY ride_id VARCHAR(50) NOT NULL,
ADD PRIMARY KEY (ride_id);

DESCRIBE cyclistic_2023_analysis;

ALTER TABLE cyclistic_2023_analysis
MODIFY COLUMN ride_length_minutes DECIMAL(10,2);

UPDATE cyclistic_2023_analysis
SET ride_length_minutes =
ROUND(TIMESTAMPDIFF(SECOND, started_at, ended_at) / 60, 2);

SELECT
    MIN(ride_length_minutes) AS shortest_ride,
    MAX(ride_length_minutes) AS longest_ride,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride
FROM cyclistic_2023_analysis;

-- Note:
-- An unusually long maximum ride duration (98,489.07
-- minutes) was identified. Since these records did not
-- violate the project's data cleaning criterion
-- (ended_at > started_at), they were retained in the
-- dataset. These observations may represent genuine
-- extended rentals or data anomalies.

-- =====================================================
-- STEP 3.1 COMPLETE: CREATE RIDE LENGTH FEATURE
-- =====================================================
--
-- Summary:
-- • Created ride_length_minutes feature.
-- • Ride duration calculated using TIMESTAMPDIFF().
-- • Duration stored in decimal minutes.
-- • Total records processed: 3,597,514
--
-- Verification:
-- • Shortest ride: 0.02 minutes
-- • Longest ride: 98,489.07 minutes
-- • Average ride: 20.25 minutes
-- =====================================================

ALTER TABLE cyclistic_2023_analysis
ADD COLUMN day_of_week VARCHAR(15);

UPDATE cyclistic_2023_analysis
SET day_of_week = DAYNAME(started_at);

SELECT COUNT(*) AS rows_updated
FROM cyclistic_2023_analysis
WHERE day_of_week IS NOT NULL;

ALTER TABLE cyclistic_2023_analysis
DROP COLUMN day_of_week;


-- =====================================================
-- STEP 3: FEATURE ENGINEERING - COMPLETE
-- =====================================================
--
-- Objective:
-- Create analytical features required for business analysis.
--
-- Completed Tasks:
-- • Created a dedicated analysis table (cyclistic_2023_analysis)
--   to preserve the cleaned source dataset.
-- • Restored the Primary Key on ride_id after creating the
--   analysis table.
-- • Created the ride_length_minutes feature.
-- • Calculated ride duration in minutes using TIMESTAMPDIFF()
--   and stored the values as DECIMAL(10,2) for improved precision.
--
-- Validation:
-- • Total records: 3,597,514
-- • Shortest ride: 0.02 minutes
-- • Longest ride: 98,489.07 minutes
-- • Average ride: 20.25 minutes
--
-- Notes:
-- • Attempts to permanently store additional date-related
--   features (such as day of week) were not adopted due to
--   performance limitations when updating a local database
--   containing over 3.5 million records.
-- • Instead, these features will be generated dynamically
--   within SELECT statements during the analysis phase.
--
-- Status:
-- ✔ Feature Engineering Completed Successfully
-- =====================================================





-- =====================================================
-- STEP 4: EXPLORATORY DATA ANALYSIS (EDA)
-- =====================================================
--
-- Objective:
-- Analyze the riding behaviour of annual members and
-- casual riders to identify trends and provide
-- data-driven business recommendations for increasing
-- annual memberships.
-- =====================================================

-- The following business questions are designed to
-- identify behavioural differences between annual
-- members and casual riders in support of Cyclistic's
-- goal of increasing annual memberships.

-- -----------------------------------------------------
-- BUSINESS QUESTION 1
-- -----------------------------------------------------
-- Question:
-- How many rides were taken by each rider type?
-- -----------------------------------------------------

SELECT
    member_casual,
    COUNT(*) AS total_rides
FROM cyclistic_2023_analysis
GROUP BY member_casual;

-- Results:
-- Casual riders: 1,465,832 rides
-- Annual members: 2,131,682 rides
--
-- Interpretation:
-- Annual members completed more rides than casual riders
-- during the analysis period (April to September 2023).
--
-- Business Insight:
-- The higher number of rides by annual members suggests
-- they use Cyclistic more frequently, suggesting more regular
-- transportation patterns such as commuting or recurring trips.
-- This indicates an opportunity for Cyclistic to develop
-- strategies that encourage casual riders to become
-- annual members.

-- Recommendation:
-- Cyclistic should develop targeted marketing campaigns
-- that encourage casual riders to become annual members
-- by highlighting the value of frequent riding and
-- membership savings.

-- -----------------------------------------------------
-- BUSINESS QUESTION 2
-- -----------------------------------------------------
-- Question:
-- What is the average ride length for each rider type?
-- -----------------------------------------------------

SELECT
    member_casual,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM cyclistic_2023_analysis
GROUP BY member_casual;

-- Results:
-- Casual riders: 30.27 minutes
-- Annual members: 13.36 minutes
--
-- Interpretation:
-- Casual riders have a significantly longer average ride
-- duration than annual members.
--
-- Business Insight:
-- The longer ride durations suggest that casual riders are
-- more likely to use Cyclistic bikes for leisure, sightseeing,
-- or recreational trips. In contrast, annual members appear
-- to use the service for shorter, more frequent trips, which
-- is consistent with commuting or routine transportation.
--
-- Recommendation:
-- Cyclistic could encourage casual riders to become annual
-- members by promoting membership benefits that support
-- frequent riding, such as cost savings, convenience, and
-- unlimited access for regular trips.


-- -----------------------------------------------------
-- BUSINESS QUESTION 3
-- -----------------------------------------------------
-- Question:
-- Which bike types are preferred by casual riders and
-- annual members?
-- -----------------------------------------------------

SELECT
    rideable_type,
    member_casual,
    COUNT(*) AS total_rides
FROM cyclistic_2023_analysis
GROUP BY rideable_type, member_casual
ORDER BY rideable_type, member_casual;

-- Results:
-- Classic Bike:
-- - Casual riders: 641,953 rides
-- - Annual members: 1,076,796 rides
--
-- Electric Bike:
-- - Casual riders: 759,792 rides
-- - Annual members: 1,054,886 rides
--
-- Docked Bike:
-- - Casual riders: 64,087 rides
-- - Annual members: 0 rides
--
-- Interpretation:
-- Annual members completed more rides than casual riders
-- on both classic and electric bikes. Casual riders used
-- electric bikes more frequently than classic bikes.
-- Docked bikes were used only by casual riders during the
-- analysis period.
--
-- Business Insight:
-- Electric bikes appear to be particularly attractive to
-- casual riders, suggesting that convenience and ease of
-- use may influence their riding behaviour. Cyclistic could
-- consider promoting membership plans that highlight the
-- benefits of frequent electric bike usage to encourage
-- casual riders to become annual members.

-- Recommendation:
-- Cyclistic should promote annual memberships by
-- highlighting the convenience and availability of
-- electric bikes, particularly to casual riders.

-- -----------------------------------------------------
-- BUSINESS QUESTION 4
-- -----------------------------------------------------
-- Question:
-- On which days of the week do annual members and
-- casual riders use Cyclistic bikes most frequently?
-- -----------------------------------------------------
    
SELECT
    DAYOFWEEK(started_at) AS day_number,
    DAYNAME(started_at) AS day_of_week,
    member_casual,
    COUNT(*) AS total_rides
FROM cyclistic_2023_analysis
GROUP BY
    DAYOFWEEK(started_at),
    DAYNAME(started_at),
    member_casual
ORDER BY
    day_number,
    member_casual;
    
    
    -- Results:
-- Sunday:
-- - Casual riders: 237,455 rides
-- - Annual members: 239,448 rides
--
-- Monday:
-- - Casual riders: 165,299 rides
-- - Annual members: 275,311 rides
--
-- Tuesday:
-- - Casual riders: 167,520 rides
-- - Annual members: 321,293 rides
--
-- Wednesday:
-- - Casual riders: 168,272 rides
-- - Annual members: 332,244 rides
--
-- Thursday:
-- - Casual riders: 186,969 rides
-- - Annual members: 341,984 rides
--
-- Friday:
-- - Casual riders: 229,432 rides
-- - Annual members: 321,431 rides
--
-- Saturday:
-- - Casual riders: 310,885 rides
-- - Annual members: 299,971 rides
--
-- Interpretation:
-- Annual members recorded more rides than casual riders on
-- weekdays, particularly from Tuesday to Thursday.
-- The weekday riding pattern suggests that annual members
-- are more likely to use Cyclistic for commuting or other
-- routine transportation.
--
-- Casual riders recorded their highest number of rides on
-- weekends, especially on Saturday, suggesting that they
-- are more likely to use Cyclistic for leisure or
-- recreational purposes.
--
-- Business Insight:
-- Cyclistic could develop weekend marketing campaigns that
-- encourage casual riders to become annual members by
-- promoting the value of membership for both recreational
-- and everyday travel.

-- Recommendation:
-- Cyclistic should target casual riders during weekends
-- with membership promotions that encourage continued
-- use throughout the week.

-- -----------------------------------------------------
-- BUSINESS QUESTION 5
-- -----------------------------------------------------
-- Question:
-- At what time of day are Cyclistic bikes most frequently
-- used by annual members and casual riders?
-- -----------------------------------------------------


SELECT
    HOUR(started_at) AS hour_of_day,
    member_casual,
    COUNT(*) AS total_rides
FROM cyclistic_2023_analysis
GROUP BY
    HOUR(started_at),
    member_casual
ORDER BY
    hour_of_day,
    member_casual;
    
    
    -- Results:
-- The analysis showed the number of rides for each hour of
-- the day (00:00–23:00) for both casual riders and annual
-- members.
--
-- Key Findings:
-- - Annual members recorded their highest number of rides
--   at 17:00 (224,821 rides), followed by 16:00 and 18:00.
-- - Casual riders recorded their highest number of rides
--   at 17:00 (142,184 rides), followed by 16:00 and 18:00.
-- - Ride activity for both rider types was lowest during
--   the early morning hours (02:00–05:00).
--
-- Interpretation:
-- Ride activity gradually increases during the morning,
-- reaches its highest levels during the late afternoon,
-- and then declines during the evening.
--
-- Annual members display a pronounced increase in rides
-- during the morning (07:00–09:00) and late afternoon
-- (16:00–18:00), suggesting that they are more likely to
-- use Cyclistic for commuting or other routine travel.
--
-- Casual riders also peak during the late afternoon and
-- early evening, but their riding activity is more evenly
-- distributed throughout the daytime, suggesting greater
-- use for leisure and recreational trips.
--
-- Business Insight:
-- The distinct riding patterns indicate that annual
-- members rely on Cyclistic for regular daily travel,
-- while casual riders are more flexible in when they ride.
--
-- Recommendation:
-- Cyclistic could target casual riders with promotions
-- during afternoons and weekends, highlighting the
-- convenience and cost savings of annual memberships for
-- riders who use the service frequently.

-- -----------------------------------------------------
-- BUSINESS QUESTION 6
-- -----------------------------------------------------
-- Question:
-- How does bike usage vary by month for annual members
-- and casual riders?
-- -----------------------------------------------------

SELECT
    MONTH(started_at) AS month_number,
    MONTHNAME(started_at) AS month,
    member_casual,
    COUNT(*) AS total_rides
FROM cyclistic_2023_analysis
GROUP BY
    MONTH(started_at),
    MONTHNAME(started_at),
    member_casual
ORDER BY
    month_number,
    member_casual;
    
    -- Results:
-- April:
-- - Casual riders: 26,689 rides
-- - Annual members: 41,500 rides
--
-- May:
-- - Casual riders: 234,153 rides
-- - Annual members: 370,603 rides
--
-- June:
-- - Casual riders: 301,198 rides
-- - Annual members: 418,347 rides
--
-- July:
-- - Casual riders: 331,252 rides
-- - Annual members: 436,185 rides
--
-- August:
-- - Casual riders: 311,006 rides
-- - Annual members: 460,430 rides
--
-- September:
-- - Casual riders: 261,534 rides
-- - Annual members: 404,617 rides
--
-- Interpretation:
-- Bike usage increased steadily from April to July for both
-- rider types. Casual rider activity reached its highest
-- level in July, while annual member activity peaked in
-- August. Ride volumes declined in September for both
-- groups.
--
-- Business Insight:
-- The increase in rides during the summer months suggests
-- that warmer weather encourages greater use of Cyclistic
-- bikes. Annual members consistently recorded more rides
-- than casual riders throughout the analysis period.
--
-- Recommendation:
-- Cyclistic should increase marketing campaigns and
-- membership promotions during the peak riding season
-- (May to August) to encourage casual riders to convert
-- to annual memberships when bike usage is at its highest.

-- -----------------------------------------------------
-- BUSINESS QUESTION 7
-- -----------------------------------------------------
-- Question:
-- Which start stations recorded the highest number of rides?
-- -----------------------------------------------------

SELECT
    start_station_name,
    COUNT(*) AS total_rides
FROM cyclistic_2023_analysis
WHERE start_station_name IS NOT NULL
  AND start_station_name <> ''
GROUP BY start_station_name
ORDER BY total_rides DESC
LIMIT 10;
-- -----------------------------------------------------
-- Results:
-- Top 10 start stations:
-- 1. Streeter Dr & Grand Ave - 49,940 rides
-- 2. DuSable Lake Shore Dr & Monroe St - 30,247 rides
-- 3. Michigan Ave & Oak St - 29,910 rides
-- 4. DuSable Lake Shore Dr & North Blvd - 29,418 rides
-- 5. Theater on the Lake - 24,970 rides
-- 6. Millennium Park - 22,323 rides
-- 7. Wells St & Concord Ln - 21,862 rides
-- 8. Clark St & Elm St - 21,735 rides
-- 9. Kingsbury St & Kinzie St - 19,401 rides
-- 10. Broadway & Barry Ave - 18,909 rides
--
-- Interpretation:
-- A small number of stations consistently recorded very
-- high ride volumes, indicating that they are major
-- pickup locations within the Cyclistic network.
--
-- Business Insight:
-- Popular stations are critical to customer satisfaction
-- because they experience the highest demand. Maintaining
-- adequate bike availability at these locations can help
-- improve the rider experience.
--
-- Recommendation:
-- Cyclistic should prioritize bicycle redistribution and
-- maintenance at high-demand stations. The company should
-- also consider placing membership advertisements or QR
-- code sign-up campaigns at these stations to encourage
-- casual riders to subscribe to annual memberships.


-- =====================================================
-- STEP 5: KEY FINDINGS
-- =====================================================

-- Key Finding 1:
-- Annual members completed more rides than casual riders
-- throughout the analysis period.
--
-- -----------------------------------------------------
-- Key Finding 2:
-- Casual riders recorded a much longer average ride
-- duration (30.27 minutes) than annual members
-- (13.36 minutes).
-- -----------------------------------------------------

-- Key Finding 3:
-- Annual members rode more frequently during weekdays,
-- while casual riders were most active on weekends.
--
-- -----------------------------------------------------
--
-- Key Finding 4:
-- Electric bikes were highly popular among both rider
-- types, particularly casual riders.
--
-- -----------------------------------------------------
--
-- Key Finding 5:
-- Ride activity increased during the summer months,
-- reaching its highest levels in July and August before
-- declining in September.
--
-- -----------------------------------------------------
--
-- Key Finding 6:
-- A small number of start stations accounted for a large
-- proportion of ride departures, with Streeter Dr &
-- Grand Ave recording the highest number of rides.

-- =====================================================
-- STEP 6: BUSINESS RECOMMENDATIONS
-- =====================================================
--
-- Recommendation 1:
-- Continue to retain annual members through loyalty
-- programmes while encouraging casual riders to convert
-- to annual memberships.
--
-- -----------------------------------------------------
--
-- Recommendation 2:
-- Promote annual memberships by highlighting long-term
-- cost savings for riders who frequently take longer
-- trips.
--
-- -----------------------------------------------------
--
-- Recommendation 3:
-- Launch weekend marketing campaigns aimed at casual
-- riders when their activity is highest.
--
-- -----------------------------------------------------
--
-- Recommendation 4:
-- Highlight the convenience and availability of electric
-- bikes within membership promotions.
-- -----------------------------------------------------
--
-- Recommendation 5:
-- Increase promotional campaigns during the peak riding
-- season (May–August), when casual rider activity is at
-- its highest.
-- -----------------------------------------------------
-- Recommendation 6:
-- Prioritize bicycle redistribution and maintenance at
-- high-demand stations and promote memberships through
-- advertising at these locations.
-- -----------------------------------------------------

-- =====================================================
-- STEP 7: FINAL CONCLUSION
-- =====================================================

-- The analysis identified clear behavioural differences
-- between annual members and casual riders.
--
-- Annual members generally completed more rides,
-- travelled for shorter durations, and rode more
-- frequently during weekdays, suggesting routine travel.
--
-- Casual riders generally took longer rides and were
-- more active during weekends and the summer months,
-- suggesting recreational use.
--
-- Based on these findings, Cyclistic should focus its
-- marketing efforts on converting casual riders into
-- annual members by promoting the financial savings,
-- convenience and long-term value of annual membership,
-- particularly during weekends and peak riding months.

-- =====================================================
-- END OF PROJECT
-- =====================================================

-- End of Cyclistic Bike-Share Analysis
-- Google Data Analytics Capstone Project
-- Author: Sharon Kam'mambala
-- =====================================================