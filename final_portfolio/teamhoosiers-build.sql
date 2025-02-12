-- Isaac T, Will G, John B, Connor P
DROP TABLE IF EXISTS Receives;
DROP TABLE IF EXISTS `From`;
DROP TABLE IF EXISTS Holds;
DROP TABLE IF EXISTS item_details;
DROP TABLE IF EXISTS receipt;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS problem_sheet;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(50)
);
--Customer data
insert into customer (customer_id, first_name, last_name, phone, email) values (1, 'Florry', 'Antognetti', '865-810-1223', 'fantognetti0@mashable.com');
insert into customer (customer_id, first_name, last_name, phone, email) values (2, 'Brnaby', 'Blenkin', '545-540-0510', 'bblenkin1@java.com');
insert into customer (customer_id, first_name, last_name, phone, email) values (3, 'Pammy', 'Braznell', '927-323-8936', 'pbraznell2@de.vu');
insert into customer (customer_id, first_name, last_name, phone, email) values (4, 'Hersh', 'Enocksson', '276-470-5751', 'henocksson3@wufoo.com');
insert into customer (customer_id, first_name, last_name, phone, email) values (5, 'Traci', 'Lesley', '940-840-7499', 'tlesley4@multiply.com');
insert into customer (customer_id, first_name, last_name, phone, email) values (6, 'Reggie', 'Creboe', '826-965-7744', 'rcreboe5@youtu.be');
insert into customer (customer_id, first_name, last_name, phone, email) values (7, 'Wilmer', 'Gotliffe', '953-300-3714', 'wgotliffe6@bbb.org');
insert into customer (customer_id, first_name, last_name, phone, email) values (8, 'Inga', 'Chew', '430-991-6086', 'ichew7@weibo.com');
insert into customer (customer_id, first_name, last_name, phone, email) values (9, 'Debora', 'Pattle', '196-784-9245', 'dpattle8@oakley.com');
insert into customer (customer_id, first_name, last_name, phone, email) values (10, 'Brianne', 'Demcik', '871-665-8422', 'bdemcik9@reuters.com');


CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(50),
    dob DATE,
    ssn VARCHAR(50)
);
--employee data
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (1, 'Petr', 'Delgadillo', '824-902-6767', 'pdelgadillo0@bloglines.com', '1992-02-20', '592-41-0444');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (2, 'Corilla', 'Scarff', '444-754-7855', 'cscarff1@engadget.com', '1988-04-05', '793-74-4884');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (3, 'Justinian', 'Camilleri', '587-941-2770', 'jcamilleri2@com.com', '1984-07-16', '854-11-1591');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (4, 'Glynda', 'Morison', '942-137-2502', 'gmorison3@wired.com', '2001-02-09', '585-65-3744');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (5, 'Dorotea', 'Jiroutka', '966-599-6267', 'djiroutka4@ucla.edu', '1983-12-27', '763-21-2835');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (6, 'Isidoro', 'Dimitrescu', '303-229-2666', 'idimitrescu5@noaa.gov', '2003-03-25', '114-06-6943');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (7, 'Filberto', 'Hlavecek', '405-771-6034', 'fhlavecek6@va.gov', '2006-05-13', '859-09-9224');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (8, 'Burty', 'Comini', '397-262-9527', 'bcomini7@senate.gov', '1986-03-07', '886-27-4580');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (9, 'Sam', 'Bosquet', '578-489-9971', 'sbosquet8@so-net.ne.jp', '2000-01-20', '367-84-5775');
INSERT INTO employee (employee_id, first_name, last_name, phone, email, dob, ssn) VALUES (10, 'Dotti', 'Andreev', '267-752-3344', 'dandreev9@narod.ru', '2004-04-02', '665-89-9588');

CREATE TABLE item (
    item_id INT PRIMARY KEY,
    model VARCHAR(50),
    version VARCHAR(50)
);
--item data
INSERT INTO item (item_id, model, version) VALUES (1, 'O2 XDA Flame', '1.9');
INSERT INTO item (item_id, model, version) VALUES (2, 'Micromax Bolt D303', '0.7.3');
INSERT INTO item (item_id, model, version) VALUES (3, 'Micromax A115 Canvas 3D', '5.4');
INSERT INTO item (item_id, model, version) VALUES (4, 'Panasonic GD70', '2.3.3');
INSERT INTO item (item_id, model, version) VALUES (5, 'Bird S1186', '9.7.9');
INSERT INTO item (item_id, model, version) VALUES (6, 'Sony Xperia Tablet S 3G', '6.1');
INSERT INTO item (item_id, model, version) VALUES (7, 'vivo Y9s', '1.8.6');
INSERT INTO item (item_id, model, version) VALUES (8, 'Micromax Bolt A51', '0.56');
INSERT INTO item (item_id, model, version) VALUES (9, 'BLU Studio X Mini', '1.0.8');
INSERT INTO item (item_id, model, version) VALUES (10, 'Panasonic Eluga Ray 700', '6.0');

