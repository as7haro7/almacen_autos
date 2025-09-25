<?php
require_once '../negocio/registroPro.php';

$proveedor = new Proveedor();

if($_POST){
    if($proveedor->registrar($_POST)){
        echo "<script>alert('Se registró proveedor');</script>";
    } else {
        echo "<script>alert('Error al registrar proveedor');</script>";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Proveedores</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <h1>Registro de nuevos Proveedores</h1>
    <form method="POST" class="formulario">
        <label>Nombre del proveedor:</label>
        <input type="text" name="nombre_proveedor" required><br>

        <label>NIT:</label>
        <input type="text" name="nit" required><br>

        <label>Teléfono:</label>
        <input type="text" name="telefono"><br>

        <label>Email:</label>
        <input type="email" name="email" required><br>

        <label>Dirección:</label>
        <input type="text" name="direccion"><br>

        <label>Ciudad:</label>
        <input type="text" name="cuidad"><br>

        <label>Industria:</label>
        <input type="text" name="industria"><br>

        <label>Calificación:</label>
        <input type="text" name="calificacion"><br>

        <button type="submit">Guardar</button>
    </form>
</body>
</html>
