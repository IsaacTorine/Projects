<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Item Revenue</title>
    <link rel="stylesheet" href="https://cgi.luddy.indiana.edu/~dpierz/i308.css">
</head>
<body>

<?php
$con = mysqli_connect("db.luddy.indiana.edu", "i308f24_istorine", "mambo8863hamal", "i308f24_istorine");
if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}


if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['item_model'])) {
    $selected_model = mysqli_real_escape_string($con, $_POST['item_model']);

    
    $query = "
        SELECT i.model AS item_model, SUM(iv.price * iv.quantity) AS total_revenue
        FROM item i
        JOIN inventory iv ON i.item_id = iv.item_id
        WHERE i.model = '$selected_model'
        GROUP BY i.item_id
    ";

    $result = mysqli_query($con, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        echo "<h2>Total Revenue for: $selected_model</h2>";
        echo "<table border='1'><tr><th>Item Model</th><th>Total Revenue</th></tr>";

        while ($row = mysqli_fetch_assoc($result)) {
            echo "<tr><td>{$row['item_model']}</td><td>{$row['total_revenue']}</td></tr>";
        }

        echo "</table>";
    } else {
        echo "<p>No revenue data found for the selected item model: $selected_model</p>";
    }
} else {
    echo "<p>No item model selected. Please go back and choose an item.</p>";
}


mysqli_close($con);
?>

</body>
</html>
