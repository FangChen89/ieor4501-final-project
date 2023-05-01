
WITH all_trips AS (SELECT pickup_datetime, distance FROM taxi_trips
                   UNION ALL
                   SELECT pickup_datetime, distance FROM uber_trips)
SELECT
    distance
FROM
    all_trips
WHERE
    strftime('%Y', pickup_datetime) = '2013' AND strftime('%m', pickup_datetime) = '07'
ORDER BY
    distance
lIMIT 1
OFFSET (SELECT COUNT(*)
        FROM all_trips
        WHERE strftime('%Y', pickup_datetime) = '2013' AND strftime('%m', pickup_datetime) = '07') * 95 / 100 - 1;
