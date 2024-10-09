-- Active: 1725020427389@@127.0.0.1@1433@ecommerce_db@dbo

begin;

update salaries set salary = 1000000 where id = 199;

do sleep (20);

rollback;