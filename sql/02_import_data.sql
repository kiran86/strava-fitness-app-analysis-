COPY strava.daily_activity
FROM '/data/raw/dailyActivity_merged.csv'
DELIMITER ','
CSV HEADER;

COPY strava.sleep_day
FROM '/data/raw/sleepDay_merged.csv'
DELIMITER ','
CSV HEADER;

COPY strava.weight_log
FROM '/data/raw/weightLogInfo_merged.csv'
DELIMITER ','
CSV HEADER;

COPY strava.hourly_steps
FROM '/data/raw/hourlySteps_merged.csv'
DELIMITER ','
CSV HEADER;

COPY strava.hourly_calories
FROM '/data/raw/hourlyCalories_merged.csv'
DELIMITER ','
CSV HEADER;

COPY strava.hourly_intensities
FROM '/data/raw/hourlyIntensities_merged.csv'
DELIMITER ','
CSV HEADER;

COPY strava.minute_mets
FROM '/data/raw/minuteMETsNarrow_merged.csv'
DELIMITER ','
CSV HEADER;

COPY strava.heart_rate
FROM '/data/raw/heartrate_seconds_merged.csv'
DELIMITER ','
CSV HEADER;