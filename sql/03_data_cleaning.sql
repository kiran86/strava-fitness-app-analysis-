-- 03_data_cleaning.sql
-- Cleans, standardizes, and loads typed analytics tables from raw landing tables.
-- Run after 01 and 02:
-- psql -d strava -f sql/03_data_cleaning.sql

SET search_path TO strava;

TRUNCATE TABLE
    daily_activity,
    sleep_day,
    weight_log,
    hourly_steps,
    hourly_calories,
    hourly_intensities,
    minute_mets,
    heart_rate;

-- Daily activity
INSERT INTO daily_activity (
    id, activity_date, total_steps, total_distance, tracker_distance,
    logged_activities_distance, very_active_distance, moderately_active_distance,
    light_active_distance, sedentary_active_distance, very_active_minutes,
    fairly_active_minutes, lightly_active_minutes, sedentary_minutes, calories
)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_DATE(NULLIF(TRIM(activity_date), ''), 'MM/DD/YYYY'),
    NULLIF(TRIM(total_steps), '')::INTEGER,
    NULLIF(TRIM(total_distance), '')::DOUBLE PRECISION,
    NULLIF(TRIM(tracker_distance), '')::DOUBLE PRECISION,
    NULLIF(TRIM(logged_activities_distance), '')::DOUBLE PRECISION,
    NULLIF(TRIM(very_active_distance), '')::DOUBLE PRECISION,
    NULLIF(TRIM(moderately_active_distance), '')::DOUBLE PRECISION,
    NULLIF(TRIM(light_active_distance), '')::DOUBLE PRECISION,
    NULLIF(TRIM(sedentary_active_distance), '')::DOUBLE PRECISION,
    NULLIF(TRIM(very_active_minutes), '')::INTEGER,
    NULLIF(TRIM(fairly_active_minutes), '')::INTEGER,
    NULLIF(TRIM(lightly_active_minutes), '')::INTEGER,
    NULLIF(TRIM(sedentary_minutes), '')::INTEGER,
    NULLIF(TRIM(calories), '')::INTEGER
FROM raw_daily_activity
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(activity_date), '') IS NOT NULL;

-- Sleep
INSERT INTO sleep_day (
    id, sleep_day, total_sleep_records, total_minutes_asleep, total_time_in_bed
)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_TIMESTAMP(NULLIF(TRIM(sleep_day), ''), 'MM/DD/YYYY HH12:MI:SS AM'),
    NULLIF(TRIM(total_sleep_records), '')::INTEGER,
    NULLIF(TRIM(total_minutes_asleep), '')::INTEGER,
    NULLIF(TRIM(total_time_in_bed), '')::INTEGER
FROM raw_sleep_day
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(sleep_day), '') IS NOT NULL;

-- Weight logs
INSERT INTO weight_log (
    id, log_date, weight_kg, weight_pounds, fat, bmi, is_manual_report, log_id
)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_TIMESTAMP(NULLIF(TRIM(log_date), ''), 'MM/DD/YYYY HH12:MI:SS AM'),
    NULLIF(TRIM(weight_kg), '')::DOUBLE PRECISION,
    NULLIF(TRIM(weight_pounds), '')::DOUBLE PRECISION,
    NULLIF(TRIM(fat), '')::DOUBLE PRECISION,
    NULLIF(TRIM(bmi), '')::DOUBLE PRECISION,
    CASE
        WHEN LOWER(TRIM(is_manual_report)) IN ('true', 't', '1', 'yes', 'y') THEN TRUE
        WHEN LOWER(TRIM(is_manual_report)) IN ('false', 'f', '0', 'no', 'n') THEN FALSE
        ELSE NULL
    END,
    NULLIF(TRIM(log_id), '')::BIGINT
FROM raw_weight_log
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(log_date), '') IS NOT NULL;

-- Hourly steps
INSERT INTO hourly_steps (id, activity_hour, step_total)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_TIMESTAMP(NULLIF(TRIM(activity_hour), ''), 'MM/DD/YYYY HH12:MI:SS AM'),
    NULLIF(TRIM(step_total), '')::INTEGER
FROM raw_hourly_steps
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(activity_hour), '') IS NOT NULL;

-- Hourly calories
INSERT INTO hourly_calories (id, activity_hour, calories)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_TIMESTAMP(NULLIF(TRIM(activity_hour), ''), 'MM/DD/YYYY HH12:MI:SS AM'),
    NULLIF(TRIM(calories), '')::DOUBLE PRECISION
FROM raw_hourly_calories
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(activity_hour), '') IS NOT NULL;

-- Hourly intensities
INSERT INTO hourly_intensities (id, activity_hour, total_intensity, average_intensity)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_TIMESTAMP(NULLIF(TRIM(activity_hour), ''), 'MM/DD/YYYY HH12:MI:SS AM'),
    NULLIF(TRIM(total_intensity), '')::INTEGER,
    NULLIF(TRIM(average_intensity), '')::DOUBLE PRECISION
FROM raw_hourly_intensities
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(activity_hour), '') IS NOT NULL;

-- Minute METs
INSERT INTO minute_mets (id, activity_minute, mets)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_TIMESTAMP(NULLIF(TRIM(activity_minute), ''), 'MM/DD/YYYY HH12:MI:SS AM'),
    NULLIF(TRIM(mets), '')::INTEGER
FROM raw_minute_mets
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(activity_minute), '') IS NOT NULL;

-- Heart rate
INSERT INTO heart_rate (id, event_time, value)
SELECT DISTINCT
    NULLIF(TRIM(id), '')::BIGINT,
    TO_TIMESTAMP(NULLIF(TRIM(event_time), ''), 'MM/DD/YYYY HH12:MI:SS AM'),
    NULLIF(TRIM(value), '')::INTEGER
FROM raw_heart_rate
WHERE NULLIF(TRIM(id), '') IS NOT NULL
  AND NULLIF(TRIM(event_time), '') IS NOT NULL;
