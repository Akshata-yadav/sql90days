CREATE TABLE day14 (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT,
    stock INT,
    rating DECIMAL(2,1),
    discount_percent INT,
    launch_year INT
); 

INSERT INTO day14 VALUES
(1, 'iPhone 14', 'Electronics', 80000, 10, 4.8, 10, 2022),
(2, 'Samsung TV', 'Electronics', 50000, 5, 4.5, 15, 2021),
(3, 'Nike Shoes', 'Fashion', 7000, 50, 4.2, 20, 2023),
(4, 'Wooden Table', 'Furniture', 12000, 0, 3.8, 5, 2020),
(5, 'Laptop Dell', 'Electronics', 65000, 8, 4.6, 12, 2022),
(6, 'T-shirt', 'Fashion', 800, 100, 3.5, 25, 2024),
(7, 'Refrigerator', 'Appliances', 30000, 3, 4.1, 18, 2021),
(8, 'Microwave', 'Appliances', 15000, 7, 4.0, 10, 2020),
(9, 'Sofa Set', 'Furniture', 40000, 2, 4.3, 8, 2019),
(10, 'Headphones', 'Electronics', 3000, 25, 4.7, 30, 2023);

select * from day14;

---Show 'Expensive' if price > 50000 else 'Affordable'
select price,
case when price > 50000 then 'Expensive'
else 'Affordable'
end as product_category
from day14;

---Show 'In Stock' if stock > 0 else 'Out of Stock'
select * from day14;

select stock, 
case when stock > 0 then 'In Stock'
else 'Out of Stock'
end as stock_status
from day14;

---Convert rating into: ≥ 4.5 → 'Excellent' 4.0–4.4 → 'Good' < 4.0 → 'Average
select * from day14;

select rating, 
case when rating >= 4.5 then 'Excellent'
when rating between 4.0 and 4.4 then 'Good'
else 'Average'
end as product_ratings 
from day14;

---Show 'New Product' if launch_year ≥ 2023 else 'Old Product'
select * from day12;

SELECT 
    YEAR(CAST(order_date AS DATE)) AS ly,
    CASE 
        WHEN YEAR(CAST(order_date AS DATE)) >= 2023 THEN 'New Product'
        ELSE 'Old Product'
    END AS product_new_or_old
FROM day14;

---Categorize discount:
--≥ 20 → 'High Discount'
--10–19 → 'Medium Discount'
--< 10 → 'Low Discount'

select * from day14;

select discount_percent , 
case when discount_percent > = 20 then 'High discount'
when discount_percent between 10 and 19 then 'Medium discount'
else 'Low Discount'
end as dscount_range 
from day14;

---Show category-wise label:
--Electronics → 'Tech'
---Fashion → 'Clothing'
---Others → 'Other Category'

select * from day14;

select category , 
case when category = 'Electronics' then 'Tech'
when category = 'Fashion' then 'Clothing'
else 'Other Category'
end as category_wise 
from day14;

---Create price range:
---< 5000 → 'Low'
---5000–20000 → 'Medium'
---20000 → 'High'

select * from day14;

select price ,
case when price < 5000 then 'Low'
when price between 5000 and 20000 then 'Medium'
else 'High'
end as price_range 
from day14;

---Show:
--'Top Rated' if rating ≥ 4.5 AND price > 20000
----'Budget Pick' if price < 10000
---Else 'Regular'

select * from day14;

select rating , price, 
case when rating >= 4.5 and price > 20000 then 'Top Rated'
when price < 10000 then 'Budget Pick'
else 'Regular'
end as rating_price
from day14;

select * from day14;

---Show stock status:
---0 → 'Out of Stock'
---1–5 → 'Low Stock'
---5 → 'Available'

select stock ,
case when stock > 5 then 'Available'
when stock between 1 and 5 then 'Low Stock'
else 'out of stock'
end as stockstatus 
from day14;

---Show:
---'Premium Electronics' if category = Electronics AND price > 60000
---Else 'Normal Product'

select * from day14;

select category,
case when category = 'Electronics' and price > 60000 then 'Premium Electronics'
else 'Normal Product'
end as category_type 
from day14;

---Final price after discount
select * from day14;

select product_name , price , discount_percent,
case when discount_percent > 0 
then price - (price * discount_percent /100) 
else price 
end as final_price 
from day14;

---CASE inside ORDER BY
select * from day14 
order by 
case when category = 'Electronics' then 1 
when category = 'Fashion' then 2 
else 3
end;

---Count Expensive vs Affordable
select 
case when price > 50000 then 'Expensive'
else 'Affordable'
end as price_category,
count(*) as total_count 
from day14
group by case when price > 50000 then 'Expensive'
else 'Affordable'
end;

---UPDATE using CASE
update day14 
set price = 
case when category = 'Electronics' then price * 1.10 
when category = 'Furniture' then price * 1.05 
else price* 1.02
end;

select * from day14;

---Pivot-style (Category-wise total price)
select 
sum(case when category = 'Electronics' then price else 0 end) as electronics_total,
sum(case when category = 'Fashion' then price else 0 end ) as fashion_total,
sum(case when category = 'Furniture' then price else 0 end) as furnture_total,
sum(case when category = 'Appliances' then price else 0 end) as appliance_total
from day14;