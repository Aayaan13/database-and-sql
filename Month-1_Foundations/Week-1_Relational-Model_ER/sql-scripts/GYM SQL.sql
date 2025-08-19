CREATE DATABASE gym;
USE gym;
CREATE TABLE Members (
member_ID varchar(20) PRIMARY KEY,
email varchar(30) NOT NULL,
gender char(1) NOT NULL,
join_date date NOT NULL,
Fname char(20) NOT NULL,
Lname char(20) NOT NULL,
address varchar(255) NOT NULL,
date_of_birth date NOT NULL,
phone_number VARCHAR(10) UNIQUE NOT NULL,
CONSTRAINT chk_phone_number CHECK (phone_number REGEXP '^[0-9]{10}$'),
CONSTRAINT chk_email_format CHECK (email LIKE '%@%.com')
);
CREATE TABLE membership (
price varchar(10) NOT NULL ,
duration varchar(20) NOT NULL,
membership_ID varchar(20) PRIMARY KEY,
CONSTRAINT chk_price_format CHECK (price LIKE '$%')
);
CREATE TABLE staff (
staff_ID varchar(20) PRIMARY KEY ,
role_ char(30) NOT NULL,
Fname char(20) NOT NULL,
Lname char(20) NOT NULL,
email varchar(30) NOT NULL,
phone_number VARCHAR(10) UNIQUE NOT NULL,
CONSTRAINT chk_phone_numbers CHECK (phone_number REGEXP '^[0-9]{10}$'),
join_date date NOT NULL,
salary varchar(10) NOT NULL,
CONSTRAINT chk_salary_format CHECK (salary LIKE '$%')
);
CREATE TABLE attendance (
member_ID varchar(20) NOT NULL,
staff_ID varchar(20) NOT NULL,
attendance_ID varchar(20) PRIMARY KEY,
check_in_date date NOT NULL,
check_in_time time NOT NULL,
check_out_time time NOT NULL,
FOREIGN KEY (member_id) REFERENCES Members(member_ID),
FOREIGN KEY (staff_id) REFERENCES staff(staff_ID)
);
CREATE TABLE Payment (
member_ID varchar(20) NOT NULL,
FOREIGN KEY (member_id) REFERENCES Members(member_ID),
staff_ID varchar(20) NOT NULL,
FOREIGN KEY (staff_id) REFERENCES staff(staff_ID),
membership_ID varchar(20) NOT NULL,
FOREIGN KEY (membership_ID) REFERENCES membership(membership_ID),
amount varchar(20) NOT NULL,
payment_date date NOT NULL,
method varchar(20) NOT NULL,
payment_status boolean NOT NULL
);
ALTER TABLE Payment
ADD COLUMN payment_ID varchar(20) PRIMARY KEY;
CREATE TABLE equipment (
equipment_ID VARCHAR(20) PRIMARY KEY,
equipment_name varchar(20) ,
cost varchar(20) NOT NULL,
condition_ varchar(20),
purchase_date date NOT NULL,
maintenance_date date NOT NULL
);
CREATE TABLE feedback (
staff_ID varchar(20) NOT NULL,
FOREIGN KEY (staff_ID) REFERENCES staff(staff_ID),
feedback_ID varchar(20) UNIQUE,
rating int ,
review char ,
equipment_ID varchar(20) NOT NULL,
FOREIGN KEY (equipment_ID) REFERENCES equipment(equipment_ID),
member_ID varchar(20) NOT NULL,
FOREIGN KEY (member_ID) REFERENCES Members(member_ID),
PRIMARY KEY (member_ID,feedback_ID)
);
CREATE TABLE members_membership (
member_ID varchar(20) NOT NULL,
FOREIGN KEY (member_ID) REFERENCES Members(member_ID),
membership_ID varchar(20) NOT NULL,
FOREIGN KEY (membership_ID) REFERENCES membership(membership_ID),
PRIMARY KEY (member_ID,membership_ID)
);
CREATE TABLE members_equipment (
member_ID varchar(20) NOT NULL,
FOREIGN KEY (member_ID) REFERENCES Members(member_ID),
equipment_ID varchar(20) NOT NULL,
FOREIGN KEY (equipment_ID) REFERENCES equipment(equipment_ID),
PRIMARY KEY (member_ID,equipment_ID)
);
CREATE TABLE equipment_staff (
equipment_ID varchar(20) NOT NULL,
FOREIGN KEY (equipment_ID) REFERENCES equipment(equipment_ID),
staff_ID varchar(20) NOT NULL,
FOREIGN KEY (staff_ID) REFERENCES staff(staff_ID),
PRIMARY KEY (equipment_ID,staff_ID)
);
CREATE TABLE members_feedback (
member_ID varchar(20) NOT NULL,
FOREIGN KEY (member_ID) REFERENCES Members(member_ID),
feedback_ID varchar(20) NOT NULL,
FOREIGN KEY (feedback_ID) REFERENCES feedback(feedback_ID),
PRIMARY KEY (member_ID,feedback_ID)
);


