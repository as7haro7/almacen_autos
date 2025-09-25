<?php
require_once __DIR__ . '/../datos/OrdenCompraDetalleDAO.php';

class OrdenCompraDetalleNegocio {
    private $dao;

    public function __construct() {
        $this->dao = new OrdenCompraDetalleDAO();
    }

    public function registrarRecepcion($idDetalle, $cantidadRecibida) {
        if ($cantidadRecibida <= 0) {
            return "La cantidad recibida debe ser mayor a 0";
        }
        $resultado = $this->dao->registrarRecepcion($idDetalle, $cantidadRecibida);
        return $resultado ? "Recepción registrada correctamente" : "Error al registrar la recepción";
    }

    public function obtenerDetalleConArticulo($idDetalle) {
        return $this->dao->obtenerDetalleConArticulo($idDetalle);
    }

    public function listarDetallesConArticulos() {
        return $this->dao->listarDetallesConArticulos();
    }
}
?>
