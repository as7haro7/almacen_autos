<?php
require_once '../datos/conexion.php';

class ProveedorNegocio {

    public static function filtrarPorIndustria($industria) {
        $db = Conexion::conectar();

        $sql = "SELECT * FROM proveedores WHERE industria = :industria";
        $stmt = $db->prepare($sql);
        $stmt->bindParam(':industria', $industria, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
