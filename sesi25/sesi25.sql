-- Active: 1725020427389@@127.0.0.1@1433@ecommerce_db

create table salaries (
    id int identity(1, 1) primary key,
    emp_no int,
    salary float,
    from_date date,
    to_date date,
);

-- 1000 seeding salaries data
INSERT INTO
    salaries (
        emp_no,
        salary,
        from_date,
        to_date
    )
SELECT TOP 1000 ABS(CHECKSUM(NEWID())) % 1000 + 1, -- Random employee number between 1 and 1000 
    ABS(CHECKSUM(NEWID())) % 100000 + 50000, -- Random salary between 50000 and 150000 
    DATEADD(
        DAY, ABS(CHECKSUM(NEWID())) % 365, '2000-01-01'
    ), -- Random from_date between '2000-01-01' and '2000-12-31' 
    DATEADD(
        DAY, ABS(CHECKSUM(NEWID())) % 365, '2001-01-01'
    ) -- Random to_date between '2001-01-01' and '2001-12-31' 
FROM sys.all_columns ac1
    CROSS JOIN sys.all_columns ac2;

select count(DISTINCT (emp_no)) from salaries;

select * from salaries where emp_no = 99;

-- aggregate query

-- count
select count(*) from salaries where emp_no = 198;
-- avg
select AVG(salary) as salary_avg, count(*) as salary_count
from salaries
where
    emp_no = 199;
-- sum
select sum(salary) as salary_sum
from salaries
where
    emp_no = 199;

-- max / min
select max(salary) as salary_max, min(salary) as salary_min
from salaries
where
    emp_no = 199;

-- group by
-- bagaimana kita menghitung dengan mengelompokkan data

-- mau menghitung rata-rata gaji per karyawan
select emp_no, avg(salary)
from salaries
group by
    emp_no
order by emp_no;
-- having
select emp_no, count(1), avg(salary)
from salaries
group by
    emp_no
having
    avg(salary) > 100000
order by count(1) desc;

-- hitung jumlah karywan yang memiliki gaji di atas 100k
select emp_no
from salaries
group by
    emp_no
having
    avg(salary) > 100000
order by emp_no;
-- TBD in sub query

-- pivot
select
    emp_no,
    [1],
    [2],
    [3],
    [4],
    [5],
    [6],
    [7],
    [8],
    [9],
    [10],
    [11],
    [12]
from (
        -- subquery
        select emp_no, salary, month(from_date) as month_2000
        from salaries
        where
            emp_no = 1
    ) as source pivot (
        avg(salary) for month_2000 in (
            [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12]
        )
    ) as pivot_table;

select emp_no, salary, month(from_date) as month_2000
from salaries
where
    emp_no = 1;

-- carilah maximum salary per month

-- conditional / flow control
-- sql juga ada flow control

-- case
-- kalau salary > 90k <= 100k middle
-- kalau salary > 100k high
-- kalau salary <= 90k low
select
    emp_no,
    avg(salary),
    CASE
        WHEN avg(salary) > 90000
        AND avg(salary) <= 100000 THEN 'middle'
        WHEN avg(salary) > 100000 THEN 'high'
        ELSE 'low'
    END as salary_category
from salaries
GROUP BY
    emp_no
having
    avg(salary) > 90000
    and AVG(salary) <= 100000;

-- if else
select emp_no, avg(salary), IIF(
        avg(salary) > 100000, 'high', iif(
            avg(salary) > 90000, 'middle', 'low'
        )
    ) as salary_category
from salaries
GROUP BY
    emp_no;

-- window function
select
    emp_no,
    salary,
    from_date,
    to_date,
    row_number() over (
        partition by
            emp_no
        order by from_date
    ) as row_number
from salaries;

select
    emp_no,
    salary,
    from_date,
    lead(salary) over (
        partition by
            emp_no
        order by from_date
    ) as next_salary
from salaries;

select
    emp_no,
    salary,
    from_date,
    lag(salary) over (
        partition by
            emp_no
        order by from_date
    ) as next_salary
from salaries;

select
    emp_no,
    salary,
    from_date,
    to_date,
    sum(salary) over (
        partition by
            emp_no
        order by from_date
    ) as salary_sum
from salaries;

select emp_no, salary, from_date, rank() over (
        partition by
            month(from_date)
        order by from_date, salary desc
    ) as rank
from salaries
where
    from_date >= '2000-01-01'
order by from_date, salary desc;