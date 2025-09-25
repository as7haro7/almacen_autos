<?php

require_once 'conexion.php';

class ReportesDatos {
    private $pdo;

    public function __construct() {
        $this->pdo = Conexion::conectar();
    }

    public function obtenerInventarioValorizado() {
        $sql = "
            SELECT
                s.nombre AS sucursal,
                c.nombre_categoria,
                a.descripcion AS articulo,
                i.cantidad,
                a.costo_compra_promedio,
                (i.cantidad * a.costo_compra_promedio) AS valor_total_articulo
            FROM inventario_stock i
            JOIN articulos a ON i.id_articulo = a.id_articulo
            JOIN sucursales s ON i.id_sucursal = s.id_sucursal
            JOIN categorias c ON a.id_categoria = c.id_categoria
            WHERE i.cantidad > 0
            ORDER BY s.nombre, a.descripcion;
        ";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerMasVendidos($limite = 10) {
        $sql = "
            SELECT a.descripcion, SUM(pvd.cantidad) AS total_vendido
            FROM pedidos_venta_detalle pvd
            JOIN articulos a ON pvd.id_articulo = a.id_articulo
            GROUP BY a.id_articulo
            ORDER BY total_vendido DESC
            LIMIT :limite;
        ";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':limite', $limite, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerMenosVendidos($limite = 10) {
        $sql = "
            SELECT a.descripcion, SUM(pvd.cantidad) AS total_vendido
            FROM pedidos_venta_detalle pvd
            JOIN articulos a ON pvd.id_articulo = a.id_articulo
            GROUP BY a.id_articulo
            ORDER BY total_vendido ASC
            LIMIT :limite;
        ";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':limite', $limite, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
    public function obtenerHistorialPorArticulo($id_articulo) {
        $sql = "
            SELECT mi.fecha_hora, mi.tipo_movimiento, mi.cantidad, u.nombre_completo AS usuario, s.nombre AS sucursal
            FROM movimientos_inventario mi
            JOIN usuarios u ON mi.id_usuario = u.id_usuario
            JOIN sucursales s ON mi.id_sucursal = s.id_sucursal
            WHERE mi.id_articulo = :id_articulo
            ORDER BY mi.fecha_hora DESC;
        ";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':id_articulo', $id_articulo, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerArticulosDanados() {
        $sql = "
            SELECT mi.fecha_hora, a.descripcion AS articulo, ABS(mi.cantidad) AS cantidad_danada, u.nombre_completo AS reportado_por, s.nombre AS sucursal
            FROM movimientos_inventario mi
            JOIN articulos a ON mi.id_articulo = a.id_articulo
            JOIN usuarios u ON mi.id_usuario = u.id_usuario
            JOIN sucursales s ON mi.id_sucursal = s.id_sucursal
            WHERE mi.tipo_movimiento = 'dañado'
            ORDER BY mi.fecha_hora DESC;
        ";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }




/**
 * Obtiene todas las categorías para usarlas en los filtros.
 * @return array
 */
public function obtenerTodasLasCategorias() {
    $sql = "SELECT id_categoria, nombre_categoria FROM categorias ORDER BY nombre_categoria ASC;";
    $stmt = $this->pdo->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

/**
 * Obtiene el reporte de ventas aplicando filtros dinámicos.

 */
public function obtenerVentasConFiltros($filtros) {
    $sql = "
        SELECT 
            pv.fecha_pedido,
            c.nombre_completo AS cliente,
            a.descripcion AS articulo,
            cat.nombre_categoria,
            pvd.cantidad,
            pvd.precio_unitario,
            (pvd.cantidad * pvd.precio_unitario) AS subtotal
        FROM pedidos_venta pv
        JOIN clientes c ON pv.id_cliente = c.id_cliente
        JOIN pedidos_venta_detalle pvd ON pv.id_pedido = pvd.id_pedido
        JOIN articulos a ON pvd.id_articulo = a.id_articulo
        JOIN categorias cat ON a.id_categoria = cat.id_categoria
        WHERE 1=1
    ";

    $params = [];

    // Añadimos los filtros dinámicamente
    if (!empty($filtros['fecha_inicio'])) {
        $sql .= " AND DATE(pv.fecha_pedido) >= :fecha_inicio";
        $params[':fecha_inicio'] = $filtros['fecha_inicio'];
    }
    if (!empty($filtros['fecha_fin'])) {
        $sql .= " AND DATE(pv.fecha_pedido) <= :fecha_fin";
        $params[':fecha_fin'] = $filtros['fecha_fin'];
    }
    if (!empty($filtros['id_categoria'])) {
        $sql .= " AND a.id_categoria = :id_categoria";
        $params[':id_categoria'] = $filtros['id_categoria'];
    }

    $sql .= " ORDER BY pv.fecha_pedido DESC;";

    $stmt = $this->pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}


public function obtenerResumenDashboard() {
    $sql = "
        SELECT
            SUM(cantidad) AS total_stock,
            COUNT(DISTINCT id_articulo) AS articulos_unicos
        FROM inventario_stock;
    ";
    $stmt = $this->pdo->prepare($sql);
    $stmt->execute();
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
}
?>
