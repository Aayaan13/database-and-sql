

CREATE DATABASE gym;
USE gym;




CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(10) UNIQUE NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    join_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    address VARCHAR(255),
    status ENUM('Active','Inactive') DEFAULT 'Active',
    CONSTRAINT chk_phone_number CHECK (phone_number REGEXP '^[0-9]{10}$'),
    CONSTRAINT chk_email_format CHECK (
        email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
);


CREATE TABLE memberships (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    duration VARCHAR(20) NOT NULL, -- e.g., Monthly, Quarterly, Yearly
    price DECIMAL(10,2) NOT NULL
);


CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role ENUM('Trainer','Receptionist','Cleaner','Manager') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(10) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    status ENUM('Active','Inactive') DEFAULT 'Active',
    CONSTRAINT chk_phone_number_staff CHECK (phone_number REGEXP '^[0-9]{10}$'),
    CONSTRAINT chk_email_staff CHECK (
        email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
);


CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    check_in DATETIME NOT NULL,
    check_out DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    staff_id INT NOT NULL,
    membership_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    method ENUM('Cash','Card','UPI') NOT NULL,
    payment_status ENUM('Paid','Pending','Failed') NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (membership_id) REFERENCES memberships(membership_id)
);


CREATE TABLE equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    condition_ ENUM('Excellent','Good','Average','Needs Repair') DEFAULT 'Good',
    purchase_date DATE NOT NULL,
    maintenance_date DATE NOT NULL
);


CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    staff_id INT,
    equipment_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    feedback_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);


CREATE TABLE member_subscriptions (
    member_id INT NOT NULL,
    membership_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('Active','Expired') DEFAULT 'Active',
    PRIMARY KEY (member_id, membership_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (membership_id) REFERENCES memberships(membership_id)
);


CREATE TABLE equipment_usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    equipment_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);


CREATE TABLE equipment_staff (
    equipment_id INT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (equipment_id, staff_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);


CREATE INDEX idx_member_email ON members(email);
CREATE INDEX idx_payment_member ON payments(member_id);
CREATE INDEX idx_attendance_member ON attendance(member_id);
