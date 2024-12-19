use Case_Study_1_OYO;

Select * from Oyo_Sales;
select * from Oyo_City;

-- 1. Average Room Rates of Different Cities
WITH CityBookings AS (
    SELECT os.hotel_id, oc.city, os.amount - os.discount AS net_amount
    FROM Oyo_Sales os
    JOIN Oyo_City oc ON os.hotel_id = oc.hotel_id
    WHERE os.status != 'Cancelled'
)
SELECT city, AVG(net_amount) AS avg_room_rate FROM CityBookings GROUP BY city ORDER BY avg_room_rate DESC;


-- 2. Number of Bookings in January, February, and March by City
SELECT oc.city, MONTH(os.check_in) AS booking_month, COUNT(*) AS booking_count
FROM Oyo_Sales os
JOIN Oyo_City oc ON os.hotel_id = oc.hotel_id
WHERE MONTH(os.check_in) IN (1, 2, 3)
GROUP BY oc.city, MONTH(os.check_in)
ORDER BY oc.city, booking_month;


-- 3. Frequency of Early Bookings Prior to Check-In
SELECT DATEDIFF(day, os.date_of_booking, os.check_in) AS days_prior, COUNT(*) AS frequency
FROM Oyo_Sales os WHERE os.status != 'Cancelled'
GROUP BY DATEDIFF(day, os.date_of_booking, os.check_in)
ORDER BY days_prior;


-- 4. Frequency of Bookings by Number of Rooms
SELECT no_of_rooms, COUNT(*) AS booking_count
FROM Oyo_Sales WHERE status != 'Cancelled' GROUP BY no_of_rooms
ORDER BY booking_count DESC;


-- 5. New Customers in January
SELECT customer_id, COUNT(*) AS bookings_in_jan
FROM Oyo_Sales WHERE MONTH(date_of_booking) = 1 GROUP BY customer_id HAVING COUNT(*) = 1;


-- 6. Net Revenue to the Company (Excluding Canceled Bookings)
SELECT SUM(amount - discount) AS net_revenue FROM Oyo_Sales WHERE status != 'Cancelled';


-- 7. Gross Revenue to the Company
SELECT SUM(amount) AS gross_revenue FROM Oyo_Sales;


-- 8. Average Room Rates of Different Cities
WITH CityBookings AS (
    SELECT os.hotel_id, oc.city, os.amount - os.discount AS net_amount
    FROM Oyo_Sales os
    JOIN Oyo_City oc ON os.hotel_id = oc.hotel_id
    WHERE os.status != 'Cancelled'
)
SELECT city, AVG(net_amount) AS avg_room_rate
FROM CityBookings GROUP BY city ORDER BY avg_room_rate DESC;


-- 9. Monthly Cancellations and Booking Trends by City with Percentage of Cancellations
WITH MonthlyBookings AS (
    SELECT 
        oc.city,
        MONTH(os.check_in) AS booking_month,
        COUNT(CASE WHEN os.status = 'Cancelled' THEN 1 END) AS cancellations,
        COUNT(*) AS total_bookings
    FROM Oyo_Sales os
    JOIN Oyo_City oc ON os.hotel_id = oc.hotel_id
    GROUP BY oc.city, MONTH(os.check_in)
)
SELECT city,booking_month,cancellations,total_bookings,
ROUND((CAST(cancellations AS FLOAT) / total_bookings) * 100, 2) AS cancellation_percentage
FROM MonthlyBookings ORDER BY cancellation_percentage DESC, city, booking_month;

-- 10. Top 3 Cities by Revenue with Average Room Rate and Cancellation Impact
WITH CityRevenue AS (
    SELECT 
        oc.city,
        SUM(CASE WHEN os.status != 'Cancelled' THEN os.amount - os.discount ELSE 0 END) AS net_revenue,
        AVG(CASE WHEN os.status != 'Cancelled' THEN os.amount - os.discount END) AS avg_room_rate,
        SUM(CASE WHEN os.status = 'Cancelled' THEN os.amount - os.discount ELSE 0 END) AS canceled_revenue
    FROM Oyo_Sales os
    JOIN Oyo_City oc ON os.hotel_id = oc.hotel_id
    GROUP BY oc.city
)
SELECT 
    city,
    net_revenue,
    avg_room_rate,
    canceled_revenue,
    (net_revenue + canceled_revenue) AS potential_gross_revenue
FROM CityRevenue
ORDER BY net_revenue DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;


-- 11. Customers with the Most Last-Minute Bookings and Their Total Spend
WITH LastMinuteBookings AS (
    SELECT 
        customer_id,
        COUNT(*) AS last_minute_count,
        SUM(amount - discount) AS total_spend
    FROM Oyo_Sales
    WHERE DATEDIFF(day, date_of_booking, check_in) = 0
    AND status != 'Cancelled'
    GROUP BY customer_id
)
SELECT 
    customer_id,
    last_minute_count,
    total_spend,
    RANK() OVER (ORDER BY last_minute_count DESC, total_spend DESC) AS rank
FROM LastMinuteBookings
WHERE last_minute_count >= 5
ORDER BY rank;


-- 12. Booking Patterns for Single vs. Multiple Room Stays by City
WITH RoomBookingPatterns AS (
    SELECT 
        oc.city,
        CASE WHEN os.no_of_rooms = 1 THEN 'Single Room' ELSE 'Multiple Rooms' END AS room_type,
        COUNT(*) AS booking_count,
        SUM(os.amount - os.discount) AS total_revenue,
        AVG(DATEDIFF(day, os.check_in, os.check_out)) AS avg_stay_length
    FROM Oyo_Sales os
    JOIN Oyo_City oc ON os.hotel_id = oc.hotel_id
    WHERE os.status != 'Cancelled'
    GROUP BY oc.city, CASE WHEN os.no_of_rooms = 1 THEN 'Single Room' ELSE 'Multiple Rooms' END
)
SELECT 
    city,
    room_type,
    booking_count,
    total_revenue,
    avg_stay_length
FROM RoomBookingPatterns
ORDER BY city, room_type;



-- 13. Top Returning Customers with Average Booking Interval and Total Spend
WITH CustomerBookings AS (
    SELECT 
        customer_id,
        check_in,
        amount - discount AS net_amount,
        LAG(check_in) OVER (PARTITION BY customer_id ORDER BY check_in) AS previous_check_in
    FROM Oyo_Sales
    WHERE status != 'Cancelled'
),
CustomerIntervals AS (
    SELECT 
        customer_id,
        COUNT(*) AS total_bookings,
        SUM(net_amount) AS total_spend,
        AVG(DATEDIFF(day, previous_check_in, check_in)) AS avg_booking_interval
    FROM CustomerBookings
    WHERE previous_check_in IS NOT NULL
    GROUP BY customer_id
)
SELECT 
    customer_id,
    total_bookings,
    total_spend,
    avg_booking_interval,
    RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
FROM CustomerIntervals
WHERE total_bookings > 1
ORDER BY spend_rank;
