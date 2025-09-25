<?php
require "../negocio/resgitroPro.php";
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

        <label for="">Nombre del proveedor:</label>
        <input type="text" name="nombre_proveedor" required><br>
        
        <label for="">nit:</label>
        <input type="text" name="nit" id="nit" required><br>

           <label for="">telefono: </label>
        <input type="text" name="telefono"><br>
        
        <label for=""> Email:</label>
        <input type="email" name="email" required><br>
        
        <label for="">Dirección: </label>
        <input type="text" name="direccion"><br>
        
        <label for="">Ciudad:</label>
        <input type="text" name="cuidad"><br>
        
        <label for="">industria</label>
        <input type="text" name="industria"><br>
        
        <label for="">calificacion</label>
        <input type="text" name = "calificacion">
        
        <button type="submit">Guardar</button>
    </form>
    </main>

    <footer class="main-footer">
        <p>&copy; <?php echo date("Y"); ?> AlmacenAutos</p>
    </footer>

</body>
</html>