use database RETAIL PROJECT;
show tablES

#TRAN DTL TABLE
create table TRAN_DTL (
TRAN_ID VARCHAR(255),
PRODUCT_ID INT,
QUANTITY INT,
AMOUNT FLOAT,
DATE DATE);


#TRAN HDR TABLE

create table TRAN_HDR (
TRAN_ID VARCHAR(255),
STORE_ID INT,
MEMBER_ID INT,
DATE DATE);


show TABLES


desc tran_dtl 
desc tran_hdr 
select * from tran_dtl td 
select * from tran_hdr th 
select * from member_data 
select * from  product
drop table product