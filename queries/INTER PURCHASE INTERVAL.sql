# INTERPURCHASE INTERVALS = intervals (how many times memeber has come to the store with how much interval of the time)


with sub as (select 
th.tran_id,
th.member_id,
th.date
from tran_hdr th
order by th.member_id ,th.date
)
,sub2 as (select 
s1.member_id,
s1.date as transaction_date,
lag(s1.date) over(partition by member_id order by s1.date) as previous_transaction
from sub s1
group by s1.member_id, s1.date
order by member_id
)
,sub3 as(select 
s2.member_id,
s2.transaction_date,
s2.previous_transaction,
datediff(transaction_date , previous_transaction) as intrpurchase_interval
from sub2 s2
)
select
s3.member_id,
(avg(s3.intrpurchase_interval)) as average_interpurchase_interval
from sub3 s3
where s3.previous_transaction is not null 
group by 
	s3.member_id;

# table structure
desc interpurchase;

#table 
select * from interpurchase;


####################################
desc tran_hdr
desc tran_dtl 
desc member_data