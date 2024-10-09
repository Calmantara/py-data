-- Active: 1725020427389@@127.0.0.1@1433@ecommerce_db@dbo

select * from customers;

-- seeding customers data
INSERT INTO
    customers (name, email, phone, alamat)
VALUES (
        'Alice Brown',
        'alice.brown@mail.com',
        '1111111111',
        '321 Pine St, San Francisco, CA'
    ),
    (
        'Bob Wilson',
        'bob.wilson@mail.com',
        '2222222222',
        '654 Cedar St, Seattle, WA'
    ),
    (
        'Emily Davis',
        'emily.davis@mail.com',
        '3333333333',
        '987 Maple St, Boston, MA'
    ),
    (
        'David Lee',
        'david.lee@mail.com',
        '4444444444',
        '741 Birch St, Miami, FL'
    ),
    (
        'Sarah Taylor',
        'sarah.taylor@mail.com',
        '5555555555',
        '852 Walnut St, Denver, CO'
    ),
    (
        'Michael Clark',
        'michael.clark@mail.com',
        '6666666666',
        '963 Oak St, Houston, TX'
    ),
    (
        'Olivia Anderson',
        'olivia.anderson@mail.com',
        '7777777777',
        '159 Elm St, Phoenix, AZ'
    ),
    (
        'William Martinez',
        'william.martinez@mail.com',
        '8888888888',
        '357 Pine St, San Diego, CA'
    ),
    (
        'Sophia Thomas',
        'sophia.thomas@mail.com',
        '9999999999',
        '753 Cedar St, Portland, OR'
    ),
    (
        'Daniel Harris',
        'daniel.harris@mail.com',
        '0000000000',
        '951 Maple St, Austin, TX'
    );

-- % wild card
select * from customers where name like '%z';

-- _ wild card
select * from customers where name like '%Dav_%';

-- [a-z] wild card
select * from customers where name like '[a,d]%';

select * from customers where name like '[a-F]%';

-- [^a-z] wild card
select * from customers where name like '[^a-f]%';

-- not like wild card
select * from customers where name not like '[a-f]%';

-- between wild card
select * from customers where name between 'A%' and 'B%';

-- sub query
-- kita membuat query di dalam query
select *, (
        select AVG(salary)
        from salaries
        where
            emp_no in (1, 2, 3, 4, 5)
    )
from salaries
where
    emp_no in (1, 2, 3, 4, 5);

-- ambil semua data yang memiliki avg salary > 100000
select *
from salaries
where
    emp_no in (
        select emp_no
        from salaries
        GROUP BY
            emp_no
        HAVING
            AVG(salary) > 100000
    );

select emp_no, AVG(salary) as avg_salary
from salaries
GROUP BY
    emp_no
HAVING
    AVG(salary) > 100000;

-- sub query from
select MAX(avg_salary)
from (
        select emp_no, AVG(salary) as avg_salary
        from salaries
        GROUP BY
            emp_no
        HAVING
            AVG(salary) > 100000
    ) filtered_salaries;

-- carilah maximum salary dari setiap emp_no
-- beserta tanggal berapa saja salary tersebut diterima
select top 10 * from salaries;

-- mencari maximum salary dari setiap emp_no
select emp_no, max(salary) as max_salary, from_date
from salaries
group by
    emp_no,
    from_date
having
    emp_no = 100;

-- solusi 1
select salaries.*
from salaries
    join (
        select emp_no, max(salary) as max_salary
        from salaries
        group by
            emp_no
    ) max_salaries on salaries.emp_no = max_salaries.emp_no
    and salaries.salary = max_salaries.max_salary
where
    salaries.emp_no = 100;

-- solusi 2
EXPLAIN WITH_RECOMMENDATIONS
select DISTINCT (emp_no),
    first_value(id) over (
        partition by
            emp_no
        order by salary desc
    ) as id,
    first_value(salary) over (
        partition by
            emp_no
        order by salary desc
    ) as max_salary,
    first_value(from_date) over (
        partition by
            emp_no
        order by salary desc
    ) as from_date
from salaries
where
    emp_no = 100;

-- common table expression

select emp_no, max(salary) as max_salary
from salaries
group by
    emp_no
ORDER BY emp_no;

with
    max_salaries as (
        select emp_no, max(salary) as max_salary
        from salaries
        group by
            emp_no
        ORDER BY emp_no
    )
select salaries.*
from salaries
    join max_salaries on salaries.emp_no = max_salaries.emp_no
    and salaries.salary = max_salaries.max_salary
where
    salaries.emp_no = 100
order by salaries.emp_no;