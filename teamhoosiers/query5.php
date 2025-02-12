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

$selected_employee = $_POST['form-role'];

list($first_name, $last_name) = explode(' ', $selected_employee, 2);

$sql="SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
            SUM(id.labor_cost) AS total_labor_cost
FROM 
    employee e
JOIN 
    item_details id ON e.employee_id = id.employee_id
WHERE
    e.first_name = '$first_name' AND e.last_name = '$last_name'
GROUP BY 
    e.employee_id";


$result = mysqli_query($con, $sql);
if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

echo "<h2>Total Labor Cost Per Employee</h2>";
echo "<table border='1'><tr><th>Employee Name</th><th>Total Labor Cost </th></tr>";
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr><td>{$row['employee_name']}</td><td>{$row['total_labor_cost']}</td></tr>";
    }
} else {
    echo "No Labor found for this employee.";
}
echo "</table>";

mysqli_close($con);
?>

</body>
</html>