use customer_shopping_behaviour;
select * 
from customer limit 10;

--total revenue generated male vs female customers? 
select gender, SUM(purchase_amount) as revenue
from customer
group by gender;

select customer_id,
purchase_amount
from customer
where discount_applied = 'Yes' and purchase_amount >

SELECT
item_purchased, round(avg(review_rating),2) as "avg product rating"
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;


select shipping_type,
ROUND(avg(purchase_amount),2)
from customer
where shipping_type in ('Standard' , 'Express')
group by shipping_type;

 
select subscription_status,
COUNT(customer_id) as total_customers,
ROUND(AVG(purchase_amount),2) as avg_spend,
ROUND(SUM(purchase_amount),2) as total_revenue
from customer 
group by subscription_status
order  by total_revenue,avg_spend desc;


select item_purchased,
ROUND(100*SUM(CASE WHEN discount_applied = 'YES' THEN 1 ELSE 0 END)/COUNT(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5;


with customer_type as (
select customer_id, previous_purchases,
case
when previous_purchases = 1 then 'New'
when  previous_purchases between 2 and 10 then 'Returning'
else 'Loyal'
end as customer_segment  
from customer
)
select customer_segment, count(*) as "number of customers"
from customer_type
group by customer_segment;


with item_counts as (
select category,
item_purchased,
count(customer_id) as total_orders,
row_number() over(partition by category order by count(customer_id) desc) as item_rank
from customer
group by category, item_purchased
)
select item_rank,category,item_purchased,total_orders
from item_counts
where item_rank <= 3;


select 
subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchases > 5
group by subscription_status;


select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;
















