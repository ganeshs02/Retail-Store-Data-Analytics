#SEASONALITY OF THE PRODUCT - MONTHS IN WHICH THE PRODUCT IS SOLD MAXIMUM IN THE WHOLE YEAR.


WITH sub AS (
    SELECT 
        td.product_id as pid,
        p.description,
        SUM(td.quantity) as total_quantity_sold,
        CASE
            WHEN MONTH(td.date) BETWEEN 1 AND 3 THEN 'first quarter'
            WHEN MONTH(td.date) BETWEEN 4 AND 6 THEN 'second quarter'
            WHEN MONTH(td.date) BETWEEN 7 AND 9 THEN 'third quarter'
            ELSE 'fourth quarter'
        END as quarters
    FROM tran_dtl td
    JOIN products p ON p.product_id = td.product_id
    GROUP BY td.product_id, p.description, quarters
)
SELECT 
    sub.pid,
    sub.description,
    sum(CASE WHEN sub.quarters ='first quarter' THEN sub.total_quantity_sold ELSE 0 END) AS `1st_quarter_sales`,
    sum(CASE WHEN sub.quarters ='second quarter' THEN sub.total_quantity_sold ELSE 0 END) AS `2nd_quarter_sales`,
    sum(CASE WHEN sub.quarters ='third quarter' THEN sub.total_quantity_sold ELSE 0 END) AS `3rd_quarter_sales`,
    sum(CASE WHEN sub.quarters ='fourth quarter' THEN sub.total_quantity_sold ELSE 0 END) AS `4th_quarter_sales`
FROM sub
GROUP BY sub.pid, sub.description
ORDER BY sub.pid


#table structure
desc seasonality

#table 
select * from seasonality

############################################################################
desc tran_dtl 
desc tran_hdr 
desc products 
desc member_data 
show tables