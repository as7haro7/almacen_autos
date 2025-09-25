<?php
// OrdenCompraDAO.php
require_once 'Conexion.php';

class obtInventarioDatos {
    private $pdo;

    public function __construct() {
        $this->pdo = Conexion::conectar();
    }

    public function obtenerInventario() {
        $sql = "SELECT A.codigo_articulo, C.nombre_categoria, A.descripcion,A.codigo_barras_qr, A.precio_venta, A.costo_compra_promedio, I.cantidad, I.ubicacion_exacta,S.nombre
                FROM articulos A, categorias C, inventario_stock I, sucursales S
                WHERE A.id_categoria=C.id_categoria AND A.id_articulo=I.id_articulo AND S.id_sucursal=I.id_sucursal;";
        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    
    public function obtenerInventarioPorCategoria($cat) {
        $sql = "SELECT A.codigo_articulo, C.nombre_categoria, A.descripcion,A.codigo_barras_qr, A.precio_venta, A.costo_compra_promedio, I.cantidad, I.ubicacion_exacta,S.nombre
                FROM articulos A, categorias C, inventario_stock I, sucursales S
                WHERE A.id_categoria=C.id_categoria AND A.id_articulo=I.id_articulo AND S.id_sucursal=I.id_sucursal AND C.nombre_categoria=?;";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$cat]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);

    }
}
?>