<?php
require_once 'Conexion.php';

class OrdenCompraDetalleDAO {
    
    public function registrarRecepcion($idDetalle, $cantidadRecibida) {
        $cn = Conexion::conectar();

        $sql = "UPDATE ordenes_compra_detalle 
                SET cantidad = cantidad + :cantidadRecibida 
                WHERE id_detalle = :idDetalle";

        $stmt = $cn->prepare($sql);
        $stmt->bindParam(":cantidadRecibida", $cantidadRecibida, PDO::PARAM_INT);
        $stmt->bindParam(":idDetalle", $idDetalle, PDO::PARAM_INT);

        return $stmt->execute();
    }

    public function obtenerDetalleConArticulo($idDetalle) {
        $cn = Conexion::conectar();
        $sql = "SELECT d.id_detalle, d.cantidad, d.costo_unitario, 
                       a.descripcion AS articulo
                FROM ordenes_compra_detalle d
                INNER JOIN articulos a ON d.id_articulo = a.id_articulo
                WHERE d.id_detalle = :idDetalle";
        $stmt = $cn->prepare($sql);
        $stmt->bindParam(":idDetalle", $idDetalle, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function listarDetallesConArticulos() {
        $cn = Conexion::conectar();
        $sql = "SELECT d.id_detalle, d.id_orden_compra, d.cantidad, d.costo_unitario, 
                       a.descripcion AS articulo
                FROM ordenes_compra_detalle d
                INNER JOIN articulos a ON d.id_articulo = a.id_articulo
                ORDER BY d.id_detalle DESC";
        $stmt = $cn->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
