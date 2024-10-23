#data clening
 select * from retailsales
 where
      ï»¿transactions_id is null
      or
      sale_date is null
      or
      sale_time is null
      or
      gender is null
      or 
      quantiy is null
      or 
      cogs is null
      or 
      total_sale is null
      or
      cogs is null
      or age is null;
# data exploration
# how namy sales we have 
select count(*) as total_sale from retailsales;
#how many unique customer wehave
select count( distinct customer_id) as total_sale from retailsales;
#how many categories
select  distinct category  from retailsales;
#data analysis
select*from retailsales
where sale_date = '2022-11-05';
select *from retailsales
where category ='Clothing' and YEAR(sale_date)=2022 AND MONTH(sale_date)=11;
select
category,
sum(total_sale) as net_sale
from retailsales
group by  1;
select round(avg(age),2) as avg_age
 from retailsales 
where category='beauty';
select *from retailsales
where  total_sale>1000;
select
category,
gender,
count(*) as total_trans from retailsales
group by category,gender;
select  year, month, avg_sale
from
(
 SELECT
	EXTRACT(year from sale_date) as year,
    EXTRACT(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over(partition by EXTRACT(year from sale_date) order by avg(total_sale) desc) as rank_order 
from retailsales
group by 1, 2) AS T1
WHERE RANK_order =1;
SELECT 
    customer_id, 
     sum(total_sale) as total_sales 
from retailsales
group by 1
order by 2 desc
limit 5;


SELECT 
    category,
   count(distinct customer_id) as countofunique
from retailsales
group by category
order by 2 desc
limit 5;
WITH hourly_sale
AS
(
select*,
    CASE
        WHEN extract( HOUR FROM SALE_TIME)<12 THEN 'MORNING'
		WHEN extract( HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'NOON'
        ELSE 'EVENING' 
	END AS SHIFT
FROM retailsales
)
select shift, 
  count(*) as total_orders
FROM hourly_sale
    GROUP BY SHIFT