<?php
require_once '../negocio/OrdenCompraService.php';


$service = new OrdenCompraService();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_proveedor = $_POST['id_proveedor'];
    $id_usuario = $_POST['id_usuario'];
    $fecha_emision = $_POST['fecha_emision'];
    $monto_total = $_POST['monto_total'];

    $service->crearOrdenCompra($id_proveedor, $id_usuario, $fecha_emision, $monto_total);
    echo "Orden de compra registrada.";
}

$ordenes = $service->listarOrdenes();
?>

<form method="POST">
    Proveedor ID: <input type="number" name="id_proveedor" required><br>
    Usuario ID: <input type="number" name="id_usuario" required><br>
    Fecha Emisión: <input type="date" name="fecha_emision" required><br>
    Monto Total: <input type="number" step="0.01" name="monto_total" required><br>
    <button type="submit">Registrar Orden de Compra</button>
</form>

<h2>Órdenes de Compra</h2>
<ul>
    <?php foreach ($ordenes as $orden) : ?>
        <li>ID: <?= $orden['id_orden_compra']; ?> - Proveedor: <?= $orden['id_proveedor']; ?> - Usuario: <?= $orden['id_usuario']; ?> - Fecha: <?= $orden['fecha_emision']; ?> - Monto: <?= $orden['monto_total']; ?> - Estado: <?= $orden['estado']; ?></li>
    <?php endforeach; ?>
</ul>