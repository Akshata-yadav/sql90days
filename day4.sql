CREATE TABLE april8 (
    delivery_id INT,
    rider_id INT,
    city VARCHAR(30),
    order_time DATETIME,
    delivery_time DATETIME,
    distance_km DECIMAL(5,2),
    order_value DECIMAL(8,2),
    payment_type VARCHAR(20)
);

INSERT INTO april8 VALUES
(1, 101, 'Mumbai', '2024-01-01 10:00:00', '2024-01-01 10:30:00', 5.2, 250, 'Online'),
(2, 102, 'Delhi', '2024-01-01 10:10:00', '2024-01-01 10:50:00', 7.5, 400, 'Cash'),
(3, 101, 'Mumbai', '2024-01-01 11:00:00', '2024-01-01 11:20:00', 3.0, 150, 'Online'),
(4, 103, 'Bangalore', '2024-01-01 11:15:00', '2024-01-01 12:00:00', 10.0, 600, 'Online'),
(5, 104, 'Mumbai', '2024-01-02 09:30:00', '2024-01-02 10:10:00', 6.0, 300, 'Cash'),
(6, 102, 'Delhi', '2024-01-02 10:00:00', '2024-01-02 10:40:00', 8.0, 500, 'Online'),
(7, 101, 'Mumbai', '2024-01-02 11:00:00', '2024-01-02 11:45:00', 9.0, 450, 'Online'),
(8, 103, 'Bangalore', '2024-01-02 12:00:00', '2024-01-02 12:30:00', 4.5, 200, 'Cash'),
(9, 104, 'Mumbai', '2024-01-03 09:00:00', '2024-01-03 09:25:00', 3.5, 180, 'Online'),
(10, 102, 'Delhi', '2024-01-03 10:30:00', '2024-01-03 11:10:00', 7.0, 350, 'Cash');

select * from april8;

---1. Total Orders per City
select city ,count(*) as total_orders from april8
group by city;

---Average Delivery Time
select * from april8;

SELECT 
    AVG(DATEDIFF(minute, order_time, delivery_time)) AS avg_delivery_time
FROM april8;

---Find the delivery with minimum delivery time.
select * from april8;

SELECT TOP 1 *
FROM april8
ORDER BY DATEDIFF(minute, order_time, delivery_time);

---Find total order value per city.
select * from april8;

select city,count(*) as city_count from april8
group by city;

---Find total deliveries and total earnings handled by each rider.
select * from april8;

select rider_id,count(*) as total_deliveries , sum(order_value) as total_earnings 
from april8
group by rider_id;

---Find which hour has highest number of orders.
select * from april8;

SELECT 
    DATEPART(HOUR, order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM april8
GROUP BY DATEPART(HOUR, order_time)
ORDER BY total_orders DESC;

---Payment Method Analysis
SELECT 
    payment_type,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM april8) AS percentage_orders
FROM april8
GROUP BY payment_type;

select payment_type,
count(*) * 100.0/(select count(*) from april8) as percentage_orders from april8
group by payment_type;

---Long Distance Deliveries
--distance > average distance

select * from april8;

select * from april8 where distance_km > (select avg(distance_km) as avg_del from april8) ;

---Rank Riders (Window Function) based on total order value
select rider_id,sum(order_value) as total_value , rank() 
over(order by sum(order_value) desc) as rider_rank from april8
group by rider_id;

---Efficiency Find average delivery speed (km per minute) for each rider.
select rider_id,avg(distance_km * 1.0 /datediff(minute,order_time,delivery_time)) as avg_speed_km 
from april8
group by rider_id;