 <?php
require "../negocio/gestionProveedores.php";

$proveedorNegocio = new ProveedorNegocio();
$resultados = [];

if ($_POST) {
    $industria = $_POST['select'];
    $resultados = $proveedorNegocio->filtrarPorIndustria($industria);
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

        <h2>Filtrar Proveedores</h2>
         <form method="POST">
        <select name="select" id="">
            <option value="AutoPartes">AutoPartes</option>
            <option value="Repuestos">Repuestos</option>
            <option value="Importación">Importación</option>
            <option value="Neumáticos">Neumáticos</option>
            <option value="Servicios">Servicios</option>
            <option value="parabrisas">Parabrisas</option>
       
        </select>
        <button type="submit">buscar</button>

    </form>
    <main class="welcome-container-tabla">

    </main>
    <h3>Resultados:</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>NIT</th>
            <th>Teléfono</th>
            <th>Email</th>
            <th>Dirección</th>
            <th>Ciudad</th>
            <th>Industria</th>
            <th>Calificación</th>
        </tr>
        <?php if (!empty($resultados)): ?>
            <?php foreach ($resultados as $fila): ?>
                <tr>
                    <td><?= $fila['id_proveedor'] ?></td>
                    <td><?= $fila['nombre_proveedor'] ?></td>
                    <td><?= $fila['nit'] ?></td>
                    <td><?= $fila['telefono'] ?></td>
                    <td><?= $fila['email'] ?></td>
                    <td><?= $fila['direccion'] ?></td>
                    <td><?= $fila['ciudad'] ?></td>
                    <td><?= $fila['industria'] ?></td>
                    <td><?= $fila['calificacion'] ?></td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr><td colspan="9">No se encontraron proveedores</td></tr>
        <?php endif; ?>
    </table>

</body>
</html>