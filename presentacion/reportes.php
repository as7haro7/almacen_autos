<?php
// presentacion/reportes.php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once '../negocio/ReportesNegocio.php';

// Variables para almacenar los datos del reporte a mostrar
$reporteActual = null;
$reporteData = null;
$reporteTitulo = "";

if (isset($_GET['reporte'])) {
    $reporteActual = $_GET['reporte'];
    $manager = new ReportesNegocio();

    // Usamos un switch para manejar cada tipo de reporte
    switch ($reporteActual) {
        case 'inventario_valorizado':
            $reporteTitulo = "Reporte de Inventario Valorizado";
            $reporteData = $manager->generarReporteInventarioValorizado();
            break;
        
        case 'mas_vendidos':
            $reporteTitulo = "Top 10 Artículos Más Vendidos";
            $reporteData = $manager->generarReporteMasVendidos();
            break;

        case 'menos_vendidos':
            $reporteTitulo = "Top 10 Artículos Menos Vendidos";
            $reporteData = $manager->generarReporteMenosVendidos();
            break;
        
        case 'articulos_danados':
            $reporteTitulo = "Reporte de Artículos Dañados";
            $reporteData = $manager->generarReporteDanados();
            break;

        case 'historial_articulo':
            // Este reporte se activa por un formulario POST
            if (isset($_POST['id_articulo']) && !empty($_POST['id_articulo'])) {
                $id_articulo = (int)$_POST['id_articulo'];
                $reporteTitulo = "Historial de Movimientos para Artículo ID: " . $id_articulo;
                $reporteData = $manager->generarHistorialArticulo($id_articulo);
            }
            break;
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Módulo de Reportes</title>
    <style>
        body { font-family: sans-serif; margin: 2em; background-color: #f9f9f9; }
        nav { background-color: #fff; padding: 1em; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 2em; }
        nav a, nav button { margin-right: 15px; text-decoration: none; color: #007bff; font-weight: bold; }
        nav form { display: inline-block; }
        nav input { padding: 5px; }
        nav button { padding: 5px 10px; background-color: #007bff; color: white; border: none; cursor: pointer; border-radius: 4px; }
        table { width: 100%; border-collapse: collapse; margin-top: 1em; background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        h1, h2 { color: #333; }
        .total { font-size: 1.2em; font-weight: bold; margin-top: 1em; background-color: #e9ecef; padding: 10px; border-radius: 5px;}
        .container { max-width: 1200px; margin: auto; }
    </style>
</head>
<body>
<div class="container">
    <h1>Módulo de Reportes</h1>

    <nav>
        <a href="?reporte=inventario_valorizado">Inventario Valorizado</a>
        <a href="?reporte=mas_vendidos">Más Vendidos</a>
        <a href="?reporte=menos_vendidos">Menos Vendidos</a>
        <a href="?reporte=articulos_danados">Artículos Dañados</a>
        
        <form action="?reporte=historial_articulo" method="POST">
            <label for="id_articulo">Historial por Artículo ID:</label>
            <input type="number" id="id_articulo" name="id_articulo" placeholder="Ej: 1" required>
            <button type="submit">Buscar</button>
        </form>
    </nav>

    <?php if ($reporteData): ?>
        <h2><?php echo $reporteTitulo; ?></h2>
        
        <?php switch ($reporteActual):
            case 'inventario_valorizado': ?>
                <div class="total">
                    Valor Total del Inventario: <?php echo number_format($reporteData['total_general'], 2, ',', '.'); ?> Bs.
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Sucursal</th><th>Artículo</th><th>Categoría</th><th>Cantidad</th><th>Costo Unit. (Bs.)</th><th>Valor Total (Bs.)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($reporteData['detalle'] as $item): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($item['sucursal']); ?></td>
                            <td><?php echo htmlspecialchars($item['articulo']); ?></td>
                            <td><?php echo htmlspecialchars($item['nombre_categoria']); ?></td>
                            <td><?php echo $item['cantidad']; ?></td>
                            <td><?php echo number_format($item['costo_compra_promedio'], 2, ',', '.'); ?></td>
                            <td><?php echo number_format($item['valor_total_articulo'], 2, ',', '.'); ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php break; ?>

            <?php case 'mas_vendidos': ?>
            <?php case 'menos_vendidos': ?>
                <table>
                    <thead><tr><th>Descripción del Artículo</th><th>Total Vendido</th></tr></thead>
                    <tbody>
                        <?php foreach ($reporteData as $item): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($item['descripcion']); ?></td>
                            <td><?php echo $item['total_vendido']; ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php break; ?>

            <?php case 'articulos_danados': ?>
                <table>
                    <thead><tr><th>Fecha y Hora</th><th>Artículo</th><th>Cantidad Dañada</th><th>Reportado Por</th><th>Sucursal</th></tr></thead>
                    <tbody>
                        <?php foreach ($reporteData as $item): ?>
                        <tr>
                            <td><?php echo $item['fecha_hora']; ?></td>
                            <td><?php echo htmlspecialchars($item['articulo']); ?></td>
                            <td><?php echo $item['cantidad_danada']; ?></td>
                            <td><?php echo htmlspecialchars($item['reportado_por']); ?></td>
                            <td><?php echo htmlspecialchars($item['sucursal']); ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php break; ?>

            <?php case 'historial_articulo': ?>
                <table>
                    <thead><tr><th>Fecha y Hora</th><th>Tipo de Movimiento</th><th>Cantidad</th><th>Usuario</th><th>Sucursal</th></tr></thead>
                    <tbody>
                        <?php foreach ($reporteData as $item): ?>
                        <tr>
                            <td><?php echo $item['fecha_hora']; ?></td>
                            <td><?php echo htmlspecialchars($item['tipo_movimiento']); ?></td>
                            <td><?php echo $item['cantidad']; ?></td>
                            <td><?php echo htmlspecialchars($item['usuario']); ?></td>
                            <td><?php echo htmlspecialchars($item['sucursal']); ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php break; ?>

        <?php endswitch; ?>
    <?php else: ?>
        <p>Por favor, selecciona un reporte para generar.</p>
    <?php endif; ?>
</div>
</body>
</html>