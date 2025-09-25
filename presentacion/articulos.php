<?php
require_once __DIR__ . '/../negocio/ArticuloNegocio.php';

$negocio = new ArticuloNegocio();
$mensaje = "";

// Registrar artículo
if (isset($_POST["registrar"])) {
    $mensaje = $negocio->registrarArticulo(
        $_POST["id_categoria"],
        $_POST["codigo_articulo"],
        $_POST["descripcion"],
        $_POST["codigo_barras_qr"],
        $_POST["precio_venta"],
        $_POST["costo_compra_promedio"]
    );
}

// Actualizar artículo
if (isset($_POST["actualizar"])) {
    $negocio->actualizarArticulo(
        $_POST["id_articulo"],
        $_POST["id_categoria"],
        $_POST["codigo_articulo"],
        $_POST["descripcion"],
        $_POST["codigo_barras_qr"],
        $_POST["precio_venta"],
        $_POST["costo_compra_promedio"]
    );
}

// Eliminar artículo
if (isset($_POST["eliminar"])) {
    $negocio->eliminarArticulo($_POST["id_articulo"]);
}

$listado = $negocio->listarArticulos();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Artículos</title>
</head>
<body>
    <h2>Registrar Artículo</h2>
    <form method="post">
        <label>ID Categoría:</label>
        <input type="number" name="id_categoria" required><br><br>

        <label>Código Artículo:</label>
        <input type="text" name="codigo_articulo" required><br><br>

        <label>Descripción:</label>
        <input type="text" name="descripcion" required><br><br>

        <label>Código Barras/QR:</label>
        <input type="text" name="codigo_barras_qr"><br><br>

        <label>Precio Venta:</label>
        <input type="number" step="0.01" name="precio_venta" required><br><br>

        <label>Costo Compra Promedio:</label>
        <input type="number" step="0.01" name="costo_compra_promedio" required><br><br>

        <button type="submit" name="registrar">Registrar</button>
    </form>

    <?php if ($mensaje): ?>
        <p><strong><?php echo $mensaje; ?></strong></p>
    <?php endif; ?>

    <h2>Listado de Artículos</h2>
    <table  cellpadding="5">
        <tr>
            <th>Categoría</th>
            <th>Código</th>
            <th>Descripción</th>
            <th>Barras/QR</th>
            <th>Precio Venta</th>
            <th>Costo Promedio</th>
            <th>Acciones</th>
        </tr>
        <?php foreach ($listado as $a): ?>
        <tr>
            <form method="post">
                <td><input type="number" name="id_categoria" value="<?php echo $a["id_categoria"]; ?>"></td>
                <td><input type="text" name="codigo_articulo" value="<?php echo $a["codigo_articulo"]; ?>"></td>
                <td><input type="text" name="descripcion" value="<?php echo $a["descripcion"]; ?>"></td>
                <td><input type="text" name="codigo_barras_qr" value="<?php echo $a["codigo_barras_qr"]; ?>"></td>
                <td><input type="number" step="0.01" name="precio_venta" value="<?php echo $a["precio_venta"]; ?>"></td>
                <td><input type="number" step="0.01" name="costo_compra_promedio" value="<?php echo $a["costo_compra_promedio"]; ?>"></td>
                <td>
                    <button type="submit" name="actualizar">Actualizar</button>
                    <button type="submit" name="eliminar" onclick="return confirm('¿Eliminar artículo?')">Eliminar</button>
                </td>
            </form>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
