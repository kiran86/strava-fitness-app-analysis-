CREATE SCHEMA strava;

SET search_path TO strava;

CREATE TABLE daily_activity (
    id BIGINT,
    activity_date DATE,
    total_steps INT,
    total_distance FLOAT,
    tracker_distance FLOAT,
    logged_activities_distance FLOAT,
    very_active_distance FLOAT,
    moderately_active_distance FLOAT,
    light_active_distance FLOAT,
    sedentary_active_distance FLOAT,
    very_active_minutes INT,
    fairly_active_minutes INT,
    lightly_active_minutes INT,
    sedentary_minutes INT,
    calories INT
);

CREATE TABLE sleep_day (
    id BIGINT,
    sleep_day DATE,
    total_sleep_records INT,
    total_minutes_asleep INT,
    total_time_in_bed INT
);

CREATE TABLE weight_log (
    id BIGINT,
    log_date DATE,
    weight_kg FLOAT,
    weight_pounds FLOAT,
    fat FLOAT,
    bmi FLOAT,
    is_manual_report BOOLEAN
);

CREATE TABLE hourly_steps (
    id BIGINT,
    activity_hour TIMESTAMP,
    step_total INT
);

CREATE TABLE hourly_calories (
    id BIGINT,
    activity_hour TIMESTAMP,
    calories FLOAT
);

CREATE TABLE hourly_intensities (
    id BIGINT,
    activity_hour TIMESTAMP,
    total_intensity INT,
    average_intensity FLOAT
);

CREATE TABLE minute_mets (
    id BIGINT,
    activity_minute TIMESTAMP,
    mets INT
);

CREATE TABLE heart_rate (
    id BIGINT,
    time TIMESTAMP,
    value INT
);