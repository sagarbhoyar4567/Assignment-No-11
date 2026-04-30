
create database assignment;

use  assignment;

CREATE TABLE factory (
factory_id INT PRIMARY KEY,
factory_name VARCHAR(100),
location VARCHAR(50),
manager_name VARCHAR(50)
);

INSERT INTO factory VALUES
(1, 'Alpha Manufacturing', 'Pune', 'Rajesh Kumar'),
(2, 'Beta Industries', 'Chennai', 'Suresh Iyer'),
(3, 'Gamma Works', 'Bangalore', 'Anita Sharma'),
(4, 'Delta Corp', 'Hyderabad', 'Ravi Verma'),
(5, 'Omega Manufacturing', 'Ahmedabad', 'Neha Patel');

CREATE TABLE production (
production_id INT PRIMARY KEY,
factory_id INT,
product_name VARCHAR(50),
quantity_produced INT,
production_cost DECIMAL(10,2),
production_date DATE,
shift VARCHAR(10),
FOREIGN KEY (factory_id) REFERENCES factory(factory_id)
);

INSERT INTO production VALUES
(1, 1, 'Gear Box', 120, 45000, '2025-01-01', 'Day'),
(2, 1, 'Engine Part', 90, 72000, '2025-01-02', 'Night'),
(3, 2, 'Brake Pad', 200, 30000, '2025-01-03', 'Day'),
(4, 2, 'Clutch Plate', 150, 55000, '2025-01-04', 'Night'),
(5, 3, 'Axle Rod', 80, 40000, '2025-01-05', 'Day'),
(6, 3, 'Gear Box', 110, 46000, '2025-01-06', 'Night'),
(7, 4, 'Piston', 130, 60000, '2025-01-07', 'Day'),
(8, 4, 'Cylinder', 95, 52000, '2025-01-08', 'Night'),
(9, 5, 'Engine Block', 70, 90000, '2025-01-09', 'Day'),
(10, 5, 'Crank Shaft', 60, 85000, '2025-01-10', 'Night'),
(11, 1, 'Brake Pad', 210, 31000, '2025-01-11', 'Day'),
(12, 2, 'Gear Box', 140, 47000, '2025-01-12', 'Night'),
(13, 3, 'Piston', 125, 61000, '2025-01-13', 'Day'),
(14, 4, 'Clutch Plate', 155, 56000, '2025-01-14', 'Night'),
(15, 5, 'Axle Rod', 100, 42000, '2025-01-15', 'Day'),
(16, 1, 'Cylinder', 85, 50000, '2025-01-16', 'Night'),
(17, 2, 'Engine Part', 95, 74000, '2025-01-17', 'Day'),
(18, 3, 'Brake Pad', 220, 33000, '2025-01-18', 'Night'),
(19, 4, 'Gear Box', 115, 48000, '2025-01-19', 'Day'),
(20, 5, 'Piston', 105, 62000, '2025-01-20', 'Night');





#Questions to be Answered- 

#* Display all records from the production table.

select * from production;

# Show only product_name and quantity_produced.

select product_name,quantity_produced from production;

#Find products where quantity produced is greater than 150.

select product_name from production where quantity_produced>150;

# Fetch records where production cost is less than 50,000.

select * from production where production_cost<50000;

# Show products with quantity between 80 and 120.

select product_name from production where quantity_produced between 80 and 120;

# Get records where product name is Gear Box.

select * from production where product_name='Gear Box';

#Display all records from Day shift.

select * from production where shift='Day';

#Find products manufactured in Night shift.

select product_name from production where shift='Night';

# Display distinct product names.

select distinct product_name from production;

# Display distinct shift values.

select distinct shift from production;

# Sort records by production cost (ascending).

select * from production order by production_cost;

# Sort records by quantity produced (descending).

select * from production order by quantity_produced desc;

# Sort by production date latest first.

select * from production order by production_date desc;

# Display first 5 records.

select * from production limit 5;

#Display top 3 highest production quantities.

select quantity_produced from production order by quantity_produced desc limit 3;

# Display 5 records starting from 6th row

select * from production order by production_id limit 5 offset 5 ;

# Display production details along with factory name.

select  t0.*,t1.Factory_name from production t0 inner join factory t1 on t0.factory_id=t1.factory_id order by production_id;

# Show factory name and total quantity produced.

select  t0.Factory_name, sum(t1.quantity_produced) as "total quantity produced" 
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
group by t0.Factory_name;

# List all products manufactured in Pune.

select  distinct t1.product_name
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
Where location='Pune'

# Show factory-wise production cost greater than 60,000.

select  t0.factory_name,sum(production_cost) as "Production Cost"
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
group by t0.factory_name
having sum(production_cost)>60000;

# or 

select  t0.factory_name,production_cost as "Production Cost"
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
Where production_cost>60000;

# * Fetch the top 5 most expensive products manufactured in Day shift, along with:factory name,product name,production cost
#Sort the results by production cost in descending order.

select product_name,production_cost,factory_name from (
select product_name,production_cost,factory_name,row_number()over(partition by product_name order by production_cost desc) as id
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
where shift='Day'
order by production_cost desc
) data where id=1
limit 5;

#  Display distinct product names that are manufactured in Bangalore or Pune factories.

select distinct product_name
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
where location='Bangalore' or location='Pune' ;

#  Retrieve the 3rd to 7th highest quantity produced products, showing:product name,quantity,factory name,Sort by quantity in descending order.

select product_name,quantity_produced,factory_name
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
order by quantity_produced desc
limit 5
offset 3;


# List all products where:production cost is between 40,000 and 70,000,shift is Night,factory is located in Hyderabad or Chennai
# **Display:**,factory name,product name,production cost,shift

select t0.factory_name,t1.product_name,t1.production_cost,t1.shift
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
where shift='Night' 
  and production_cost between '40000' and '70000'
  and (location='Hyderabad' or location='Chennai');

# From all factories, fetch:,factory name,product name,quantity produced Only 
# show records where:quantity produced is greater than 100,product is not ‘Brake Pad’,
# results are sorted by factory name (ASC) and quantity (DESC)

select t0.factory_name,t1.product_name,t1.quantity_produced
from factory t0 inner join production t1 on t0.factory_id=t1.factory_id
where t1.quantity_produced>100 
  and t1.product_name<>'Brake Pad'
order by t0.factory_name desc, t1.quantity_produced desc
