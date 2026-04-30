CREATE TABLE day15 (
    sub_id INT,
    user_id INT,
    platform VARCHAR(30),
    plan_type VARCHAR(20),
    start_date DATE,
    monthly_fee INT
);

INSERT INTO day15 VALUES
(1, 201, 'Netflix', 'Premium', '2024-01-01', 800),
(2, 202, 'Spotify', 'Basic', '2024-01-01', 200),
(3, 201, 'Netflix', 'Standard', '2024-02-01', 500),
(4, 203, 'Amazon Prime', 'Premium', '2024-01-02', 700),
(5, 202, 'Spotify', 'Premium', '2024-02-01', 400),
(6, 204, 'Netflix', 'Basic', '2024-01-03', 300),
(7, 203, 'Amazon Prime', 'Standard', '2024-02-02', 500),
(8, 205, 'Spotify', 'Basic', '2024-01-04', 200),
(9, 201, 'Netflix', 'Premium', '2024-03-01', 800),
(10, 204, 'Netflix', 'Standard', '2024-02-03', 500),
(11, 202, 'Spotify', 'Premium', '2024-03-01', 400),
(12, 205, 'Spotify', 'Premium', '2024-02-04', 400);

select * from day15;

---Assign row number based on monthly_fee (highest first)
select *, row_number() over
(order by monthly_fee desc) as mf from day15;

---Assign row number per platform
select platform,start_date ,row_number() over
(partition by platform order by start_date) as rn from day15;

----Rank subscriptions using RANK() by monthly_fee
select * from day15;

select monthly_fee , rank() over
(order by monthly_fee) as rnk from day15;

---Rank using DENSE_RANK()
select monthly_fee , dense_rank() over
(order by monthly_fee) as rnk from day15;

---Get top 3 highest paying subscriptions
select * from day15;

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY monthly_fee DESC) AS rn
    FROM day15
) t
WHERE rn <= 3;

