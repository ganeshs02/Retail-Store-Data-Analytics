# PARETO CHART = THE 80% OF THE RESULTS ARE FROM 20% OF THE EFFORTS AND THE 20% OF THE REMAINING 
# RESULTS ARE FORM 80% OF REMAINING EFFORTS

create table pareto as (                                    
with abc as(SELECT SUM(sub2.total_sale) as ts FROM (SELECT p.description, round(sum(amount), 2) AS total_sale
                                       FROM products p
                                       JOIN tran_dtl td ON p.product_id = td.product_id
                                       GROUP BY p.description
                                       ORDER BY total_sale DESC
                                       ) AS sub2)                                                           
 select
	description,
	total_sale,
	cumulative_total,
	round((cumulative_total /(select ts from abc) *100) ,2) as cumulative_percentage
from
	(select 
	      sub.description,
       	  sub.total_sale, 
       	  sum(total_sale) over(order by total_sale desc) as cumulative_total
     from 
		(select 
		      p.description, 
		      round(sum(amount)) as total_sale 
		from products p
		join tran_dtl td on p.product_id = td.product_id 
		group by p.description 
		order by total_sale desc
		
		) as sub
	)as sub2);

#table structure
desc pareto;

#table
select * from pareto;
	

############################################################
show tables
desc member_data 
desc products 
desc tran_dtl 
desc tran_hdr 