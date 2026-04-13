CREATE TABLE april13 (
    order_id INT PRIMARY KEY,
    user_id INT,
    city VARCHAR(50),
    restaurant_name VARCHAR(50),
    cuisine VARCHAR(50),
    order_date DATE,
    order_value INT,
    delivery_time INT,
    rating INT
);

INSERT INTO april13 VALUES
(1, 101, 'Mumbai', 'Spice Hub', 'Indian', '2023-05-01', 500, 30, 5),
(2, 102, 'Delhi', 'Pizza Point', 'Italian', '2023-05-01', 300, 25, 4),
(3, 101, 'Mumbai', 'Burger Town', 'Fast Food', '2023-05-02', 200, 20, 3),
(4, 103, 'Mumbai', 'Spice Hub', 'Indian', '2023-05-02', 700, 40, 5),
(5, 104, 'Bangalore', 'Sushi World', 'Japanese', '2023-05-03', 800, 50, 4),
(6, 105, 'Delhi', 'Biryani House', 'Indian', '2023-05-03', 600, 35, 5),
(7, 102, 'Delhi', 'Biryani House', 'Indian', '2023-05-04', 450, 30, 2),
(8, 103, 'Mumbai', 'Burger Town', 'Fast Food', '2023-05-05', 250, 22, 4),
(9, 101, 'Mumbai', 'Spice Hub', 'Indian', '2023-05-06', 550, 28, 5),
(10, 104, 'Bangalore', 'Sushi World', 'Japanese', '2023-05-07', 900, 55, 3),
(11, 101, 'Mumbai', 'Spice Hub', 'Indian', '2023-05-07', 400, 32, 4),
(12, 102, 'Delhi', 'Pizza Point', 'Italian', '2023-05-08', 350, 27, 5);

select * from april13;

---Find total revenue per restaurant
select restaurant_name , sum(order_value) as total_revenue from april13
group by restaurant_name;

---Find top 3 users by total spending
select * from april13;

select top 3 user_id , sum(order_value) as total_spending from april13
group by user_id 
order by sum(order_value) desc;

---Find average order value per city and filter cities where avg > overall avg
select * from april13;

with cte as(
select city , avg(order_value) as average_order_value from april13
group by city )

select city , average_order_value from cte 
where average_order_value > (select avg(order_value) as aov from april13); 

---Find restaurants with average rating ≥ 4.5
select * from april13;

select restaurant_name , avg(rating) as avg_rating from april13
group by restaurant_name 
having avg(rating) >= 4.5;

---Find second highest order value
select * from april13;

select max(order_value) as second_highest from april13 where order_value <
(select max(order_value) from april13);

---Find users who placed orders on consecutive days
select * from april13;

select distinct user_id from (
select user_id ,order_date ,lag(order_date) over(partition by user_id order by order_date) as prev_date 
from april13)t
where datediff(day,prev_date,order_date) = 1;

---Find running total spend per user (ordered by date)
select * from april13;

select user_id , order_date, order_value, sum(order_value) over 
(partition by user_id order by order_date rows between unbounded preceding and current row) as running_total
from april13;

---Highest revenue restaurant per city
select * from april13;

select restaurant_name , city , total_revenue from(
select city,restaurant_name , sum(order_value) as total_revenue ,rank() 
over(partition by city order by sum(order_value) desc) as rnk from april13
group by city , restaurant_name )t
where rnk = 1;

---% contribution of each cuisine
select cuisine , sum(order_value) as revenue , 
100.0 * sum(order_value)/sum(sum(order_value)) over() as percentage 
from april13
group by cuisine;

----Latest rating < previous rating
SELECT user_id
FROM (
    SELECT 
        user_id,
        rating,
        LAG(rating) OVER (PARTITION BY user_id ORDER BY order_date) AS prev_rating,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY order_date DESC) AS rn
    FROM april13
) t
WHERE rn = 1
AND rating < prev_rating;