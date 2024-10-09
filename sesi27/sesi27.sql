-- Active: 1725020427389@@127.0.0.1@1433@ecommerce_db

set transaction isolation level read uncommitted;

select * from salaries where id = 199;

COMMIT;