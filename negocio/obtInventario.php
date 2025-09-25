<?php
require_once '../datos/obtInventarioDatos.php';


class obtInventario {
    private $dao;

    public function __construct() {
        $this->dao = new obtInventarioDatos();
    }
    public function listarInventario() {
        return $this->dao->obtenerInventario();
    }

    public function listarInventarioPorCategoria($cat) {
        return $this->dao->obtenerInventarioPorCategoria($cat);
    }
}?>