CREATE TABLE problem_sheet (
    problem_sheet_id INT,
    expected_completion_time DATE,
    item_id INT,
	FOREIGN KEY (item_id) REFERENCES item(item_id)
);
--problem_sheet data
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (1, '2026-07-27', 1);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (2, '2026-09-15', 2);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (3, '2026-07-19', 3);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (4, '2026-08-08', 4);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (5, '2026-09-27', 5);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (6, '2026-07-12', 6);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (7, '2024-11-28', 7);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (8, '2025-11-13', 8);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (9, '2025-12-23', 9);
INSERT INTO problem_sheet (problem_sheet_id, expected_completion_time, item_id) VALUES (10, '2024-11-08', 10);


create table inventory (
	inventory_id INT PRIMARY KEY,
	quantity INT,
	price DECIMAL,
	cost DECIMAL,
	item_id INT,
	FOREIGN KEY (item_id) REFERENCES item(item_id)
);
--inventory data
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (1, 3, 142.42, 47.96, 1);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (2, 16, 69.19, 27.84, 2);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (3, 13, 91.94, 48.46, 3);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (4, 15, 131.43, 40.24, 4);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (5, 12, 128.82, 40.38, 5);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (6, 15, 89.96, 24.24, 6);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (7, 4, 94.83, 46.04, 7);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (8, 8, 101.49, 38.28, 8);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (9, 1, 50.46, 26.64, 9);
INSERT INTO inventory (inventory_id, quantity, price, cost, item_id) VALUES (10, 9, 75.19, 20.62, 10);


create table supplier (
	supplier_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	phone VARCHAR(50)
);
--supplier data
insert into supplier (supplier_id, first_name, last_name, phone) values (1, 'Brandon', 'Kinforth', '627-738-3206');
insert into supplier (supplier_id, first_name, last_name, phone) values (2, 'Freeman', 'Calley', '657-105-5388');
insert into supplier (supplier_id, first_name, last_name, phone) values (3, 'Farly', 'Riseley', '693-949-6383');
insert into supplier (supplier_id, first_name, last_name, phone) values (4, 'Virgil', 'Laphorn', '494-154-3166');
insert into supplier (supplier_id, first_name, last_name, phone) values (5, 'Alain', 'Anscott', '999-266-4887');
insert into supplier (supplier_id, first_name, last_name, phone) values (6, 'Wyndham', 'Musico', '550-172-9874');
insert into supplier (supplier_id, first_name, last_name, phone) values (7, 'Kayle', 'Millington', '640-333-8118');
insert into supplier (supplier_id, first_name, last_name, phone) values (8, 'Kelci', 'Korpolak', '253-771-2611');
insert into supplier (supplier_id, first_name, last_name, phone) values (9, 'Morena', 'Millom', '168-405-4602');
insert into supplier (supplier_id, first_name, last_name, phone) values (10, 'Kathe', 'Laise', '132-383-4338');


create table orders (
	order_id INT PRIMARY KEY,
	order_date DATE,
	delivery_date DATE,
	cost DECIMAL (10,2),
	supplier_id INT,
	FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);
--orders data
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (1, '2024-01-15', '2024-01-20', 12.31, 2);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (2, '2024-02-10', '2024-02-15', 31.81, 3);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (3, '2024-03-05', '2024-03-10', 17.95, 5);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (4, '2024-04-01', '2024-04-06', 29.96, 6);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (5, '2024-05-20', '2024-05-25', 23.01, 9);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (6, '2024-06-15', '2024-06-20', 46.29, 5);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (7, '2024-07-10', '2024-07-15', 14.83, 7);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (8, '2024-08-05', '2024-08-10', 16.57, 5);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (9, '2024-09-01', '2024-09-06', 41.18, 8);
INSERT INTO orders (order_id, order_date, delivery_date, cost, supplier_id) VALUES (10, '2024-10-20', '2024-10-25', 15.07, 10);


