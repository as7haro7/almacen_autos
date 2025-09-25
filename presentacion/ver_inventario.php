<?php
require_once '../negocio/obtInventario.php';
$mdd = new obtInventario();
$cat = $_POST['categoria'] ?? '';

if (!empty($cat)) {
    $inventario = $mdd->listarInventarioPorCategoria($cat);
    if (empty($inventario)) {
        $inventario = $mdd->listarInventario();
    }
} else {
    $inventario = $mdd->listarInventario();
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        table {
            border-collapse: collapse;
        }

        th {
            border: 5px solid black;
            padding: 10px 30px;
        }

        td {
            border: 5px solid black;
            padding: 5px 10px;
        }
    </style>
    <title>Document</title>
</head>

<body>
    <form method="POST">
        <input type="text" name="categoria">
        <input type="submit">
    </form>
    <table>
        <tr>
            <th>codigo articulo</th>
            <th>categoria</th>
            <th>descripcion</th>
            <th>QR</th>
            <th>precio venta</th>
            <th>precio compra</th>
            <th>stock</th>
            <th>ubicacion exacta</th>
            <th>sucursal</th>
        </tr>
        <?php foreach ($inventario as $row): ?>
            <tr>
                <td><?= $row['codigo_articulo'] ?></td>
                <td><?= $row['nombre_categoria'] ?></td>
                <td><?= $row['descripcion'] ?></td>
                <td><img src="https://api.qrserver.com/v1/create-qr-code/?size=75x75&data=<?= urlencode(($row['codigo_barras_qr'])) ?>" alt="imagen qr">
                </td>
                <td><?= $row['precio_venta'] ?></td>
                <td><?= $row['costo_compra_promedio'] ?></td>
                <td style="background-color: 
                    <?= ($row['cantidad'] <= 3 ? 'red' : ($row['cantidad'] <= 6 ? 'orange' : 'green')) ?>;">
                    <?= $row['cantidad'] ?>
                </td>
                <td><?= $row['ubicacion_exacta'] ?></td>
                <td><?= $row['nombre'] ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>

</html>