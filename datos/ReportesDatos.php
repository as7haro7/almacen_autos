<?php
// datos/ReportesDatos.php

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
}
?>