create table receipt (
	receipt_id INT,
	quantity INT,
	cost DECIMAL (10,2),
	order_id INT,
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
--recipt data
insert into receipt (receipt_id, quantity, cost, order_id) values (1, 1, '98.23', 3);
insert into receipt (receipt_id, quantity, cost, order_id) values (2, 18, '62.35', 7);
insert into receipt (receipt_id, quantity, cost, order_id) values (3, 13, '84.41', 2);
insert into receipt (receipt_id, quantity, cost, order_id) values (4, 12, '87.28', 8);
insert into receipt (receipt_id, quantity, cost, order_id) values (5, 6, '120.46', 7);
insert into receipt (receipt_id, quantity, cost, order_id) values (6, 14, '116.67', 1);
insert into receipt (receipt_id, quantity, cost, order_id) values (7, 14, '132.05', 2);
insert into receipt (receipt_id, quantity, cost, order_id) values (8, 15, '103.51', 10);
insert into receipt (receipt_id, quantity, cost, order_id) values (9, 8, '96.44', 10);
insert into receipt (receipt_id, quantity, cost, order_id) values (10, 19, '115.33', 4);


create table item_details (
	item_details_id INT,
	labor_cost DECIMAL (10,2),
	issue_type VARCHAR(50),
	date DATE,
	time VARCHAR(50),
	item_id INT,
	employee_id INT,
	FOREIGN KEY (item_id) REFERENCES item(item_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);
--item_details data
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (1, 115.05, '1.65', '2021-05-03', '10:31 PM', 10, 5);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (2, 114.29, '0.98', '2023-05-12', '6:07 AM', 2, 4);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (3, 103.80, '0.42', '2025-01-23', '6:46 PM', 9, 3);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (4, 95.05, '0.8.0', '2024-09-24', '1:55 PM', 9, 7);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (5, 72.39, '0.1.5', '2021-11-28', '3:01 AM', 7, 1);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (6, 97.45, '3.5.0', '2022-10-29', '5:44 PM', 2, 10);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (7, 112.83, '2.1.1', '2025-03-18', '7:07 PM', 8, 2);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (8, 92.52, '0.2.5', '2023-06-09', '3:02 AM', 6, 6);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (9, 118.71, '8.90', '2022-01-28', '9:00 AM', 9, 9);
INSERT INTO item_details (item_details_id, labor_cost, issue_type, date, time, item_id, employee_id) VALUES (10, 65.84, '0.52', '2025-07-10', '7:14 PM', 6, 8);


CREATE TABLE Holds ( 
    customer_ID INT, 
    employee_ID INT, 
    FOREIGN KEY (customer_ID) REFERENCES customer(customer_ID), 
    FOREIGN KEY (employee_ID) REFERENCES employee(employee_ID), 
    PRIMARY KEY (customer_ID, employee_ID) 
);
INSERT INTO Holds (customer_ID, employee_ID) 
VALUES 
(1, 1), (1, 2),                                   
(2, 3), (2, 6),                                  
(3, 1),                                           
(4, 1), (4, 3), (4, 7),                           
(5, 2), (5, 4), (5, 8),                           
(6, 6),                                           
(7, 3), (7, 7),                                   
(8, 4), (8, 5), (8, 6),                           
(9, 1), (9, 2), (9, 9),                           
(10, 3), (10, 4), (10, 10);                       


CREATE TABLE `From` (
    inventory_ID INT,
    supplier_ID INT,
    item_ID INT,
    FOREIGN KEY (inventory_ID) REFERENCES inventory(inventory_ID),
    FOREIGN KEY (supplier_ID) REFERENCES supplier(supplier_ID),
    FOREIGN KEY (item_ID) REFERENCES item(item_ID),
    PRIMARY KEY (inventory_ID, supplier_ID)
);
--`From` data
INSERT INTO `From` (inventory_ID, supplier_ID, item_ID) 
VALUES 
(1, 1, 1), (2, 1, 2),                             
(3, 2, 3), (4, 2, 4),                             
(5, 3, 5),                                        
(6, 4, 6), (7, 4, 7), (8, 4, 8),                  
(9, 5, 9), (10, 5, 10), (1, 5, 1),                
(2, 6, 2), (3, 6, 3),                             
(4, 7, 4), (5, 7, 5), (6, 7, 6),                  
(7, 8, 7), (8, 8, 8), (9, 8, 9),                 
(10, 9, 10), (1, 9, 2),                          
(2, 10, 3), (3, 10, 4);      



CREATE TABLE Receives ( 
	inventory_ID INT, 
	customer_ID INT, 
	item_ID INT, 
	FOREIGN KEY (inventory_ID) REFERENCES inventory(inventory_ID), 
	FOREIGN KEY (customer_ID) REFERENCES customer(customer_ID), 
	FOREIGN KEY (item_ID) REFERENCES item(item_ID), 
	PRIMARY KEY (inventory_ID, customer_ID) 
);

INSERT INTO Receives (inventory_ID, customer_ID, item_ID) 
VALUES 
(1, 1, 1), (2, 1, 2), (3, 1, 3),                   
(4, 2, 4), (5, 2, 5),                             
(6, 3, 6),                                         
(7, 4, 7), (8, 4, 8), (9, 4, 9),                   
(10, 5, 10), (1, 5, 3), (2, 5, 2),                 
(3, 6, 1), (4, 6, 4),                              
(5, 7, 5), (6, 7, 6), (7, 7, 7),                   
(8, 8, 8), (9, 8, 2), (10, 8, 4),                  
(1, 9, 9), (2, 9, 10), (3, 9, 1),                  
(4, 10, 2), (5, 10, 5), (6, 10, 8);                
