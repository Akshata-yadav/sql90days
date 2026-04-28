CREATE TABLE day11 (
    claim_id INT PRIMARY KEY,
    customer_id INT,
    policy_type VARCHAR(20),
    claim_amount INT,
    claim_status VARCHAR(20),
    claim_date DATE,
    city VARCHAR(20),
    agent_id VARCHAR(10)
);

INSERT INTO day11 VALUES
(1, 101, 'Health', 15000, 'Approved', '2024-01-10', 'Mumbai', 'A1'),
(2, 102, 'Auto', 8000, 'Rejected', '2024-01-12', 'Pune', 'A2'),
(3, 103, 'Life', 50000, 'Approved', '2024-01-15', 'Mumbai', 'A1'),
(4, 101, 'Health', 12000, 'Pending', '2024-02-01', 'Mumbai', 'A3'),
(5, 104, 'Auto', 7000, 'Approved', '2024-02-05', 'Delhi', 'A2'),
(6, 105, 'Health', 20000, 'Rejected', '2024-02-10', 'Pune', 'A3'),
(7, 106, 'Life', 45000, 'Approved', '2024-02-12', 'Delhi', 'A1'),
(8, 102, 'Auto', 9000, 'Approved', '2024-02-18', 'Pune', 'A2'),
(9, 107, 'Health', 11000, 'Pending', '2024-03-01', 'Mumbai', 'A3'),
(10, 108, 'Life', 60000, 'Approved', '2024-03-03', 'Delhi', 'A1'),
(11, 109, 'Auto', 10000, 'Approved', '2024-03-05', 'Mumbai', 'A2'),
(12, 110, 'Health', 17000, 'Rejected', '2024-03-08', 'Pune', 'A3'),
(13, 111, 'Life', 55000, 'Approved', '2024-03-10', 'Delhi', 'A1'),
(14, 101, 'Health', 13000, 'Approved', '2024-03-12', 'Mumbai', 'A3'),
(15, 112, 'Auto', 6000, 'Pending', '2024-03-15', 'Pune', 'A2');

select * from day11;

---Find total claim amount for each policy type
select policy_type, sum(claim_amount) as total_claim_amount from day11
group by policy_type;

---Count number of claims per claim_status
select * from day11;

select claim_status , count(*) as total_count from day11
group by claim_status;

---Get total number of claims filed in each city
select * from day11;

select city,count(*) as total_number_of_claims from day11
group by city;

---Find average claim amount for approved claims only
select * from day11;

select avg(claim_amount) as avg_claim_amount , claim_status from day11
group by claim_status 
having claim_status = 'Approved';

---List all customers who have more than 1 claim
select * from day11;

select customer_id , count(*) as claim_count from day11
group by customer_id 
having count(*) > 1;

---Get highest claim amount per policy type
select * from day11;

select top 1 sum(claim_amount) as highest_claim , policy_type from day11
group by policy_type 
order by sum(claim_amount)  desc;

---Find total approved claim amount per agent
select * from day11;

select agent_id ,sum(claim_amount) as total_approved from day11
where claim_status = 'Approved'
group by agent_id ;

---Get city with highest total claim amount
select * from day11;

select top 1 sum(claim_amount) as total_claim_amount , city from day11
group by city 
order by sum(claim_amount) desc;

---Find percentage of approved vs rejected claims
select claim_status,
count(*) * 100.0 /(select count(*) from day11) as percentage 
from day11
where claim_status in('Approved','Rejected') 
group by claim_status;

---Get monthly total claim amount
select * from day11;

select month(claim_date) as monthly_claim , sum(claim_amount) as total_claim from day11
group by month(claim_date);

---Find customers whose total claim amount is greater than 30,000
select * from day11;

select customer_id , sum(claim_amount) as total_claim_amount from day11
group by customer_id 
having sum(claim_amount) > 30000;

---Find second highest claim amount
select * from day11;

select max(claim_amount) as second_higest from day11 where claim_amount < (select max(claim_amount) from day11);

---Find running total of claim amount per customer (ordered by claim_date)
select * from day11;

select customer_id , claim_date, sum(claim_amount) over
(partition by customer_id order by claim_date rows between unbounded preceding and current row) as rt from day11;

---Find last claim status for each customer
select * from day11;

select customer_id , claim_status from 
(
select customer_id , claim_status , row_number() over (
partition by customer_id 
order by claim_date desc) as rn 
from day11)t 
where rn = 1;

---Find agents who handled more than 2 approved claims
select * from day11;

select agent_id , count(*) as approval_count from day11
where claim_status = 'Approved'
group by agent_id 
having count(*) > 2;

