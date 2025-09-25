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

    <main class="welcome-container">
        <div class="welcome-box">
            <h1>Sistema de Gestión de Almacén de Vehículos</h1>
            <h1>Modulo Provedores</h1>
            <div class = "separcion">
            <a href="registroPro.php" style="text-decoration: none;">registrar nuevos proveedores</a><br>
            <a href="listarPro.php" style="text-decoration: none;">Lista de proveedores</a><br>
            <a href="facturasProveedor.php" style="text-decoration: none;">facturacion de provedores</a><br>
            </div>
            
        </div>
    </main>

    <footer class="main-footer">
        <p>&copy; <?php echo date("Y"); ?> AlmacenAutos</p>
    </footer>

</body>
</html>