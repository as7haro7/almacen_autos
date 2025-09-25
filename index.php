<?php
// Inicia la sesión para poder verificar si el usuario ya está logueado
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Si ya existe una sesión de usuario, redirige directamente al inventario
if (isset($_SESSION['usuario_id'])) {
    header('Location: presentacion/ver_inventario.php');
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenido al Sistema de Almacén</title>
    <link rel="stylesheet" href="presentacion/css/estilos.css">
</head>
<body>

    <header class="main-header">
        <nav>
            <a href="presentacion/ver_inventario.php" class="login-button">Iniciar Sesión</a>
        </nav>
    </header>

    <main class="welcome-container">
        <div class="welcome-box">
            <h1>Sistema de Gestión de Almacén de Vehículos</h1>
            <p>Administre y controle el inventario de vehículos de forma eficiente y segura.</p>
            <div class = "separcion">
            <a href="presentacion/moduloProvedores.php" style="text-decoration: none;">proveedores</a><br>
            <a href="presentacion/ver_inventario.php" style="text-decoration: none;">Inventario</a><br>
            <a href="presentacion/moduloCompra.php" style="text-decoration: none;">compra</a><br>
            <a href="presentacion/reportes.php" style="text-decoration: none;">reportes</a><br>
            </div>

        </div>
    </main>

    <footer class="main-footer">
        <p>&copy; <?php echo date("Y"); ?> AlmacenAutos</p>
    </footer>

</body>
</html>