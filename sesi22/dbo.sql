-- Active: 1725020427389@@127.0.0.1@1433@ecommerce_db@dbo

SELECT * from categories;
-- seed categories data
INSERT INTO
    categories (name)
VALUES ('Category 1'),
    ('Category 2'),
    ('Category 3'),
    ('Category 4'),
    ('Category 5'),
    ('Category 6'),
    ('Category 7'),
    ('Category 8'),
    ('Category 9'),
    ('Category 10');

INSERT INTO
    products (name, price, stock)
VALUES ('Product 1', 1000.99, 100),
    ('Product 2', 1900.99, 50),
    ('Product 3', 500.99, 200),
    ('Product 4', 800.99, 150),
    ('Product 5', 1200.99, 75),
    ('Product 6', 900.99, 120),
    ('Product 7', 1400.99, 90),
    ('Product 8', 700.99, 180),
    ('Product 9', 1100.99, 60),
    ('Product 10', 600.99, 250);

--
select * from products;

-- seed product_categories data
INSERT INTO
    product_categories (product_id, category_id)
VALUES (1, 1),
    (2, 2),
    (13, 1),
    (4, 3),
    (5, 2),
    (6, 3),
    (7, 1),
    (18, 2),
    (19, 3),
    (10, 1);

select * from product_categories;

INSERT INTO
    product_categories (product_id, category_id)
VALUES (2, 1),
    (4, 2),
    (14, 1),
    (5, 3),
    (6, 2),
    (7, 3),
    (10, 1),
    (19, 2),
    (20, 3),
    (21, 1);

-- operators
select * from products where name is null;

select * from products where name != 'deterjen';

select * from products where name = 'deterjen';

select * from products where stock > 750;

-- select * from products where name > 'calman';
select * from products order by name;

select name, price + 1000 from products;

-- logical operator
-- is not
select * from products where name is not null;
-- is
select * from products where name is null;

-- like => wild card
select * from products where name like 'sa%';

select * from products where name like '%duct 1';

select * from products where name like '%duct%';

-- in porstgres
-- ilike => wild card tapi case insensitive
-- select * from products where name like 'pro%';

-- between
select * from products where price between 1000 and 1500;

select * from products where price >= 1000 and price <= 1500;

-- in
select *
from products
where
    name in (
        'Product 1',
        'Product 2',
        'Product 3'
    );

-- and
select * from products where price > 1000 and stock > 100;

-- or
select * from products where price > 1000 or stock > 100;

-- not in
select *
from products
where
    name not in (
        'Product 1',
        'Product 2',
        'Product 3'
    );

-- join
select *
from
    products p
    join product_categories pc on p.id = pc.product_id
    join categories c on c.id = pc.category_id;

-- filter column apa saja yang mau diambil
-- inner join / join
select
    p.name as product_name,
    p.price as product_price,
    p.stock as product_stock,
    c.name as category_name
from
    products p
    join product_categories pc on p.id = pc.product_id
    join categories c on c.id = pc.category_id;

-- left join
select
    p.name as product_name,
    p.price as product_price,
    p.stock as product_stock,
    c.name as category_name
from
    products p
    left join product_categories pc on p.id = pc.product_id
    left join categories c on c.id = pc.category_id;

-- right join
select
    p.name as product_name,
    p.price as product_price,
    p.stock as product_stock,
    c.name as category_name
from
    products p
    right join product_categories pc on p.id = pc.product_id
    right join categories c on c.id = pc.category_id;

-- full join
select
    p.name as product_name,
    p.price as product_price,
    p.stock as product_stock,
    c.name as category_name
from
    products p
    full join product_categories pc on p.id = pc.product_id
    full join categories c on c.id = pc.category_id;

-- cross join
select
    p.name as product_name,
    p.price as product_price,
    p.stock as product_stock,
    c.name as category_name
from products p
    cross join categories c
order by p.name;

-- gimana caranya kita filter
-- data dari join

select
    p.name as product_name,
    p.price as product_price,
    p.stock as product_stock,
    c.name as category_name
from
    products p
    left join product_categories pc on p.id = pc.product_id
    left join categories c on c.id = pc.category_id
where
    c.name = 'Category 1'
    and p.stock > 100
order by p.name desc;

select
    p.name as product_name,
    p.price as product_price,
    p.stock as product_stock,
    c.name as category_name
from
    products p
    left join product_categories pc on p.id = pc.product_id
    left join categories c on c.id = pc.category_id;