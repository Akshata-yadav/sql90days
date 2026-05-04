CREATE TABLE day20 (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20), -- 'Credit' or 'Debit'
    category VARCHAR(50), -- e.g., Salary, Food, Rent, Shopping
    city VARCHAR(50)
);

INSERT INTO day20 VALUES
(1, 101, '2024-01-01', 50000, 'Credit', 'Salary', 'Mumbai'),
(2, 101, '2024-01-03', 2000, 'Debit', 'Food', 'Mumbai'),
(3, 102, '2024-01-05', 30000, 'Credit', 'Salary', 'Delhi'),
(4, 102, '2024-01-06', 5000, 'Debit', 'Rent', 'Delhi'),
(5, 103, '2024-01-07', 40000, 'Credit', 'Salary', 'Bangalore'),
(6, 103, '2024-01-08', 3000, 'Debit', 'Shopping', 'Bangalore'),
(7, 101, '2024-01-10', 1500, 'Debit', 'Food', 'Mumbai'),
(8, 102, '2024-01-12', 2000, 'Debit', 'Food', 'Delhi'),
(9, 103, '2024-01-15', 10000, 'Debit', 'Rent', 'Bangalore'),
(10, 101, '2024-01-20', 7000, 'Debit', 'Shopping', 'Mumbai');

select * from day20;

---Show all credit transactions.
select * from day20 where transaction_type = 'Credit';

---Find total amount spent (debit) by each customer.

select customer_id ,sum(amount) as total_amount_spent from day20 where transaction_type = 'Debit'
group by customer_id ;

---Get all transactions where amount > 5000.
select * from day20 where amount > 5000;

---Count total transactions per city.
select * from day20;

select city , count(*) as total_transaction from day20 
group by city;

---Find total salary (credit) received by each customer.
select customer_id , sum(amount) as total_salary from day20 
where transaction_type = 'Credit'
group by customer_id;

----Get average transaction amount per category.
select * from day20;

select category, avg(amount) as avg_transaction from day20 
group by category;

----Find the highest transaction amount in each city.
select city , max(amount) as highest from day20
group by city;

---Total debit and credit separately per customer
select customer_id , 
sum(case when transaction_type = 'Debit' then amount else 0 end) as total_debit,
sum(case when transaction_type = 'Credit' then amount else 0 end) as total_credit 
from day20 
group by customer_id;

---Customers whose total spending (debit) is above average spending
SELECT customer_id, SUM(amount) AS total_spending
FROM day20
WHERE transaction_type = 'Debit'
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT customer_id, SUM(amount) AS total_spent
        FROM day20
        WHERE transaction_type = 'Debit'
        GROUP BY customer_id
    ) t
);

----Rank transactions by amount within each customer
select * from day20;

select transaction_id , amount, customer_id , rank() over
(partition by customer_id order by amount) as rnk from day20;

