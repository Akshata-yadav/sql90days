CREATE TABLE day16 (
    property_id INT,
    city VARCHAR(50),
    property_type VARCHAR(50),
    agent_name VARCHAR(50),
    sale_price INT,
    sale_date DATE
);

INSERT INTO day16 VALUES
(1, 'Mumbai', 'Apartment', 'Rahul', 12000000, '2024-01-10'),
(2, 'Mumbai', 'Villa', 'Sneha', 25000000, '2024-01-15'),
(3, 'Delhi', 'Apartment', 'Amit', 9000000, '2024-01-12'),
(4, 'Delhi', 'Villa', 'Neha', 20000000, '2024-01-18'),
(5, 'Bangalore', 'Apartment', 'Ravi', 8000000, '2024-01-20'),
(6, 'Bangalore', 'Villa', 'Priya', 22000000, '2024-01-25'),
(7, 'Mumbai', 'Apartment', 'Rahul', 15000000, '2024-02-05'),
(8, 'Mumbai', 'Villa', 'Sneha', 27000000, '2024-02-10'),
(9, 'Delhi', 'Apartment', 'Amit', 9500000, '2024-02-08'),
(10, 'Delhi', 'Villa', 'Neha', 21000000, '2024-02-12'),
(11, 'Bangalore', 'Apartment', 'Ravi', 8500000, '2024-02-15'),
(12, 'Bangalore', 'Villa', 'Priya', 23000000, '2024-02-20'),
(13, 'Mumbai', 'Apartment', 'Rahul', 13000000, '2024-03-01'),
(14, 'Delhi', 'Apartment', 'Amit', 10000000, '2024-03-03'),
(15, 'Bangalore', 'Villa', 'Priya', 24000000, '2024-03-05');

select * from day16;

---Assign a row number to each sale ordered by sale_price (highest first).
select sale_price , row_number() over (order by sale_price desc) as rn from day16;

---Rank properties based on sale_price (use RANK()).
select * from day16;

select property_id,sale_price ,rank() over
(order by sale_price desc) as ranked_properties from day16;

---find dense rank of properties by sale_price.
select property_id, sale_price , dense_rank() over 
(order by sale_price desc) as ranked_properties from day16;

---Show the highest sale in each city using ROW_NUMBER().
select * from day16;

select city,sale_price, row_number() over 
(partition by city order by sale_price desc) as highest_sale from day16;

---Calculate running total of sales ordered by sale_date.
select * from day16;

select property_id , sale_date ,sum(sale_price) over
(order by sale_date rows between unbounded preceding and current row) 
as rnk from day16;

---Find total sales per city using window function.
select * from day16;

select property_id , city , sale_price ,
sum(sale_price) over(partition by city) as rnk 
from day16;

---Calculate average sale price per property type.
select property_id, property_type , sale_price , 
avg(sale_price) over (partition by property_type) as rnk 
from day16;

select property_type, avg(sale_price) as avgsales 
from day16
group by property_type;

---Show each property with difference from previous sale price
select * from day16;

select property_id,city,sale_date,sale_price,
sale_price - lag(sale_price) over(order by sale_date) as price_diff 
from day16;

---Show each property with next sale price (LEAD).
select * from day16;

select property_id ,city, sale_date,sale_price , 
lead(sale_price) over(order by sale_date) as rnk 
from day16;

---Percentage contribution of each sale to total sales
select property_id , sale_price,
round(sale_price * 100.0 /sum(sale_price)over(), 2) as percentage_contro 
from day16;

---Top 2 highest sales in each city
select * from day16;

select * from (
select * ,row_number() over 
(partition by city order by sale_price) as highest
from day16 ) t
where highest <= 2;

---Properties where price is higher than previous sale in same city
select * from day16;

select * from (
select * , lag(sale_price) over(
partition by city order by sale_date) as prev_sales 
from day16 ) t
where sale_price > prev_sales;

----Moving average of last 2 sales by date
select property_id , sale_date, sale_price , 
avg(sale_price) over(order by sale_date rows between 1 preceding and current row ) as ma
from day16;

----Highest sale per month per city
select * from (
select *, row_number() over(partition by city , month(sale_date) , year(sale_date) 
order by sale_price desc) as rn 
from day16) t 
where rn = 1;

----Divide properties into 4 price buckets
select * from day16;

select property_id , sale_price , ntile(4) over (order by sale_price desc) as quartile 
from day16;