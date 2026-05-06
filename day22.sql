CREATE TABLE day22 (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    account_type VARCHAR(20), -- Savings / Current
    balance DECIMAL(12,2),
    opening_date DATE
);

select * from day22;

INSERT INTO day22 VALUES
(1, 'Amit', 'Mumbai', 'Savings', 50000, 'Active', '2022-01-10'),
(2, 'Neha', 'Delhi', 'Current', 120000, 'Active', '2021-05-15'),
(3, 'Rahul', 'Mumbai', 'Savings', 30000, 'Inactive', '2023-02-20'),
(4, 'Sneha', 'Bangalore', 'Savings', 80000, 'Active', '2020-08-25'),
(5, 'Karan', 'Pune', 'Current', 150000, 'Active', '2019-11-30'),
(6, 'Pooja', 'Delhi', 'Savings', 45000, 'Inactive', '2022-07-18'),
(7, 'Rohit', 'Mumbai', 'Current', 200000, 'Active', '2021-12-05'),
(8, 'Anjali', 'Bangalore', 'Savings', 60000, 'Active', '2023-03-12'),
(9, 'Vikas', 'Pune', 'Savings', 25000, 'Inactive', '2022-09-09'),
(10, 'Meena', 'Delhi', 'Current', 90000, 'Active', '2020-03-14');

drop table day22;

CREATE TABLE day22 (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    account_type VARCHAR(20),   -- Savings / Current
    balance DECIMAL(12,2),
    status VARCHAR(20),         -- Active / Inactive
    opening_date DATE
);

INSERT INTO day22 VALUES
(1, 'Amit', 'Mumbai', 'Savings', 50000, 'Active', '2022-01-10'),
(2, 'Neha', 'Delhi', 'Current', 120000, 'Active', '2021-05-15'),
(3, 'Rahul', 'Mumbai', 'Savings', 30000, 'Inactive', '2023-02-20'),
(4, 'Sneha', 'Bangalore', 'Savings', 80000, 'Active', '2020-08-25'),
(5, 'Karan', 'Pune', 'Current', 150000, 'Active', '2019-11-30'),
(6, 'Pooja', 'Delhi', 'Savings', 45000, 'Inactive', '2022-07-18'),
(7, 'Rohit', 'Mumbai', 'Current', 200000, 'Active', '2021-12-05'),
(8, 'Anjali', 'Bangalore', 'Savings', 60000, 'Active', '2023-03-12'),
(9, 'Vikas', 'Pune', 'Savings', 25000, 'Inactive', '2022-09-09'),
(10, 'Meena', 'Delhi', 'Current', 90000, 'Active', '2020-03-14');

select * from day22;

---Show all active accounts.
select * from day22 where status = 'Active';

---Find customers from Mumbai.
select * from day22 where city = 'Mumbai';

---Display accounts with balance > 50,000.
select * from day22 where balance > 50000;

---Find total balance per city.
select city , sum(balance) as total_balance from day22
group by city;

---Count number of accounts per account type.
select * from day22;

select account_type , count(*) as account_type from day22
group by account_type;

---Find average balance of active vs inactive accounts.
select * from day22;

select status , avg(balance) as average_balance from day22
group by status;

---Get highest balance in each city.
select * from day22;

select city , max(balance) as max_balance from day22
group by city;

---Rank customers by balance within each city
select * from day22;

select customer_name , city,balance , rank() over
(partition by city order by balance desc) as rnk 
from day22;

----Find customers whose balance is above overall average balance.
select * from day22;

select customer_name  , balance from day22 where balance > (select avg(balance) as avgb from day22);

---Find second highest balance in the table
select * from day22;

select max(balance) as max_balance from day22 where balance < (select max(balance) as maxb from day22);