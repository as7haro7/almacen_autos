<?php
require_once '../datos/obtInventarioDatos.php';


class obtInventario
{
    private $dao;

    public function __construct()
    {
        $this->dao = new obtInventarioDatos();
    }
    public function listarInventario()
    {
        return $this->dao->obtenerInventario();
    }

    public function listarInventarioPorCategoria($cat)
    {
        return $this->dao->obtenerInventarioPorCategoria($cat);
    }

    public function listarCategorias()
    {
        return $this->dao->obtenerCategorias();
    }

    public function crearArticulo($catNombre, $codigo_articulo, $descripcion, $venta, $compra)
    {
        return $this->dao->registrarArticulo($catNombre, $codigo_articulo, $descripcion, $venta, $compra);
    }
}
