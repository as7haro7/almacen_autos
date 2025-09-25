<?php
require_once '../negocio/gestionProveedores.php';

$resultados = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $industria = $_POST['select'];
    $resultados = ProveedorNegocio::filtrarPorIndustria($industria);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Filtrar Proveedores</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            text-align: center;
        }
        th, td {
            border: 1px solid #444;
            padding: 10px;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        h2, h3 {
            text-align: center;
        }
    </style>
</head>
<body>

    <h2>Filtrar Proveedores</h2>
    <form method="POST" style="text-align:center;">
        <select name="select">
            <option value="AutoPartes">AutoPartes</option>
            <option value="Repuestos">Repuestos</option>
            <option value="Importación">Importación</option>
            <option value="Neumáticos">Neumáticos</option>
            <option value="Servicios">Servicios</option>
            <option value="Parabrisas">Parabrisas</option>
        </select>
        <button type="submit">Buscar</button>
    </form>

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
        <?php foreach ($resultados as $row): ?>
        <tr>
            <td><?= $row['id_proveedor'] ?></td>
            <td><?= $row['nombre_proveedor'] ?></td>
            <td><?= $row['nit'] ?></td>
            <td><?= $row['telefono'] ?></td>
            <td><?= $row['email'] ?></td>
            <td><?= $row['direccion'] ?></td>
            <td><?= $row['ciudad'] ?></td>
            <td><?= $row['industria'] ?></td>
            <td><?= $row['calificacion'] ?></td>
        </tr>
        <?php endforeach; ?>
    </table>

</body>
</html>
