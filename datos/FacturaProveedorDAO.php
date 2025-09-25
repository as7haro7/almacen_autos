<?php
require_once 'Conexion.php';

class FacturaProveedorDAO {

    public function registrarFactura($idOrden, $numeroFactura, $codigoAut, $codigoCtrl, $fecha, $monto) {
        $cn = Conexion::conectar();

        $sql = "INSERT INTO facturas_proveedor 
                (id_orden_compra, numero_factura, codigo_autorizacion, codigo_control, fecha_emision, monto_total, estado_pago)
                VALUES (:idOrden, :numeroFactura, :codigoAut, :codigoCtrl, :fecha, :monto, 'pendiente')";
        $stmt = $cn->prepare($sql);
        $stmt->bindParam(":idOrden", $idOrden, PDO::PARAM_INT);
        $stmt->bindParam(":numeroFactura", $numeroFactura);
        $stmt->bindParam(":codigoAut", $codigoAut);
        $stmt->bindParam(":codigoCtrl", $codigoCtrl);
        $stmt->bindParam(":fecha", $fecha);
        $stmt->bindParam(":monto", $monto);
        return $stmt->execute();
    }

    public function listarFacturas() {
        $cn = Conexion::conectar();
        $sql = "SELECT f.id_factura_proveedor, f.numero_factura, f.codigo_autorizacion,
                       f.codigo_control, f.fecha_emision, f.monto_total, f.estado_pago,
                       o.id_orden_compra
                FROM facturas_proveedor f
                INNER JOIN ordenes_compra o ON f.id_orden_compra = o.id_orden_compra
                ORDER BY f.id_factura_proveedor DESC";
        $stmt = $cn->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function actualizarEstadoPago($idFactura, $nuevoEstado) {
        $cn = Conexion::conectar();
        $sql = "UPDATE facturas_proveedor SET estado_pago = :estado WHERE id_factura_proveedor = :idFactura";
        $stmt = $cn->prepare($sql);
        $stmt->bindParam(":estado", $nuevoEstado);
        $stmt->bindParam(":idFactura", $idFactura, PDO::PARAM_INT);
        return $stmt->execute();
    }
}
?>
