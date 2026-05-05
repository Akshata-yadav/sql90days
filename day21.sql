CREATE TABLE day21 (
    record_id INT PRIMARY KEY,
    city VARCHAR(50),
    record_date DATE,
    temperature DECIMAL(5,2),
    humidity INT,
    rainfall DECIMAL(5,2),
    weather_condition VARCHAR(30) -- Sunny, Rainy, Cloudy
);

INSERT INTO day21 VALUES
(1, 'Mumbai', '2024-01-01', 30.5, 70, 5.2, 'Rainy'),
(2, 'Delhi', '2024-01-01', 18.2, 60, 0.0, 'Sunny'),
(3, 'Pune', '2024-01-01', 25.0, 65, 1.0, 'Cloudy'),
(4, 'Mumbai', '2024-01-02', 31.0, 75, 10.5, 'Rainy'),
(5, 'Delhi', '2024-01-02', 17.5, 55, 0.0, 'Sunny'),
(6, 'Pune', '2024-01-02', 24.5, 68, 2.0, 'Rainy'),
(7, 'Mumbai', '2024-01-03', 29.0, 80, 15.0, 'Rainy'),
(8, 'Delhi', '2024-01-03', 19.0, 58, 0.0, 'Cloudy'),
(9, 'Pune', '2024-01-03', 26.0, 60, 0.5, 'Sunny'),
(10, 'Mumbai', '2024-01-04', 28.5, 85, 20.0, 'Rainy');

select * from day21;

----Show all records where weather condition is Rainy
select * from day21 where weather_condition = 'Rainy';

---Find average temperature per city.
select city ,  avg(temperature) as avg_temp from day21
group by city;

---Get total rainfall per city.
select * from day21;

select city, sum(rainfall) as total_rainfall from day21
group by city;

---Find the hottest day (max temperature) per city.
SELECT *
FROM (
    SELECT 
        city,
        record_date,
        temperature,
        RANK() OVER (PARTITION BY city ORDER BY temperature DESC) AS rnk
    FROM day21
) t
WHERE rnk = 1;

---Get days where humidity > 70.
select * from day21;

select record_date , humidity from day21
where humidity > 70;

----Count number of rainy days per city.
select * from day21;

select city , count(record_date) as count_weather from day21 where weather_condition = 'Rainy'
group by city;

----Find cities where no rainfall occurred (rainfall = 0).
select * from day21;

select city , sum(rainfall) from day21 
group by city
having sum(rainfall) = 0;

----Rank days by temperature within each city (RANK()).
select * from day21;

select city,record_date,temperature , rank() over
(partition by city order by temperature) as rnk from day21;

----Find days where temperature is higher than previous day (use LAG()).
select * from day21;

select * from(
select record_date , temperature ,lag(temperature)  over
(order by record_date) as prev_temp from day21 ) t 
where temperature > prev_temp;

----Find cities whose average rainfall is above overall average rainfall.
select * from day21;
 
select city , avg(rainfall) as avg_rainfall from day21 
group by city
having avg(rainfall) > (
select avg(rainfall) from day21);

