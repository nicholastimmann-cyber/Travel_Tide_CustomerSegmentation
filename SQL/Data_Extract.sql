-- Flights

select * 
from flights

-- Hotels

select hotel_name, count(trip_id)
from hotels
group by 
  hotel_name 

-- Table Sessions

select user_id
from sessions
where session_end < '04-01-2023'
group by user_id
  Having count(*) >=7


-- Table Users
select *
from users

SELECT
  gender,
  COUNT(user_id) AS anzahl,
  COUNT(user_id) * 100.0 / SUM(COUNT(user_id)) OVER () AS prozent
FROM users
GROUP BY gender; 

SELECT
  has_children,
  COUNT(user_id) AS anzahl,
  COUNT(user_id) * 100.0 / SUM(COUNT(user_id)) OVER () AS prozent
FROM users
GROUP BY has_children;

SELECT
  married,
  COUNT(user_id) AS anzahl,
  COUNT(user_id) * 100.0 / SUM(COUNT(user_id)) OVER () AS prozent
FROM users
GROUP BY married;

SELECT
  CASE
    WHEN EXTRACT(YEAR FROM AGE(current_date, birthdate)) < 26 THEN 'Young'
    WHEN EXTRACT(YEAR FROM AGE(current_date, birthdate)) < 42 THEN 'Adult'
    WHEN EXTRACT(YEAR FROM AGE(current_date, birthdate)) < 62 THEN 'Middleage'
    ELSE 'Old'
  END AS age_group,
  COUNT(user_id) AS anzahl,
  COUNT(user_id) * 100.0 / SUM(COUNT(user_id)) OVER () AS prozent
FROM users
  group by age_group;
 
-----------------------------------------------------------------------------------------------------------------

with eligible_users as(
select user_id
from sessions
where session_end < '04-01-2023'
group by user_id
  Having count(*) >=7 
)
select eu.user_id, f.*,h.*,s.*,u.*
  from eligible_users eu 
left join users u
on eu.user_id  = u.user_id  
full join sessions s 
on u.user_id  = s.user_id  
full join hotels h
on h.trip_id = s.trip_id 
full join flights f 
on f.trip_id = s.session_id
;

-- This CTE pre-limits our sessions to the suggested timeframe (After Jan 4 2023)
WITH sessions_2023 AS (
  SELECT
   *
  FROM sessions
  WHERE session_start > '2023-01-04'
),

-- This CTE returns the ids of all users with more than 7 sessions in 2023
filtered_users AS (
  SELECT user_id
  FROM sessions_2023
  GROUP BY user_id
  HAVING COUNT(session_id) > 7
),

-- This CTE joins the sessions with user, flight, and hotel data
session_base AS (
  SELECT
    s.session_id,
    s.user_id,
    s.trip_id,
    s.session_start,
    s.session_end,
    s.page_clicks,
    s.flight_discount,
    s.flight_discount_amount,
    s.hotel_discount,
    s.hotel_discount_amount,
    s.flight_booked,
    s.hotel_booked,
    s.cancellation,
    u.birthdate,
    u.gender,
    u.married,
    u.has_children,
    u.home_country,
    u.home_city,
    u.home_airport,
    u.home_airport_lat,
    u.home_airport_lon,
    u.sign_up_date,
    f.origin_airport,
    f.destination,
    f.destination_airport,
    f.seats,
    f.return_flight_booked,
    f.departure_time,
    f.return_time,
    f.checked_bags,
    f.trip_airline,
    f.destination_airport_lat,
    f.destination_airport_lon,
    f.base_fare_usd,
    h.hotel_name,
    h.nights,
    h.rooms,
    h.check_in_time,
    h.check_out_time,
    h.hotel_per_room_usd AS hotel_price_per_room_night_usd
  FROM sessions_2023 s
  LEFT JOIN users u
    ON s.user_id = u.user_id
  LEFT JOIN flights f
    ON s.trip_id = f.trip_id
  LEFT JOIN hotels h
    ON s.trip_id = h.trip_id
  WHERE
    s.user_id IN (
      SELECT user_id
      FROM filtered_users
    )
)

-- Final result set
SELECT *
FROM session_base;

