CREATE TABLE april17 (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_type VARCHAR(20),   -- 'credit' or 'debit'
    amount INT,
    txn_date DATE,
    city VARCHAR(50)
);

INSERT INTO april17 VALUES
(1, 201, 'credit', 10000, '2024-04-01', 'Mumbai'),
(2, 201, 'debit', 2000, '2024-04-02', 'Mumbai'),
(3, 202, 'credit', 15000, '2024-04-01', 'Delhi'),
(4, 202, 'debit', 5000, '2024-04-03', 'Delhi'),
(5, 203, 'credit', 20000, '2024-04-02', 'Bangalore'),
(6, 203, 'debit', 7000, '2024-04-04', 'Bangalore'),
(7, 201, 'debit', 1000, '2024-04-05', 'Mumbai'),
(8, 202, 'credit', 8000, '2024-04-06', 'Delhi'),
(9, 203, 'debit', 3000, '2024-04-06', 'Bangalore'),
(10, 204, 'credit', 12000, '2024-04-03', 'Mumbai'),
(11, 204, 'debit', 4000, '2024-04-05', 'Mumbai'),
(12, 205, 'credit', 5000, '2024-04-04', 'Pune');

select * from april17;

---Find total credit amount
select txn_type, sum(amount) as total_credit_amount from april17
group by txn_type
having txn_type = 'credit';

---Find total debit amount
select txn_type, sum(amount) as total_credit_amount from april17
group by txn_type
having txn_type = 'debit';

---Count number of transactions per city
select * from april17;

select city,count(*) as transaction_count from april17
group by city;

---Find maximum transaction amount
select * from april17;

select top 1 sum(amount)as max_amount from april17
order by sum(amount) desc;

---Find net balance per account
select account_id,
sum(case when txn_type = 'credit' then amount
     when txn_type = 'debit' then -amount 
     end) as net_balance 
     from april17
     group by account_id;

---Find accounts with total debit > 5000
select * from april17;

select account_id,sum(amount) as total_debit from april17 where
txn_type = 'debit'
group by account_id
having sum(amount) >5000;

---Find average transaction amount per account
select * from april17;

select account_id , avg(amount) as avg_transaction from april17
group by account_id;

---Find running balance per account (ordered by date)
select * from april17;

SELECT 
    account_id,
    txn_date,
    txn_type,
    amount,
    SUM(
        CASE 
            WHEN txn_type = 'credit' THEN amount
            WHEN txn_type = 'debit' THEN -amount
        END
    ) OVER (
        PARTITION BY account_id
        ORDER BY txn_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_balance
FROM april17
ORDER BY account_id, txn_date;

---Find accounts where last transaction is debit
select * from april17;

select account_id from 
(select account_id , amount, txn_type , 
row_number() over(partition by account_id order by txn_type desc) rn
from april17
)t
where rn = 1
and txn_type = 'debit';

---Find city with highest total transaction amount
select * from april17;

select top 1 city , sum(amount) as highesh_amount from april17
group by city 
order by sum(amount) desc;