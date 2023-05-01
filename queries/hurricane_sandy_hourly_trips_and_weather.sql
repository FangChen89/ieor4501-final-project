
WITH RECURSIVE
    date_range (hour, n) AS (
        SELECT datetime(strftime('%Y-%m-%d %H', '2012-10-22 00:00:00', '+0 hours') || ':00:00') AS hour, 0 AS n
        UNION ALL
        SELECT datetime(strftime('%Y-%m-%d %H', '2012-10-22 00:00:00', '+' || (n + 1) || ' hours') || ':00:00') AS hour, n + 1
        FROM date_range
        WHERE n < 383
    ),
    trips AS (
        SELECT 
            datetime(strftime('%Y-%m-%d %H', pickup_datetime) || ':00:00') AS pickup_hour,
            COUNT(*) AS trip_count
        FROM (
            SELECT pickup_datetime FROM uber_trips
            UNION ALL
            SELECT pickup_datetime FROM taxi_trips
        )
        WHERE pickup_datetime BETWEEN '2012-10-22 00:00:00' AND '2012-11-06 23:59:59'
        GROUP BY pickup_hour
    )
SELECT
    dr.hour AS date_hour_range,
    COALESCE(t.trip_count, 0) AS trip_count,
    COALESCE(hw.hourly_precipitation, 0.0) AS hourly_precipitation,
    COALESCE(hw.hourly_windspeed, 0.0) AS hourly_windspeed
FROM
    date_range dr
LEFT JOIN
    trips t ON dr.hour = t.pickup_hour
LEFT JOIN
    hourly_weather hw ON dr.hour = datetime(strftime('%Y-%m-%d %H', hw.date) || ':00:00')
ORDER BY
    dr.hour;
