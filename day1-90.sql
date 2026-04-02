create database sql90days;

use sql90days;

CREATE TABLE App_Usage (
    user_id INT,
    session_date DATE,
    app_version VARCHAR(10),
    device VARCHAR(20),
    minutes_spent INT,
    actions_taken INT,
    purchase_amount DECIMAL(10,2)
);

INSERT INTO App_Usage VALUES
(1, '2024-01-01', '1.0', 'Mobile', 30, 10, 200),
(2, '2024-01-01', '1.0', 'Desktop', 20, 5, 0),
(3, '2024-01-01', '1.1', 'Tablet', 15, 4, 0),
(1, '2024-01-02', '1.1', 'Mobile', 40, 15, 500),
(2, '2024-01-02', '1.1', 'Desktop', 25, 8, 300),
(4, '2024-01-02', '1.0', 'Mobile', 10, 3, 0),
(5, '2024-01-03', '1.1', 'Mobile', 50, 20, 700),
(3, '2024-01-03', '1.0', 'Tablet', 20, 6, 0),
(1, '2024-01-03', '1.1', 'Mobile', 60, 25, 1000),
(6, '2024-01-03', '1.0', 'Desktop', 15, 5, 0);

select * from App_Usage;

---Total number of rows in the table
select count(*) as total_row_number from App_Usage;

---Find unique users count
select count(distinct user_id) as unique_users from App_Usage;

---Get total minutes spent by all users
select * from App_Usage;

select sum(minutes_spent) as total_mnutes from App_Usage;

---Find average minutes spent per session
select session_date ,avg(minutes_spent) as avg_minutes from App_Usage 
group by session_date;

---List all sessions where purchase_amount > 0
select * from App_Usage;

select * from App_Usage where purchase_amount > 0;

---Total revenue generated
select * from App_Usage;

select sum(purchase_amount) as total_revenue from App_Usage;

---Revenue per day
select * from App_Usage;

select day(session_date) as revenue_per_day , sum(purchase_amount) as revenue_per_day from App_Usage
group by day(session_date);

---Average actions taken per device
select * from App_Usage;

select device, avg(actions_taken) as avg_action_per_device from App_Usage
group by device;

---Total sessions per app_version
select * from App_Usage;

select app_version ,count(session_date) as total_session from App_Usage
group by app_version;

---Find max minutes spent in a single session
select * from App_Usage;

select max(minutes_spent) as max_minute from App_Usage;

---Total minutes spent per user
select * from App_Usage;

select user_id, sum(minutes_spent) as total_minutes from App_Usage
group by user_id;

---Find top 3 users by total minutes spent
select * from App_Usage;

select top 3 user_id, sum(minutes_spent) as total_minutes from App_Usage
group by user_id
order by sum(minutes_spent) desc;

---Conversion rate = users who purchased / total users
select * from App_Usage;

SELECT 
    COUNT(DISTINCT CASE WHEN purchase_amount > 0 THEN user_id END) * 1.0
    / COUNT(DISTINCT user_id) AS conversion_rate
FROM App_Usage;

select 
count(distinct case when purchase_amount > 0 then user_id end) * 1.0 
/count(distinct user_id) as conversion_rate from App_Usage;

---Find users who never made any purchase
select * from App_Usage;

SELECT user_id
FROM App_Usage
GROUP BY user_id
HAVING SUM(purchase_amount) = 0;

---Day-wise cumulative revenue
SELECT 
    session_date,
    SUM(daily_revenue) OVER (ORDER BY session_date) AS cumulative_revenue
FROM (
    SELECT 
        session_date,
        SUM(purchase_amount) AS daily_revenue
    FROM App_Usage
    GROUP BY session_date
) t;

select * from App_Usage;

select session_date,sum(daily_revenue) over(order by session_date) as cumulative_revenue from(
select session_date,sum(purchase_amount) as daily_revenue from App_Usage group by session_date)t;

