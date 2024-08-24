#1 NO OF THE PRODUCT
 
select count(product_id) as no_of_the_Products
from products p;


#2 NO OF THE MEMBERS

select count(member_id) as no_of_members
from member_data md ;



#3 NO OF THE TRANSACTONS

select count(tran_id) as no_of_transactions
from tran_hdr th ;


#4 no of transactions per year
select year(date) , count(tran_id) as no_of_tran_a_year 
from tran_hdr th 
group by year(date);


#5 no of transactions per quarter
select
case
	when month(date) between 1 and 3 then 'q1'
	when month(date) between 4 and 6 then 'q2'
	when month(date) between 7 and 9 then 'q3'
	when month(date) between 10 and 12 then 'q4'
end as qtr,
count(tran_id) as no_of_tran
from tran_hdr th 
group by qtr

#6 product most bought by users.

select sub.*,
rank() over(order by sub.no_trans desc)
from
(select p.description , count(td.tran_id) as no_trans 
from tran_dtl td 
join products p on td.product_id = p.product_id 
group by p.description
order by no_trans ) as sub


#7 product with most amount earned.


select p.description ,sum(cast(amount as signed)) as amount_earned
from tran_dtl td 
join products p on td.product_id = p.product_id
group by p.description
order by amount_earned desc;



#8 yearly total sale of the product.

select year(date) as per_year,product_id,ROUND(sum(amount),2)as total_sale
from tran_dtl
group by per_year,product_id 
order by product_id , per_year;

desc tran_dtl 

#9 yearly avg sale of the product.

select year(date) as per_year,product_id,avg(amount)as avg_sale
from tran_dtl
group by per_year,product_id 
order by product_id , per_year



###################################
show tables
desc tran_dtl 
desc products
desc tran_hdr 
desc member_data 





