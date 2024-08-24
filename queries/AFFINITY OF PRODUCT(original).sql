# Affinity Of the Product - The Products which are frequenty purchased together

#created third column by joining tran_dtl and tran_hdr and perfromed the self join operation on the third column


create table affinity as (
with sub as (
	select td.tran_id, th.member_id, td.product_id  
    from tran_dtl td 
    join tran_hdr th on td.tran_id  = th.tran_id 
)
select  concat(s1.product_id,'-',s2.product_id) as purchase_pair, count(*) as purchase_frequency 
from sub s1
inner join sub s2
on s1.member_id = s2.member_id
and s1.tran_id = s2.tran_id
and s1.product_id < s2.product_id   
group by s1.product_id, s2.product_id
order by purchase_frequency desc)
;


#table structure
desc affinity;

#table 
select * from affinity;


############################################################################################
show tables
desc products 
desc tran_dtl 
desc tran_hdr 
desc member_data 
