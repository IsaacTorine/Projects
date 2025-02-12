import csv
import os

import pymysql



def load_password():
    path = os.path.join(os.path.expanduser("~"), "i211f24-password.txt")
    with open(path) as fh:
        return fh.read().strip()


DB_PASSWORD = load_password()

DB_HOST = "db.luddy.indiana.edu"
DB_USER =  "i211f24_istorine"

DB_DATABASE=  "i211f24_istorine"

#helper functions for database
def get_connection():
    return pymysql.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_DATABASE,
        cursorclass=pymysql.cursors.DictCursor,
    )
#Customers
def get_customers():
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("SELECT * FROM customers")
        customers = curr.fetchall()
    conn.commit()
    conn.close()
    return customers

def get_one_customer(id):
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("SELECT * FROM customers WHERE id = %s", (id))
        customer = curr.fetchone()
    conn.commit()
    conn.close()
    return customer
#Items
def get_items():
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("SELECT * FROM items")
        items  = curr.fetchall()
    conn.commit()
    conn.close()
    return items

def get_one_item(id):
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("SELECT * FROM items WHERE id = %s", (id))
        item = curr.fetchone()
    conn.commit()
    conn.close()
    return item
#Orders
def get_orders():
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("SELECT * FROM orders")
        orders = curr.fetchall()
    conn.commit()
    conn.close()
    return orders

def get_one_order(order_id):
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("SELECT * FROM orders WHERE order_id = %s", (order_id))
        item = curr.fetchone()
    conn.commit()
    conn.close()
    return item    
#Cart
def get_cart():
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("SELECT * FROM cart")
        cart = curr.fetchall()
    conn.commit()
    conn.close()
    return cart

def clear_cart():
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute("DELETE FROM cart")
        cart = curr.fetchall()
    conn.commit()
    conn.close()
    return cart

#Connection
def initialize_db():
    conn = get_connection()

    #SQL Tables
    _customers= """
        CREATE TABLE customers (
            id INT AUTO_INCREMENT PRIMARY KEY,
            customer_name VARCHAR(100),
            customer_email VARCHAR(500),
            customer_phone VARCHAR(15)
        )  engine=InnoDB
        """
    _items= """
        CREATE TABLE items (
            id INT AUTO_INCREMENT PRIMARY KEY,
            item_name VARCHAR(1000),
            image_path TINYTEXT,
            cost FLOAT(4,2)
        )  engine=InnoDB
        """
    _orders = """
        CREATE TABLE orders (
            order_id VARCHAR(100),
            customer_name VARCHAR(1000),
            item_ordered VARCHAR(1000)
        )  engine=InnoDB
        """
    _cart = """ 
    CREATE TABLE cart ( 
    id INT AUTO_INCREMENT PRIMARY KEY, 
    item_id INT, 
    quantity INT,
    item_name VARCHAR(75),
    total_cost DECIMAL(10,2),
    CONSTRAINT `fk_item_id` 
        FOREIGN KEY (item_id) REFERENCES items(id) 
    ) engine=InnoDB 
    """
   

    with conn.cursor() as curr:
        curr.execute("drop table if exists cart")
        curr.execute("drop table if exists customers")
        curr.execute("drop table if exists items")
        curr.execute("drop table if exists orders")
        curr.execute(_customers)
        curr.execute(_items)
        curr.execute(_orders)
        curr.execute(_cart)
    conn.commit()
    conn.close()

#Functions to add to database 
#Customer
def add_customer(customer: dict[str, str]) -> None:
    """takes a dictionary and inserts into a database table"""
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute(
            "insert into customers (customer_name, customer_email, customer_phone) values (%s, %s, %s)",
            (
                customer["customer_name"],
                customer["customer_email"],
                customer["customer_phone"],
            ),
        )
    conn.commit()
    conn.close()

def update_customer(customer_id: int, updated_customer: dict[str, str]) -> None:
    """Updates a customer's details in the database."""
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute(
            """
            UPDATE customers 
            SET customer_name = %s, customer_email = %s, customer_phone = %s
            WHERE id = %s
            """,
            (
                updated_customer["customer_name"],
                updated_customer["customer_email"],
                updated_customer["customer_phone"],
                customer_id,
            ),
        )
    conn.commit()
    conn.close()

#Item
def add_item(item: dict[str, str]) -> None:
    """takes a dictionary and inserts into a database table"""
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute(
            "insert into items (item_name,image_path,cost) values (%s, %s, %s)",
            (
                item["item_name"],
                item["image_path"],
                item["cost"],
            ),
        )
    conn.commit()
    conn.close()

def update_item(item_id: int, updated_item: dict[str, str]) -> None:
    """Updates a item's details in the database."""
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute(
            """
            UPDATE items 
            SET item_name = %s, image_path = %s, cost = %s
            WHERE id = %s
            """,
            (
                updated_item["item_name"],
                updated_item["image_path"],
                updated_item["cost"],
                item_id,
            ),
        )
    conn.commit()
    conn.close()

#Orders
def add_order(order: dict[str, str]) -> None:
    """takes a dictionary and inserts into a database table"""
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute(
            "insert into orders (order_id, customer_name, item_ordered) values (%s, %s, %s)",
            (
                order["order_id"],
                order["customer_name"],
                order["item_ordered"],
            ),
        )
    conn.commit()
    conn.close()
#Cart
def add_item_to_cart(cart_item: dict[str, str]) -> None:
    """takes a dictionary and inserts into a database table"""
    conn = get_connection()
    with conn.cursor() as curr:
        curr.execute(
            "insert into cart (item_id, item_name, quantity, total_cost) values (%s,%s,%s,%s)",
            (
                cart_item["item_id"],
                cart_item["item_name"],
                cart_item["quantity"],
                cart_item["total_cost"],
            ),
        )
    conn.commit()
    conn.close()

if __name__ == "__main__":
    initialize_db()

    with open("customer.csv") as csvf:
        for customer in csv.DictReader(csvf):
            add_customer(customer)

    with open("items.csv") as csvf:
        for item in csv.DictReader(csvf):
            add_item(item)

    with open("order.csv") as csvf:
        for order in csv.DictReader(csvf):
            add_order(order)

