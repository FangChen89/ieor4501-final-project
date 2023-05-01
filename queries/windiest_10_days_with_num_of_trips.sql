
WITH all_trips AS (SELECT pickup_datetime, distance FROM taxi_trips
                   UNION ALL
                   SELECT pickup_datetime, distance FROM uber_trips)
SELECT
    w.date, w.daily_average_windspeed, COUNT(*) as num_trips
FROM
    daily_weather AS w
    JOIN
    all_trips AS t ON strftime('%Y-%m-%d', w.date) = strftime('%Y-%m-%d', t.pickup_datetime)
WHERE
    w.date BETWEEN '2014-01-01' AND '2014-12-31'
GROUP BY
    w.date
ORDER BY
    w.daily_average_windspeed DESC
LIMIT 10;
