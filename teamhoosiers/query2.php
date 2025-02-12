<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Supplier Items</title>
    <link rel="stylesheet" href="https://cgi.luddy.indiana.edu/~dpierz/i308.css">
</head>
<body>

<?php



$con = mysqli_connect("db.luddy.indiana.edu", "i308f24_istorine", "mambo8863hamal", "i308f24_istorine");
if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}


$selected_supplier = $_POST['form-role'];
echo "Selected supplier: " . $selected_supplier . "<br>"; 


list($first_name, $last_name) = explode(' ', $selected_supplier, 2);


$sql = "SELECT CONCAT(s.first_name, ' ', s.last_name) AS supplier_name,
               GROUP_CONCAT(i.model ORDER BY i.model ASC) AS items_supplied
        FROM supplier s
        JOIN `From` f ON s.supplier_id = f.supplier_ID
        JOIN item i ON f.item_ID = i.item_id
        WHERE s.first_name = '$first_name' AND s.last_name = '$last_name'
        GROUP BY s.supplier_id";

$result = mysqli_query($con, $sql);
if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

echo "<h2>Items Supplied By Supplier</h2>";
echo "<table border='1'><tr><th>Supplier Name</th><th>Item Supplied</th></tr>";
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr><td>{$row['supplier_name']}</td><td>{$row['items_supplied']}</td></tr>";
    }
} else {
    echo "No items found for this supplier.";
}
echo "</table>";

mysqli_close($con);
?>

</body>
</html>

       
