<?php
require_once '../negocio/obtInventario.php';
$mdd = new obtInventario();
$cat = $_POST['categoria'] ?? '';
$categorias = $mdd->listarCategorias();

if (!empty($cat) && isset($_POST['filtrar'])) {
    $inventario = $mdd->listarInventarioPorCategoria($cat);
    if (empty($inventario)) {
        $inventario = $mdd->listarInventario();
    }
} else {
    $inventario = $mdd->listarInventario();
}

if (isset($_POST['subir'])) {
    $catNombre = $_POST['categoria'];
    $codigo_articulo = $_POST['cod'];
    $descripcion = $_POST['desc'];
    $venta = $_POST['venta'];
    $compra = $_POST['compra'];
    $res=$mdd->crearArticulo($catNombre, $codigo_articulo, $descripcion, $venta, $compra);
    if ($res===true) {
        echo'articulo creado';
    }elseif ($res===false){
        echo'articulo NO creado';
    }else{
        echo'advertencia $res';
    }
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
        <label>Subir Articulo</label>
        <label>codigo articulo</label>
        <input type="text" name='cod'><br>
        <label>descripcion</label>
        <input type="text" name='desc'><br>
        <label>precio venta</label>
        <input type="text" name='venta'><br>
        <label>precio compra</label>
        <input type="text" name='compra'><br>
        <label>categoria (debe ingresar una categoria valida)</label>
        <input type="text" name='categoria'><br>
        <label>Ej:. (
            <?php foreach ($categorias as $row): ?>
                <a><?= $row['nombre_categoria'] ?>, </a>
                <?php endforeach; ?>)
        </label><br>
        <input type="submit" name='subir'>
    </form>
    <br>
    <form method="POST">
        <label>Filtrar por cateogria: </label>
        <input type="text" name="categoria">
        <input type="submit" name='filtrar'>
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
                <td><img src="https://api.qrserver.com/v1/create-qr-code/?size=75x75&data=<?= urlencode(($row['codigo_articulo'])) ?>" alt="imagen qr">
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