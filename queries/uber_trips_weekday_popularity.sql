
SELECT
    CASE
        WHEN strftime('%w', pickup_datetime) = '0' THEN 'Sunday'
        WHEN strftime('%w', pickup_datetime) = '1' THEN 'Monday'
        WHEN strftime('%w', pickup_datetime) = '2' THEN 'Tuesday'
        WHEN strftime('%w', pickup_datetime) = '3' THEN 'Wednesday'
        WHEN strftime('%w', pickup_datetime) = '4' THEN 'Thursday'
        WHEN strftime('%w', pickup_datetime) = '5' THEN 'Friday'
        WHEN strftime('%w', pickup_datetime) = '6' THEN 'Saturday'
    END AS weekday,
    COUNT(*) AS popularity
FROM
    uber_trips
GROUP BY
    weekday
ORDER BY
    popularity DESC;
