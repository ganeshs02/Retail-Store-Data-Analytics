# Reward-Score : Ranking the customers like Gold, Silver, Silver . and giving the them 
#  discount based on it.

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
,sub4 as (select
s3.member_id,
avg(s3.intrpurchase_interval) as average_interpurchase_interval
from sub3 s3
where s3.previous_transaction is not null 
group by 
	s3.member_id
)
,sub5 as (select 
	s4.member_id,
	s4.average_interpurchase_interval,
	case 
		when s4.average_interpurchase_interval between 4 and 4.4 then 'Bronze'
		when s4.average_interpurchase_interval between 4.5 and 4.8 then 'silver'
		else 'Gold'
	end as Ranking	
from sub4 s4
group by 
	s4.member_id)
select 
	s5.member_id,
	s5.average_interpurchase_interval,
	s5.ranking,
	case 
		when s5.ranking = 'Gold' then '30%'
		when s5.ranking = 'Silver' then '20%'
		else '10%'
	end as Discount	
from sub5 s5;

#table structure
desc rewardscore1;

#table	
select * from rewardscore1 ;
