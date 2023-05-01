
SELECT 
    strftime('%H', pickup_datetime), 
    COUNT(*) AS Count
FROM
    taxi_trips
GROUP BY 
    strftime('%H', pickup_datetime)
ORDER BY 
    Count DESC;
