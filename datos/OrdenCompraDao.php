<?php
// OrdenCompraDAO.php
require_once 'Conexion.php';

class OrdenCompraDAO {
    private $pdo;

    public function __construct() {
        $this->pdo = Conexion::conectar();
    }

    public function registrarOrdenCompra($id_proveedor, $id_usuario, $fecha_emision, $monto_total, $estado = 'pendiente') {
        $sql = "INSERT INTO ordenes_compra (id_proveedor, id_usuario, fecha_emision, monto_total, estado) VALUES (?, ?, ?, ?, ?)";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute([$id_proveedor, $id_usuario, $fecha_emision, $monto_total, $estado]);
    }

    public function actualizarEstadoOrden($id_orden_compra, $estado) {
        $sql = "UPDATE ordenes_compra SET estado = ? WHERE id_orden_compra = ?";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute([$estado, $id_orden_compra]);
    }

    public function obtenerOrdenes() {
        $sql = "SELECT * FROM ordenes_compra";
        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerOrdenPorId($id_orden_compra) {
        $sql = "SELECT * FROM ordenes_compra WHERE id_orden_compra = ?";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$id_orden_compra]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>