<?php
require '../datos/conexion.php';
$db=conectarDB();

if($_POST){
    $nom = $_POST['nombre_proveedor'];
    $nit = $_POST['nit'];
    $tel = $_POST['telefono'];
    $email = $_POST['email'];
    $dir = $_POST['direccion'];
    $cui = $_POST['cuidad'];
    $indutria = $_POST['industria'];
    $calificacion = $_POST['calificacion'];

    $con = "INSERT INTO `proveedores`(`nombre_proveedor`, `nit`, `telefono`, `email`, `direccion`, `ciudad`, `industria`, `calificacion`)
     VALUES ('$nom','$nit','$tel','$email','$dir','$cui','$indutria','$calificacion')";

    $res = mysqli_query($db, $con);

    if ($res) {
        echo "<script> alert('Se registró vendedor'); </script>";
    } else {
        echo "<script> alert('No see registró vendedor'); </script>";
    }
}
?>