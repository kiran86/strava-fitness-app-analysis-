-- 01_schema_creation.sql
-- Creates PostgreSQL database objects for the Strava/Fitbit analysis project.
-- Run with psql: psql -f sql/01_schema_creation.sql

-- Create database (psql-compatible approach).
SELECT 'CREATE DATABASE strava'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'strava')\gexec

\connect strava

CREATE SCHEMA IF NOT EXISTS strava;
SET search_path TO strava;

-- Raw landing tables (all text) for safe CSV ingestion.
CREATE TABLE IF NOT EXISTS raw_daily_activity (
    id TEXT,
    activity_date TEXT,
    total_steps TEXT,
    total_distance TEXT,
    tracker_distance TEXT,
    logged_activities_distance TEXT,
    very_active_distance TEXT,
    moderately_active_distance TEXT,
    light_active_distance TEXT,
    sedentary_active_distance TEXT,
    very_active_minutes TEXT,
    fairly_active_minutes TEXT,
    lightly_active_minutes TEXT,
    sedentary_minutes TEXT,
    calories TEXT
);

CREATE TABLE IF NOT EXISTS raw_sleep_day (
    id TEXT,
    sleep_day TEXT,
    total_sleep_records TEXT,
    total_minutes_asleep TEXT,
    total_time_in_bed TEXT
);

CREATE TABLE IF NOT EXISTS raw_weight_log (
    id TEXT,
    log_date TEXT,
    weight_kg TEXT,
    weight_pounds TEXT,
    fat TEXT,
    bmi TEXT,
    is_manual_report TEXT,
    log_id TEXT
);

CREATE TABLE IF NOT EXISTS raw_hourly_steps (
    id TEXT,
    activity_hour TEXT,
    step_total TEXT
);

CREATE TABLE IF NOT EXISTS raw_hourly_calories (
    id TEXT,
    activity_hour TEXT,
    calories TEXT
);

CREATE TABLE IF NOT EXISTS raw_hourly_intensities (
    id TEXT,
    activity_hour TEXT,
    total_intensity TEXT,
    average_intensity TEXT
);

CREATE TABLE IF NOT EXISTS raw_minute_mets (
    id TEXT,
    activity_minute TEXT,
    mets TEXT
);

CREATE TABLE IF NOT EXISTS raw_heart_rate (
    id TEXT,
    event_time TEXT,
    value TEXT
);

-- Curated typed tables.
CREATE TABLE IF NOT EXISTS daily_activity (
    id BIGINT NOT NULL,
    activity_date DATE NOT NULL,
    total_steps INTEGER,
    total_distance DOUBLE PRECISION,
    tracker_distance DOUBLE PRECISION,
    logged_activities_distance DOUBLE PRECISION,
    very_active_distance DOUBLE PRECISION,
    moderately_active_distance DOUBLE PRECISION,
    light_active_distance DOUBLE PRECISION,
    sedentary_active_distance DOUBLE PRECISION,
    very_active_minutes INTEGER,
    fairly_active_minutes INTEGER,
    lightly_active_minutes INTEGER,
    sedentary_minutes INTEGER,
    calories INTEGER,
    CONSTRAINT pk_daily_activity PRIMARY KEY (id, activity_date)
);

CREATE TABLE IF NOT EXISTS sleep_day (
    id BIGINT NOT NULL,
    sleep_day TIMESTAMP NOT NULL,
    total_sleep_records INTEGER,
    total_minutes_asleep INTEGER,
    total_time_in_bed INTEGER,
    CONSTRAINT pk_sleep_day PRIMARY KEY (id, sleep_day)
);

CREATE TABLE IF NOT EXISTS weight_log (
    id BIGINT NOT NULL,
    log_date TIMESTAMP NOT NULL,
    weight_kg DOUBLE PRECISION,
    weight_pounds DOUBLE PRECISION,
    fat DOUBLE PRECISION,
    bmi DOUBLE PRECISION,
    is_manual_report BOOLEAN,
    log_id BIGINT,
    CONSTRAINT pk_weight_log PRIMARY KEY (id, log_date)
);

CREATE TABLE IF NOT EXISTS hourly_steps (
    id BIGINT NOT NULL,
    activity_hour TIMESTAMP NOT NULL,
    step_total INTEGER,
    CONSTRAINT pk_hourly_steps PRIMARY KEY (id, activity_hour)
);

CREATE TABLE IF NOT EXISTS hourly_calories (
    id BIGINT NOT NULL,
    activity_hour TIMESTAMP NOT NULL,
    calories DOUBLE PRECISION,
    CONSTRAINT pk_hourly_calories PRIMARY KEY (id, activity_hour)
);

CREATE TABLE IF NOT EXISTS hourly_intensities (
    id BIGINT NOT NULL,
    activity_hour TIMESTAMP NOT NULL,
    total_intensity INTEGER,
    average_intensity DOUBLE PRECISION,
    CONSTRAINT pk_hourly_intensities PRIMARY KEY (id, activity_hour)
);

CREATE TABLE IF NOT EXISTS minute_mets (
    id BIGINT NOT NULL,
    activity_minute TIMESTAMP NOT NULL,
    mets INTEGER,
    CONSTRAINT pk_minute_mets PRIMARY KEY (id, activity_minute)
);

CREATE TABLE IF NOT EXISTS heart_rate (
    id BIGINT NOT NULL,
    event_time TIMESTAMP NOT NULL,
    value INTEGER,
    CONSTRAINT pk_heart_rate PRIMARY KEY (id, event_time)
);
