 


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

        <h2>Filtrar Proveedores</h2>
        <h3>Resultados:</h3>
    <main class="welcome-container-tabla">
        <table cellpadding="5" class="tr">
            <tr >
                <th>Nombre</th>
                <th>Teléfono</th>
                <th>Email</th>
                <th>Dirección</th>
                <th>Ciudad</th>
                <th>País</th>
                <th>Industria</th>
            </tr>
            <tr>
                <td><?php /*echo $row["nombre"]; */?></td>
                <td><?php /*echo $row["telefono"]; */?></td>
                <td><?php /*echo $row["email"]; */?></td>
                <td><?php /*echo $row["direccion"]; */?></td>
                <td><?php /*echo $row["ciudad"]; */?></td>
                <td><?php /*echo $row["pais"];*/ ?></td>
                <td><?php /*echo $row["industria"]; */?></td>
            </tr>
        </table>
        
    </main>

    <footer class="main-footer">
        <p>&copy; <?php echo date("Y"); ?> AlmacenAutos</p>
    </footer>

</body>
</html>