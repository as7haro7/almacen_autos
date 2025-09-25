<?php
require_once __DIR__ . '/../datos/ArticuloDAO.php';

class ArticuloNegocio {
    private $dao;

    public function __construct() {
        $this->dao = new ArticuloDAO();
    }

    public function registrarArticulo($idCategoria, $codigoArticulo, $descripcion, $codigoBarras, $precioVenta, $costoCompra) {
        if (empty($codigoArticulo) || empty($descripcion) || $precioVenta <= 0) {
            return "Datos de artículo inválidos.";
        }
        $res = $this->dao->registrarArticulo($idCategoria, $codigoArticulo, $descripcion, $codigoBarras, $precioVenta, $costoCompra);
        return $res ? "Artículo registrado correctamente." : "Error al registrar artículo.";
    }

    public function listarArticulos() {
        return $this->dao->listarArticulos();
    }

    public function actualizarArticulo($idArticulo, $idCategoria, $codigoArticulo, $descripcion, $codigoBarras, $precioVenta, $costoCompra) {
        return $this->dao->actualizarArticulo($idArticulo, $idCategoria, $codigoArticulo, $descripcion, $codigoBarras, $precioVenta, $costoCompra);
    }

    public function eliminarArticulo($idArticulo) {
        return $this->dao->eliminarArticulo($idArticulo);
    }
}
?>
