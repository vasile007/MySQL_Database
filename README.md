# 🛠️ MySQL Database – Vacation Stay Management

This is a simple MySQL-based project that demonstrates how to design and work with a relational database for managing vacation stay information. It includes tables and queries for properties, bookings, customers, staff, and payments.

📖 About  
This project is focused on creating a structured and normalized MySQL database for a vacation rental management system. It showcases how to define tables, relationships, and populate data using SQL.

🧰 Technologies Used  
- MySQL 8+  
- SQL (DDL & DML)  
- MySQL Workbench or phpMyAdmin (for GUI)  

⚙️ Installation & Setup  

1. **Clone the repository**  
   ```bash
   git clone https://github.com/vasile007/MySQL_Database.git  
   cd MySQL_Database  

'''
😊 Import the SQL file
Open vacantionstay (1).sql in MySQL Workbench or any SQL client, and run the script to create the database and tables.

Verify the database
After running the script, make sure the following tables were created:

1. properties

2. bookings

3. customers

4. staff

5. payments

🚀 Usage
Once the database is set up, you can run standard SQL queries to interact with it. Example operations:
-- View all properties
SELECT * FROM properties;

-- Add a new customer
INSERT INTO customers (first_name, last_name, email) VALUES ('John', 'Doe', 'john@example.com');

-- Create a new booking
INSERT INTO bookings (customer_id, property_id, check_in_date, check_out_date) VALUES (1, 2, '2025-06-01', '2025-06-07');

🧪 Example Queries
-- Get all bookings for a specific customer
SELECT b.*, c.first_name, c.last_name
FROM bookings b
JOIN customers c ON b.customer_id = c.id
WHERE c.email = 'john@example.com';

-- Total payments made
SELECT SUM(amount) AS total_payments FROM payments;

🤝 Contributing
Contributions are welcome! Here's how to contribute:

Fork the repository

Create a new branch: git checkout -b feature-name

Commit your changes: git commit -m 'Add feature'

Push to your branch: git push origin feature-name

Open a Pull Request


