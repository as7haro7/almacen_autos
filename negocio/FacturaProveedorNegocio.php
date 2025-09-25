<?php
require_once __DIR__ . '/../datos/FacturaProveedorDAO.php';

class FacturaProveedorNegocio {
    private $dao;

    public function __construct() {
        $this->dao = new FacturaProveedorDAO();
    }

    public function registrarFactura($idOrden, $numeroFactura, $codigoAut, $codigoCtrl, $fecha, $monto) {
        if (empty($numeroFactura) || empty($fecha) || $monto <= 0) {
            return "Datos de factura inválidos.";
        }
        $res = $this->dao->registrarFactura($idOrden, $numeroFactura, $codigoAut, $codigoCtrl, $fecha, $monto);
        return $res ? "Factura registrada correctamente." : "Error al registrar factura.";
    }

    public function listarFacturas() {
        return $this->dao->listarFacturas();
    }

    public function pagarFactura($idFactura) {
        return $this->dao->actualizarEstadoPago($idFactura, "pagada");
    }
}
?>
