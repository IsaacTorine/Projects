<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Database Query Interface</title>
    <link rel="stylesheet" href="https://cgi.luddy.indiana.edu/~dpierz/i308.css">
</head>
<body>
    <h2><b>Welcome to Our Database!</b></h2>

  <!-- Query 1 -->
    <?php
    echo "<form action=\"query1.php\"  method=\"post\">";
    echo    "<h3>Select a Customer</h3>";
    echo    "Customer Name:";
    echo    "<select name=\"form-role\">";
  
    $con = mysqli_connect("db.luddy.indiana.edu","i308f24_istorine","mambo8863hamal", "i308f24_istorine");
    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    
    $sql = "SELECT first_name, last_name FROM customer ORDER BY first_name";
    $result = mysqli_query($con, $sql);

    
    if (mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            $customer_name = $row['first_name'] . " " . $row['last_name'];
            echo "<option value='$customer_name'>$customer_name</option>";
        }
    } else {
        echo "<option value=''>No customers available</option>";
    }

    
    mysqli_close($con);
    echo "</select>";
    echo "<br><br>";
    echo "<button type=\"submit\">Submit</button>";
    echo "</form>";

    ?>

    <!-- Query 2 -->
    <?php
    echo "<form action=\"query2.php\"  method=\"post\">";
    echo    "<h3>Select a Supplier</h3>";
    echo    "Supplier Name:";
    echo    "<select name=\"form-role\">";
    
    $con = mysqli_connect("db.luddy.indiana.edu","i308f24_istorine","mambo8863hamal", "i308f24_istorine");
    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    
    $sql = "SELECT first_name, last_name FROM supplier ORDER BY first_name";
    $result = mysqli_query($con, $sql);

    // Check if the query returned results
    if (mysqli_num_rows($result) > 0) {
        // Populate the dropdown with customer names
        while ($row = mysqli_fetch_assoc($result)) {
            $supplier_name = $row['first_name'] . " " . $row['last_name'];
            echo "<option value='$supplier_name'>$supplier_name</option>";
        }
    } else {
        echo "<option value=''>No suppliers available</option>";
    }

    
    mysqli_close($con);
    echo "</select>";
    echo "<br><br>";
    echo "<button type=\"submit\">Submit</button>";
    echo "</form>";

    ?>

    <!-- Query 3  -->
<form action="query3.php" method="POST">
  <h3>Select the item model:</h3>
  <div style="display: flex; gap: 15px; flex-wrap: wrap;">
    <label>
      <input type="radio" name="item_model" value="O2 XDA Flame"> O2 XDA Flame
    </label>
    <label>
      <input type="radio" name="item_model" value="Micromax Bolt D303"> Micromax Bolt D303
    </label>
    <label>
      <input type="radio" name="item_model" value="Micromax A115 Canvas 3D"> Micromax A115 Canvas 3D
    </label>
    <label>
      <input type="radio" name="item_model" value="Panasonic GD70"> Panasonic GD70
    </label>
    <label>
      <input type="radio" name="item_model" value="Bird S1186"> Bird S1186
    </label>
    <label>
      <input type="radio" name="item_model" value="Sony Xperia Tablet S 3G"> Sony Xperia Tablet S 3G
    </label>
    <label>
      <input type="radio" name="item_model" value="vivo Y9s"> vivo Y9s
    </label>
    <label>
      <input type="radio" name="item_model" value="Micromax Bolt A51"> Micromax Bolt A51
    </label>
    <label>
      <input type="radio" name="item_model" value="BLU Studio X Mini"> BLU Studio X Mini
    </label>
    <label>
      <input type="radio" name="item_model" value="Panasonic Eluga Ray 700"> Panasonic Eluga Ray 700
    </label>
  </div>
  <button type="submit">View Total Revenue by Item</button>
</form>

    
 <!-- Query 4 -->
<form action="query4.php" method="POST">
  <h3>Select the item model:</h3>
  <div style="display: flex; gap: 15px; flex-wrap: wrap;">
    <label>
      <input type="radio" name="item_model" value="O2 XDA Flame"> O2 XDA Flame
    </label>
    <label>
      <input type="radio" name="item_model" value="Micromax Bolt D303"> Micromax Bolt D303
    </label>
    <label>
      <input type="radio" name="item_model" value="Micromax A115 Canvas 3D"> Micromax A115 Canvas 3D
    </label>
    <label>
      <input type="radio" name="item_model" value="Panasonic GD70"> Panasonic GD70
    </label>
    <label>
      <input type="radio" name="item_model" value="Bird S1186"> Bird S1186
    </label>
    <label>
      <input type="radio" name="item_model" value="Sony Xperia Tablet S 3G"> Sony Xperia Tablet S 3G
    </label>
    <label>
      <input type="radio" name="item_model" value="vivo Y9s"> vivo Y9s
    </label>
    <label>
      <input type="radio" name="item_model" value="Micromax Bolt A51"> Micromax Bolt A51
    </label>
    <label>
      <input type="radio" name="item_model" value="BLU Studio X Mini"> BLU Studio X Mini
    </label>
    <label>
      <input type="radio" name="item_model" value="Panasonic Eluga Ray 700"> Panasonic Eluga Ray 700
    </label>
  </div>
  <button type="submit">View Order Frequency by Item</button>
</form>


    <!-- Query 5 -->
    <?php
    echo "<form action=\"query5.php\"  method=\"post\">";
    echo    "<h3>Select an Employee</h3>";
    echo    "Employee Name:";
    echo    "<select name=\"form-role\">";
    
    $con = mysqli_connect("db.luddy.indiana.edu","i308f24_istorine","mambo8863hamal", "i308f24_istorine");
    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    
    $sql = "SELECT first_name, last_name FROM employee ORDER BY first_name";
    $result = mysqli_query($con, $sql);

  
    if (mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            $employee_name = $row['first_name'] . " " . $row['last_name'];
            echo "<option value='$employee_name'>$employee_name</option>";
        }
    } else {
        echo "<option value=''>No employees available</option>";
    }

    
    mysqli_close($con);
    echo "</select>";
    echo "<br><br>";
    echo "<button type=\"submit\">Submit</button>";
    echo "</form>";

    ?>

</body>
</html>

