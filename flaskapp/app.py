# Copyright © 2023-2024, Indiana University
# BSD 3-Clause License

from flask import Flask, render_template,url_for, redirect,request
import csv 
from collections import defaultdict

import flaskapp.database as db

app = Flask(__name__)

#all routes below       
@app.route("/")
def render_index():
    items= db.get_items()
    return render_template("index.html", items=items)

@app.route("/customers")
def render_customers():
    customers= db.get_customers()
    return render_template("customer.html", customers= customers)

@app.route("/items")
def render_items():
    items= db.get_items()
    return render_template("item.html", items = items)

@app.route("/orders")
def render_orders():
    orders= db.get_orders()
    return render_template("orders.html", orders = orders)

@app.route("/orders/<order_id>")
def render_order(order_id):
    orders= db.get_orders()
    list =[]
    for item in orders: 
        if order_id == item['order_id']:
            list.append(item)
    return render_template("order.html", list = list)
    
@app.route("/customers/add/",methods=['GET', 'POST'])
def render_add_customers():
    if request.method == "POST":
        customer_name = request.form['customer-name']
        customer_email = request.form['customer-email']
        customer_phone = request.form['customer-phone']

        new_customer = {
            'customer_name': customer_name,
            'customer_email': customer_email,
            'customer_phone': customer_phone,
        }
        db.add_customer(new_customer)

        return redirect(url_for('render_customers'))
    else:
        return render_template("customer_form.html")
    
@app.route("/customers/edit/<customer_id>",methods=['GET', 'POST'])
def render_edit_customers(customer_id):
    if request.method =="POST": 
        updated_name = request.form['customer-name']
        updated_email = request.form['customer-email']
        updated_phone = request.form['customer-phone']

        updated_customer = {
            'customer_name': updated_name,
            'customer_email': updated_email,
            'customer_phone': updated_phone,
        }

        db.update_customer(customer_id, updated_customer)

        return redirect(url_for('render_customers'))
    else:
        customer = db.get_one_customer(customer_id)
        return render_template("customer_form.html", customer= customer)

@app.route("/items/add/",methods=['GET', 'POST'])
def render_add_items():
    if request.method == "POST":
        item_name = request.form['item-name']
        cost = request.form['cost']

        new_item = {
            'item_name': item_name,
            'image_path': 'images/bills-breakfast-images/placeholder.jpg',
            'cost': cost,
        }

        db.add_item(new_item)

        return redirect(url_for('render_items'))
    else:
        return render_template("item_form.html")
    
@app.route("/items/edit/<item_id>",methods=['GET', 'POST'])
def render_edit_items(item_id):
    if request.method =="POST": 
        item = db.get_one_item(item_id)
        updated_item_name = request.form['item-name']
        updated_cost = request.form['cost']
        image_path = item['image_path']

        updated_item = {
            'item_name': updated_item_name,
            'image_path': image_path,
            'cost': updated_cost,
        }

        db.update_item(item_id, updated_item)


        return redirect(url_for('render_items'))
    else:
        item=db.get_one_item(item_id)
        return render_template("item_form.html", item=item)
    
@app.route("/cart")
def cart():
    customers= db.get_customers()
    cart_items= db.get_cart()
    return render_template("cart.html", cart= cart_items, customers = customers)

@app.route("/cart/clear",methods=['POST'])
def clear_cart():
    if request.method == 'POST':
        db.clear_cart()
        return redirect(url_for("cart"))

@app.route("/cart/add/<item_id>",methods=['POST'])
def add_to_cart(item_id):
    item = db.get_one_item(item_id)
    if item:
        cart_item = {
            'item_id': int(item_id),
            'item_name': item['item_name'],
            'quantity':1,
            'total_cost': item['cost']
        }
    db.add_item_to_cart(cart_item)
    return redirect(url_for('render_index'))

@app.route("/cart/checkout", methods=["POST"])
def cart_checkout():
    if request.method == "POST":
        customer_id = request.form.get("customers")
        customer = db.get_one_customer(customer_id)

        if not customer:
            return "Customer not found", 400

        cart_items = db.get_cart()
        if not cart_items:
            return "Cart is empty", 400
        
        existing_order_id = 0  
        existing_orders = db.get_orders()
        for order in existing_orders:
            if order["customer_name"] == customer["customer_name"]:
                existing_order_id = order["order_id"]
                
        if existing_order_id:
            order_id = existing_order_id
        else:
            import random
            order_id = random.randint(1, 100)

        for item in cart_items:
            item_details = db.get_one_item(item["item_id"])
            
            order = {
                "order_id": order_id,
                "customer_name": customer["customer_name"],
                "item_ordered": item_details["item_name"],
            }
            db.add_order(order)
        db.clear_cart()

        return redirect(url_for("render_orders"))
    else:
        return redirect(url_for("cart"))
