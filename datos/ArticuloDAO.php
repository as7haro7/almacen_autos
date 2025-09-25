<?php
require_once 'Conexion.php';

class ArticuloDAO {

    public function registrarArticulo($idCategoria, $codigoArticulo, $descripcion, $codigoBarras, $precioVenta, $costoCompra) {
        $cn = Conexion::conectar();
        $sql = "INSERT INTO articulos (id_categoria, codigo_articulo, descripcion, codigo_barras_qr, precio_venta, costo_compra_promedio)
                VALUES (:idCategoria, :codigoArticulo, :descripcion, :codigoBarras, :precioVenta, :costoCompra)";
        $stmt = $cn->prepare($sql);
        $stmt->bindParam(":idCategoria", $idCategoria);
        $stmt->bindParam(":codigoArticulo", $codigoArticulo);
        $stmt->bindParam(":descripcion", $descripcion);
        $stmt->bindParam(":codigoBarras", $codigoBarras);
        $stmt->bindParam(":precioVenta", $precioVenta);
        $stmt->bindParam(":costoCompra", $costoCompra);
        return $stmt->execute();
    }

    public function listarArticulos() {
        $cn = Conexion::conectar();
        $sql = "SELECT * FROM articulos ORDER BY id_articulo DESC";
        $stmt = $cn->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function actualizarArticulo($idArticulo, $idCategoria, $codigoArticulo, $descripcion, $codigoBarras, $precioVenta, $costoCompra) {
        $cn = Conexion::conectar();
        $sql = "UPDATE articulos SET id_categoria=:idCategoria, codigo_articulo=:codigoArticulo, 
                descripcion=:descripcion, codigo_barras_qr=:codigoBarras, 
                precio_venta=:precioVenta, costo_compra_promedio=:costoCompra
                WHERE id_articulo=:idArticulo";
        $stmt = $cn->prepare($sql);
        $stmt->bindParam(":idArticulo", $idArticulo);
        $stmt->bindParam(":idCategoria", $idCategoria);
        $stmt->bindParam(":codigoArticulo", $codigoArticulo);
        $stmt->bindParam(":descripcion", $descripcion);
        $stmt->bindParam(":codigoBarras", $codigoBarras);
        $stmt->bindParam(":precioVenta", $precioVenta);
        $stmt->bindParam(":costoCompra", $costoCompra);
        return $stmt->execute();
    }

    public function eliminarArticulo($idArticulo) {
        $cn = Conexion::conectar();
        $sql = "DELETE FROM articulos WHERE id_articulo=:idArticulo";
        $stmt = $cn->prepare($sql);
        $stmt->bindParam(":idArticulo", $idArticulo);
        return $stmt->execute();
    }
}
?>
