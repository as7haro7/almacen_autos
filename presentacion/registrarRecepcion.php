<?php
require_once __DIR__ . '/../negocio/OrdenCompraDetalleNegocio.php';

$negocio = new OrdenCompraDetalleNegocio();
$mensaje = "";
$detalle = null;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $idDetalle = $_POST["id_detalle"];
    $cantidadRecibida = $_POST["cantidad_recibida"];

    $mensaje = $negocio->registrarRecepcion($idDetalle, $cantidadRecibida);
    $detalle = $negocio->obtenerDetalleConArticulo($idDetalle);
}

// Listado general
$listado = $negocio->listarDetallesConArticulos();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Recepción de Mercancía</title>
</head>
<body>
    <h2>Registrar Recepción de Mercancía</h2>
    
    <form method="post">
        <label>ID Detalle Orden: </label>
        <input type="number" name="id_detalle" required><br><br>

        <label>Cantidad Recibida: </label>
        <input type="number" name="cantidad_recibida" required><br><br>

        <button type="submit">Registrar</button>
    </form>

    <?php if (!empty($mensaje)): ?>
        <p><strong><?php echo $mensaje; ?></strong></p>
    <?php endif; ?>

    <?php if ($detalle): ?>
        <h3>Detalle registrado:</h3>
        <p>Artículo: <?php echo $detalle["articulo"]; ?></p>
        <p>Cantidad total: <?php echo $detalle["cantidad"]; ?></p>
        <p>Costo unitario: <?php echo $detalle["costo_unitario"]; ?></p>
    <?php endif; ?>

    <h2>Listado de Órdenes de Compra Detalle</h2>
    <table  cellpadding="5">
        <tr>
            <th>ID Detalle</th>
            <th>ID Orden</th>
            <th>Artículo</th>
            <th>Cantidad</th>
            <th>Costo Unitario</th>
        </tr>
        <?php foreach ($listado as $fila): ?>
        <tr>
            <td><?php echo $fila["id_detalle"]; ?></td>
            <td><?php echo $fila["id_orden_compra"]; ?></td>
            <td><?php echo $fila["articulo"]; ?></td>
            <td><?php echo $fila["cantidad"]; ?></td>
            <td><?php echo $fila["costo_unitario"]; ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
