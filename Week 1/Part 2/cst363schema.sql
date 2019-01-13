create schema cst363;
use  cst363;
create table name(
  first varchar(50) not null, 
  last varchar(50) not null, 
  visits int not null, 
  primary key(first, last));
  
  
