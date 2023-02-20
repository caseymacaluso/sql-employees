-- Create database
create database if not exists sales;

-- Use database
use sales;

-- Create table
-- sales
create table sales (
	purchase_number INT NOT NULL PRIMARY KEY auto_increment,
	date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

select * from sales;
select * from sales.sales;

-- customers
CREATE TABLE customers                                                              
(
    customer_id INT auto_increment,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
primary key (customer_id)
);

# Add column to customers table, place after last_name field
ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

# Insert new record into the customers table
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

# Defined after BOTH tables are defined (sales, customers)
alter table sales
add foreign key (customer_id) references customers(customer_id) on delete cascade;

-- items
create table items
(
	item_code varchar(255),
    item varchar(255),
    unit_price numeric(10,2),
    company_id varchar(255),
primary key (item_code)
);

-- companies
create table companies
(
	company_id varchar(255),
    company_name varchar(255) default 'X', # Add default value for the company name, if none is provided
    headquarters_phone_number integer(12),
primary key (company_id),
unique key (headquarters_phone_number)
);

# Add null constraint to headquarters phone number
alter table companies
modify headquarters_phone_number int(12) null;

# Drop the constraint defined above
alter table companies
change column headquarters_phone_number headquarters_phone_number int(12) not null;

-- Dropping tables from the database
drop table sales;
drop table customers;
drop table items;
drop table companies;