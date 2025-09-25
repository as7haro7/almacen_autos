<?php
require_once __DIR__ . '/../negocio/FacturaProveedorNegocio.php';

$negocio = new FacturaProveedorNegocio();
$mensaje = "";

// Registrar factura
if (isset($_POST["registrar"])) {
    $idOrden = $_POST["id_orden_compra"];
    $numFactura = $_POST["numero_factura"];
    $codAut = $_POST["codigo_autorizacion"];
    $codCtrl = $_POST["codigo_control"];
    $fecha = $_POST["fecha_emision"];
    $monto = $_POST["monto_total"];
    $mensaje = $negocio->registrarFactura($idOrden, $numFactura, $codAut, $codCtrl, $fecha, $monto);
}

// Marcar como pagada
if (isset($_POST["pagar"])) {
    $idFactura = $_POST["id_factura"];
    $negocio->pagarFactura($idFactura);
}

$listado = $negocio->listarFacturas();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Facturación de Proveedores</title>
</head>
<body>
    <h2>Registrar Factura de Proveedor</h2>
    <form method="post">
        <label>ID Orden Compra:</label>
        <input type="number" name="id_orden_compra" required><br><br>

        <label>Número Factura:</label>
        <input type="text" name="numero_factura" required><br><br>

        <label>Código Autorización:</label>
        <input type="text" name="codigo_autorizacion"><br><br>

        <label>Código Control:</label>
        <input type="text" name="codigo_control"><br><br>

        <label>Fecha Emisión:</label>
        <input type="date" name="fecha_emision" required><br><br>

        <label>Monto Total:</label>
        <input type="number" step="0.01" name="monto_total" required><br><br>

        <button type="submit" name="registrar">Registrar Factura</button>
    </form>

    <?php if ($mensaje): ?>
        <p><strong><?php echo $mensaje; ?></strong></p>
    <?php endif; ?>

    <h2>Listado de Facturas de Proveedores</h2>
    <table  cellpadding="5">
        <tr>
            <th>ID Factura</th>
            <th>ID Orden</th>
            <th>Número</th>
            <th>Código Autorización</th>
            <th>Código Control</th>
            <th>Fecha</th>
            <th>Monto</th>
            <th>Estado</th>
            <th>Acción</th>
        </tr>
        <?php foreach ($listado as $f): ?>
        <tr>
            <td><?php echo $f["id_factura_proveedor"]; ?></td>
            <td><?php echo $f["id_orden_compra"]; ?></td>
            <td><?php echo $f["numero_factura"]; ?></td>
            <td><?php echo $f["codigo_autorizacion"]; ?></td>
            <td><?php echo $f["codigo_control"]; ?></td>
            <td><?php echo $f["fecha_emision"]; ?></td>
            <td><?php echo $f["monto_total"]; ?></td>
            <td><?php echo $f["estado_pago"]; ?></td>
            <td>
                <?php if ($f["estado_pago"] == "pendiente"): ?>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id_factura" value="<?php echo $f["id_factura_proveedor"]; ?>">
                    <button type="submit" name="pagar">Marcar Pagada</button>
                </form>
                <?php else: ?>
                Pagada
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
