-- 02_import_data.sql
-- Loads CSV files into raw landing tables.
-- Run from repository root with psql so relative paths resolve:
-- psql -d strava -f sql/02_import_data.sql

SET search_path TO strava;

TRUNCATE TABLE
    raw_daily_activity,
    raw_sleep_day,
    raw_weight_log,
    raw_hourly_steps,
    raw_hourly_calories,
    raw_hourly_intensities,
    raw_minute_mets,
    raw_heart_rate;

\copy strava.raw_daily_activity
FROM 'data/raw/dailyActivity_merged.csv'
WITH (FORMAT csv, HEADER true);

\copy strava.raw_sleep_day
FROM 'data/raw/sleepDay_merged.csv'
WITH (FORMAT csv, HEADER true);

\copy strava.raw_weight_log
FROM 'data/raw/weightLogInfo_merged.csv'
WITH (FORMAT csv, HEADER true);

\copy strava.raw_hourly_steps
FROM 'data/raw/hourlySteps_merged.csv'
WITH (FORMAT csv, HEADER true);

\copy strava.raw_hourly_calories
FROM 'data/raw/hourlyCalories_merged.csv'
WITH (FORMAT csv, HEADER true);

\copy strava.raw_hourly_intensities
FROM 'data/raw/hourlyIntensities_merged.csv'
WITH (FORMAT csv, HEADER true);

\copy strava.raw_minute_mets
FROM 'data/raw/minuteMETsNarrow_merged.csv'
WITH (FORMAT csv, HEADER true);

\copy strava.raw_heart_rate
FROM 'data/raw/heartrate_seconds_merged.csv'
WITH (FORMAT csv, HEADER true);
