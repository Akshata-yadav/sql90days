CREATE TABLE rides (
    ride_id INT,
    city VARCHAR(50),
    distance_km INT,
    fare_amount INT
);

INSERT INTO rides VALUES
(1, 'Mumbai', 5, 100),
(2, 'Delhi', 10, 200),
(3, 'Mumbai', 8, 150),
(4, 'Delhi', 3, 80);

select * from rides;

---Find total number of rides in each city.
select city,count(*) as total_number from rides
group by city;

---Find total fare collected per city.
select * from rides;

select city,sum(fare_amount) as total_fare_collected from rides
group by city;

---Find average distance traveled per city.
select * from rides;

select city,avg(distance_km) as avg_distance_traveled from rides
group by city;

--- Find the maximum fare_amount.
select * from rides;

select max(fare_amount) as maxmum_fare_amount from rides;

---5. Find the ride with the highest fare in each city.
select * from (
select * ,rank() over(partition by city order by fare_amount desc) as rnk from rides )t
where rnk = 1;

---6. Find cities where average fare is greater than 120.
select * from rides;

select avg(fare_amount) as avg_fare ,city from rides 
group by city
having avg(fare_amount) > 120;

---Find total distance traveled for each city where total distance > 10.
select * from rides;

select city ,sum(distance_km) as total_distance from rides 
group by city 
having sum(distance_km) > 10;

---Rank rides within each city based on fare_amount (highest first).
select * from rides;

select ride_id,city,fare_amount,rank() over
(partition by city order by fare_amount desc) from rides;

---Find cumulative (running) fare per city ordered by ride_id.
select ride_id,city,fare_amount,sum(fare_amount) over
(partition by city order by ride_id) from rides;

---Find the difference between each ride’s fare and the previous ride’s fare within the same city.
select * from rides;

select ride_id,city,fare_amount,fare_amount -
lag(fare_amount) over (partition by city order by ride_id) as fare_diff from rides;

CREATE TABLE april7 (
    user_id INT,
    visit_date DATE,
    page_views INT,
    time_spent INT,   -- in minutes
    traffic_source VARCHAR(50)
);

INSERT INTO april7 VALUES
(1, '2024-01-01', 5, 10, 'Organic'),
(1, '2024-01-02', 3, 8, 'Paid'),
(1, '2024-01-03', 6, 15, 'Organic'),
(2, '2024-01-01', 4, 7, 'Referral'),
(2, '2024-01-03', 7, 20, 'Organic'),
(3, '2024-01-01', 2, 5, 'Paid'),
(3, '2024-01-02', 8, 25, 'Organic'),
(3, '2024-01-03', 5, 12, 'Referral');

select * from april7;

---Running total of time spent per user
select user_id,visit_date, time_spent ,sum(time_spent) over
(partition by user_id order by visit_date) as running_total
from april7;


--Rank visits per user based on page_views (highest first)
select * from april7;

select user_id,page_views,rank() over
(partition by user_id order by page_views desc) as rank_visits from april7;



---Find previous day's time_spent for each user
select * from april7;

select user_id ,visit_date,lag(time_spent) over(partition by user_id order by visit_date)
as lag_timespent from april7;

---Difference in page_views from next visit
select user_id,visit_date,page_views ,lead(page_views) over
(partition by user_id order by visit_date) as next_page_views,
page_views - lead(page_views) over(partition by user_id order by visit_date) as diff_from_next 
from april7;

select 
    user_id,
    visit_date,
    time_spent,
    sum(time_spent) over (partition by user_id) as total_time,
    (time_spent * 100.0 / sum(time_spent) over (partition by user_id)) as percentage_contribution
from april7;

