<?php

if($_POST)
    $nom = $_POST['nombre'];
    $pat = $_POST['telefono'];
    $mat = $_POST['email'];
    $tel = $_POST['direccion'];
    $cui = $_POST['cuidad'];
    $pais = $_POST['pais'];
    $tipoPro = $_POST['tipoProvedor'];

    $con = "INSERT INTO vendedores (nombre, paterno, materno, telefono) VALUES ('$nom', '$pat', '$mat', '$tel')";

    $res = mysqli_query($db, $con);

    if ($res) {
        echo "<script> alert('Se registró vendedor'); </script>";
    } else {
        echo "<script> alert('No see registró vendedor'); </script>";
    }
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenido al Sistema de Almacén</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <header class="main-header">
    </header>
        <h1>Registro de nuevos Provedores</h1>
    <main class="welcome-container">
       <form method="POST" class="formulario">
        <label for="">Nombre:</label>
        <input type="text" name="nombre" required><br>
        
        <label for="">Teléfono:</label>
        <input type="text" name="telefono"><br>
        
        <label for=""> Email:</label>
        <input type="email" name="email" required><br>
        
        <label for="">Dirección: </label>
        <input type="text" name="direccion"><br>
        
        <label for="">Ciudad:</label>
        <input type="text" name="ciudad"><br>
        
        <label for="">País:</label>
        <input type="text" name="pais"><br>
        
        <label for="">Tipo de Provedor</label>
        <input type="text" name = "tipoProvedor">
        
        <button type="submit">Guardar</button>
    </form>
    </main>

    <footer class="main-footer">
        <p>&copy; <?php echo date("Y"); ?> AlmacenAutos</p>
    </footer>

</body>
</html>