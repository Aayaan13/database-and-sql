CREATE DATABASE OCRS;
USE OCRS;
CREATE TABLE customer (
Fname char(15) NOT NULL,
Mname char(15),
Lname char(15) NOT NULL,
customer_ID varchar(20) PRIMARY KEY,
email varchar(40),
phone_number int(10) UNIQUE,
address varchar(255)
);
CREATE TABLE employee (
manager_ID varchar(20) UNIQUE,
employee_ID varchar(20) PRIMARY KEY,
Fname char(15) NOT NULL,
Mname char(15),
Lname char(15) NOT NULL,
role_ char(30) NOT NULL
);
CREATE TABLE car (
availability_status boolean ,
type_of_car char(30) NOT NULL,
fuel_type char(30) NOT NULL,
manufacturer varchar(50) NOT NULL,
 model_name varchar(50) NOT NULL,
 vehicle_ID varchar(20) PRIMARY KEY
 );
 CREATE TABLE rental (
 rental_ID varchar(20) PRIMARY KEY,
 start_date date NOT NULL,
 end_date date NOT NULL,
 vehicle_ID varchar(20) UNIQUE,
 customer_ID varchar(20) UNIQUE,
 FOREIGN KEY (vehicle_ID) REFERENCES car(vehicle_ID),
 FOREIGN KEY (customer_ID) REFERENCES customer(customer_ID)
 );
CREATE TABLE payment (
payment_ID varchar(20) PRIMARY KEY,
rental_ID varchar(20) UNIQUE,
amount__paid int(10) NOT NULL,
payment_date date NOT NULL,
payment_mode char(20) NOT NULL,
FOREIGN KEY (rental_ID) REFERENCES rental(rental_ID)
);
CREATE TABLE feedback (
feedback_number varchar(20) UNIQUE,
customer_id varchar(20) UNIQUE,
rating int(1),
PRIMARY KEY (feedback_number,customer_id),
FOREIGN KEY (customer_ID) REFERENCES customer(customer_ID)
);
CREATE TABLE gives (
customer_id varchar(20) UNIQUE,
feedback_number varchar(20) UNIQUE,
PRIMARY KEY (feedback_number,customer_id),
FOREIGN KEY (customer_ID) REFERENCES customer(customer_ID),
FOREIGN KEY (feedback_number) REFERENCES feedback(feedback_number)
);
CREATE TABLE manages (
rental_ID varchar(20) UNIQUE,
employee_ID varchar(20) UNIQUE,
PRIMARY KEY (rental_ID,employee_ID),
FOREIGN KEY (rental_ID) REFERENCES rental(rental_ID),
FOREIGN KEY (employee_ID) REFERENCES employee(employee_ID)
);
