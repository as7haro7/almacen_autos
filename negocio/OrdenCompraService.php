<?php
// OrdenCompraService.php
require_once '../datos/OrdenCompraDAO.php';


class OrdenCompraService {
    private $dao;

    public function __construct() {
        $this->dao = new OrdenCompraDAO();
    }

    public function crearOrdenCompra($id_proveedor, $id_usuario, $fecha_emision, $monto_total) {
        // Aquí validaciones si se requieren
        return $this->dao->registrarOrdenCompra($id_proveedor, $id_usuario, $fecha_emision, $monto_total);
    }

    public function cambiarEstadoOrden($id_orden_compra, $estado) {
        return $this->dao->actualizarEstadoOrden($id_orden_compra, $estado);
    }

    public function listarOrdenes() {
        return $this->dao->obtenerOrdenes();
    }

    public function obtenerOrden($id_orden_compra) {
        return $this->dao->obtenerOrdenPorId($id_orden_compra);
    }
}?>
