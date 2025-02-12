<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Customer Orders</title>
    <link rel="stylesheet" href="https://cgi.luddy.indiana.edu/~dpierz/i308.css">
</head>
<body>

<?php

$con = mysqli_connect("db.luddy.indiana.edu","i308f24_istorine","mambo8863hamal", "i308f24_istorine");
if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}


$selected_customer = $_POST['form-role'];

list($first_name, $last_name) = explode(' ', $selected_customer, 2);


$sql = "SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(r.inventory_ID) AS total_orders  
        FROM customer c
        JOIN Receives r ON c.customer_id = r.customer_id
        WHERE c.first_name = '$first_name' AND c.last_name = '$last_name'
        GROUP BY c.customer_id";


$result = mysqli_query($con, $sql);
if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

echo "<h2>Items Supplied By Supplier</h2>";
echo "<table border='1'><tr><th>Supplier Name</th><th>Item Supplied</th></tr>";
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr><td>{$row['customer _name']}</td><td>{$row['total_orders']}</td></tr>";
    }
} else {
    echo "No orders found for this customer.";
}
echo "</table>";

// Close the database connection
mysqli_close($con);
?>

</body>
</html>