<?php
// presentacion/reportes.php
ini_set('display_errors', 1);
error_reporting(E_ALL);

require_once '../negocio/ReportesNegocio.php';

$manager = new ReportesNegocio();
$reporteActual = null;
$reporteData = null;
$reporteTitulo = "";

$categorias = $manager->obtenerCategoriasParaFiltro();

if (isset($_GET['reporte'])) {
    $reporteActual = $_GET['reporte'];

    switch ($reporteActual) {
        case 'dashboard':
            $reporteTitulo = "Dashboard de Resumen";
            $reporteData = $manager->generarResumenDashboard();
            break;
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
            if (isset($_POST['id_articulo']) && !empty($_POST['id_articulo'])) {
                $id_articulo = (int)$_POST['id_articulo'];
                $reporteTitulo = "Historial de Movimientos para Artículo ID: " . $id_articulo;
                $reporteData = $manager->generarHistorialArticulo($id_articulo);
            }
            break;
        case 'reporte_ventas':
            $reporteTitulo = "Reporte de Ventas";
            $reporteData = $manager->generarReporteVentas($_GET);
            break;
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Módulo de Reportes</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; margin: 0; background-color: #f8f9fa; }
        .container { max-width: 1400px; margin: auto; padding: 2em; }
        nav { background-color: #fff; padding: 1.5em; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 2em; }
        nav a { margin-right: 20px; text-decoration: none; color: #007bff; font-weight: 500; }
        nav a:hover { text-decoration: underline; }
        .form-section { border-top: 1px solid #dee2e6; margin-top: 1em; padding-top: 1em; }
        .form-section form { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }
        form label { font-weight: 500; }
        form input, form select, form button { padding: 8px 12px; border: 1px solid #ced4da; border-radius: 4px; font-size: 14px; }
        form button { background-color: #28a745; color: white; border: none; cursor: pointer; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 1.5em; background-color: #fff; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        th, td { border: 1px solid #dee2e6; padding: 12px; text-align: left; }
        th { background-color: #e9ecef; }
        h1, h2 { color: #343a40; }
        .total, .card-container { display: flex; gap: 20px; margin-top: 1.5em; }
        .total-box, .card { background-color: #e9ecef; padding: 20px; border-radius: 8px; font-size: 1.2em; font-weight: bold; flex-grow: 1; text-align: center; }
        .card h3 { margin: 0 0 10px 0; color: #495057; font-size: 16px; }
        .card p { margin: 0; color: #212529; font-size: 24px; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <h1>Módulo de Reportes</h1>
    <nav>
        <a href="?reporte=dashboard">Dashboard</a>
        <a href="?reporte=inventario_valorizado">Inventario Valorizado</a>
        <a href="?reporte=mas_vendidos">Más Vendidos</a>
        <a href="?reporte=menos_vendidos">Menos Vendidos</a>
        <a href="?reporte=articulos_danados">Artículos Dañados</a>
        
        <div class="form-section">
            <form action="?" method="GET">
                <input type="hidden" name="reporte" value="reporte_ventas">
                <label>Reporte de Ventas:</label>
                <input type="date" name="fecha_inicio" value="<?php echo htmlspecialchars($_GET['fecha_inicio'] ?? ''); ?>">
                <input type="date" name="fecha_fin" value="<?php echo htmlspecialchars($_GET['fecha_fin'] ?? ''); ?>">
                <select name="id_categoria">
                    <option value="">-- Todas las categorías --</option>
                    <?php foreach ($categorias as $cat): ?>
                        <option value="<?php echo $cat['id_categoria']; ?>" <?php echo (isset($_GET['id_categoria']) && $_GET['id_categoria'] == $cat['id_categoria']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($cat['nombre_categoria']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                <button type="submit">Generar</button>
            </form>
        </div>
        <div class="form-section">
            <form action="?reporte=historial_articulo" method="POST">
                <label>Historial por Artículo ID:</label>
                <input type="number" name="id_articulo" placeholder="Ej: 1" required>
                <button type="submit">Buscar</button>
            </form>
        </div>
    </nav>

    <?php if ($reporteData): ?>
        <h2><?php echo $reporteTitulo; ?></h2>
        
        <?php switch ($reporteActual):
            case 'dashboard': ?>
                <div class="card-container">
                    <div class="card"><h3>Valor Total Inventario</h3> <p><?php echo number_format($reporteData['valor_total_inventario'], 2, ',', '.'); ?> Bs.</p></div>
                    <div class="card"><h3>Total Unidades en Stock</h3> <p><?php echo number_format($reporteData['total_stock'], 0, ',', '.'); ?></p></div>
                    <div class="card"><h3>Tipos de Artículos Únicos</h3> <p><?php echo number_format($reporteData['articulos_unicos'], 0, ',', '.'); ?></p></div>
                </div>
            <?php break; ?>

            <?php case 'inventario_valorizado': ?>
                <div class="total-box">Valor Total del Inventario: <?php echo number_format($reporteData['total_general'], 2, ',', '.'); ?> Bs.</div>
                <table></table>
            <?php break; ?>
            
            <?php case 'reporte_ventas': ?>
                <div class="total-box">Monto Total de Ventas (filtrado): <?php echo number_format($reporteData['total_ventas'], 2, ',', '.'); ?> Bs.</div>
                <table>
                    <thead><tr><th>Fecha Pedido</th><th>Cliente</th><th>Artículo</th><th>Categoría</th><th>Cantidad</th><th>Precio Unit.</th><th>Subtotal</th></tr></thead>
                    <tbody>
                        <?php foreach ($reporteData['detalle'] as $item): ?>
                        <tr>
                            <td><?php echo $item['fecha_pedido']; ?></td>
                            <td><?php echo htmlspecialchars($item['cliente']); ?></td>
                            <td><?php echo htmlspecialchars($item['articulo']); ?></td>
                            <td><?php echo htmlspecialchars($item['nombre_categoria']); ?></td>
                            <td><?php echo $item['cantidad']; ?></td>
                            <td><?php echo number_format($item['precio_unitario'], 2, ',', '.'); ?></td>
                            <td><?php echo number_format($item['subtotal'], 2, ',', '.'); ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php break; ?>

            <?php // ... ?>

        <?php endswitch; ?>
    <?php elseif ($reporteActual): ?>
        <p>No se encontraron resultados para el reporte "<?php echo htmlspecialchars($reporteTitulo); ?>".</p>
    <?php else: ?>
        <p>Por favor, selecciona un reporte para generar.</p>
    <?php endif; ?>
</div>
</body>
</html>
