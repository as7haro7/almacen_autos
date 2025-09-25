<?php
require_once "../datos/conexion.php";

class ProveedorNegocio {
    private $db;

    public function __construct() {
        $this->db = conectarDB();
    }

    public function filtrarPorIndustria($industria) {
        $query = "SELECT * FROM proveedores WHERE industria = ?";
        $stmt = $this->db->prepare($query);
        $stmt->bind_param("s", $industria);
        $stmt->execute();
        $resultado = $stmt->get_result();
        return $resultado->fetch_all(MYSQLI_ASSOC);
    }
}
?>