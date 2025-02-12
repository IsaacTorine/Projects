--Query 1
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.inventory_ID) AS total_orders
FROM 
    customer c
JOIN 
    Receives r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id;
    
--Query 2
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS supplier_name,
    GROUP_CONCAT(i.model ORDER BY i.model ASC) AS items_supplied
FROM 
    supplier s
JOIN 
    `From` f ON s.supplier_id = f.supplier_ID
JOIN 
    item i ON f.item_ID = i.item_id
GROUP BY 
    s.supplier_id;

--Query 3
SELECT 
    i.model AS item_model,
    SUM(iv.price * iv.quantity) AS total_revenue
FROM 
    item i
JOIN 
    inventory iv ON i.item_id = iv.item_id
GROUP BY 
    i.item_id;

--Query 4
SELECT 
    i.model AS item_model,
    COUNT(r.inventory_ID) AS times_ordered
FROM 
    item i
JOIN 
    Receives r ON i.item_id = r.item_ID
GROUP BY 
    i.item_id
ORDER BY 
    times_ordered DESC;

--Query 5
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    SUM(id.labor_cost) AS total_labor_cost
FROM 
    employee e
JOIN 
    item_details id ON e.employee_id = id.employee_id
GROUP BY 
    e.employee_id;
