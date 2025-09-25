
<?php
require_once '../datos/conexion.php';

class Proveedor {
    private $db;

    public function __construct() {
        $this->db = Conexion::conectar();
    }

    public function registrar($datos) {
        $sql = "INSERT INTO proveedores 
                (nombre_proveedor, nit, telefono, email, direccion, ciudad, industria, calificacion)
                VALUES (:nom, :nit, :tel, :email, :dir, :cui, :industria, :calificacion)";

        $stmt = $this->db->prepare($sql);
        return $stmt->execute([
            ':nom' => $datos['nombre_proveedor'],
            ':nit' => $datos['nit'],
            ':tel' => $datos['telefono'],
            ':email' => $datos['email'],
            ':dir' => $datos['direccion'],
            ':cui' => $datos['cuidad'],
            ':industria' => $datos['industria'],
            ':calificacion' => $datos['calificacion']
        ]);
    }
}
?>
