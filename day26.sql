CREATE TABLE day26 (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    shipment_mode VARCHAR(30),
    shipping_cost DECIMAL(10,2),
    delivery_days INT,
    order_date DATE,
    region VARCHAR(50),
    order_status VARCHAR(20)
);

INSERT INTO day26 VALUES
(1, 'Amit', 'Laptop', 'Air', 1200, 2, '2026-05-01', 'West', 'Delivered'),
(2, 'Neha', 'Mobile', 'Road', 300, 5, '2026-05-02', 'North', 'Shipped'),
(3, 'Rahul', 'Tablet', 'Rail', 450, 4, '2026-05-03', 'South', 'Delivered'),
(4, 'Priya', 'Monitor', 'Air', 1500, 1, '2026-05-03', 'East', 'Delivered'),
(5, 'Karan', 'Keyboard', 'Road', 200, 6, '2026-05-04', 'West', 'Pending'),
(6, 'Sneha', 'Mouse', 'Rail', 180, 5, '2026-05-04', 'North', 'Delivered'),
(7, 'Vikas', 'Printer', 'Air', 2200, 2, '2026-05-05', 'South', 'Shipped'),
(8, 'Anjali', 'Speaker', 'Road', 350, 4, '2026-05-05', 'East', 'Delivered'),
(9, 'Rohit', 'Camera', 'Rail', 800, 3, '2026-05-06', 'West', 'Pending'),
(10, 'Meera', 'Smartwatch', 'Air', 1000, 1, '2026-05-06', 'North', 'Delivered');

select * from day26;

---Assign row numbers to orders based on highest shipping cost.
select order_id , shipping_cost , row_number() over
(order by shipping_cost desc) as rn_higgest_shipping from day26;

---Rank orders region-wise based on delivery days
select * from day26;

select order_id, region,delivery_days ,rank() over(partition by region order by delivery_days) as rn 
from day26;

---Show dense rank of shipping costs within each shipment mode.
select * from day26;

select shipping_cost, shipment_mode , dense_rank() over
(partition by shipment_mode order by shipping_cost) as denserank from day26;

select shipping_cost, shipment_mode , rank() over
(partition by shipment_mode order by shipping_cost) as denserank from day26;

---Display each order along with average shipping cost of its region.
select order_id , region ,shipping_cost ,avg(shipping_cost) over(partition by region) as rnk 
from day26;

---Show highest shipping cost in each shipment mode beside every row.
select * from day26;

select shipping_cost, shipment_mode, max(shipping_cost) over
(partition by shipment_mode) as highest_shipment from day26;

---Find previous shipping cost for each shipment mode.
select * from day26;

select order_date, shipping_cost,shipment_mode , lag(shipping_cost) over
(partition by shipment_mode order by order_date) as rnk from day26;

---Find next delivery days value within same region.
select order_id , delivery_days, region, lead(delivery_days) over
(partition by region order by order_date) as rnk from day26;

---Calculate running total of shipping cost ordered by order date.
select * from day26;

select shipping_cost ,order_date ,sum(shipping_cost) over(order by order_date) as rnk 
from day26;

---Difference between current shipping cost and region average
select order_id , region , shipping_cost, 
avg(shipping_cost) over(partition by region) as region_avg , 
shipping_cost - avg(shipping_cost) over(partition by region) as diff_from_avg 
from day26;

----Second highest shipping cost in each region
with ranked as (
select * , dense_rank() over(partition by region order by shipping_cost desc) as rnk 
from day26 )

select * from ranked 
where rnk = 2;