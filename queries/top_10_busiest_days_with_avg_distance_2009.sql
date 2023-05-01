
SELECT
    date(pickup_datetime) AS pickup_date,
    COUNT(*) AS total_rides,
    AVG(distance) AS avg_distance
FROM
    (
        SELECT pickup_datetime, distance
        FROM uber_trips
        WHERE strftime('%Y', pickup_datetime) = '2009'
        UNION ALL
        SELECT pickup_datetime, distance
        FROM taxi_trips
        WHERE strftime('%Y', pickup_datetime) = '2009'
    )
GROUP BY
    pickup_date
ORDER BY
    total_rides DESC, pickup_date
LIMIT 10;
