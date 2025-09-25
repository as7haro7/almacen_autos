<?php
// negocio/ReportesNegocio.php
require_once '../datos/ReportesDatos.php';

class ReportesNegocio {

    public function generarReporteInventarioValorizado() {
        $repo = new ReportesDatos();
        $inventarioCrudo = $repo->obtenerInventarioValorizado();
        $totalGeneral = 0;
        foreach ($inventarioCrudo as $item) {
            $totalGeneral += $item['valor_total_articulo'];
        }
        return [
            'detalle' => $inventarioCrudo,
            'total_general' => $totalGeneral
        ];
    }

    public function generarReporteMasVendidos() {
        $repo = new ReportesDatos();
        return $repo->obtenerMasVendidos(10);
    }

    public function generarReporteMenosVendidos() {
        $repo = new ReportesDatos();
        return $repo->obtenerMenosVendidos(10);
    }
    
    public function generarHistorialArticulo($id_articulo) {
        $repo = new ReportesDatos();
        return $repo->obtenerHistorialPorArticulo($id_articulo);
    }
    
    public function generarReporteDanados() {
        $repo = new ReportesDatos();
        return $repo->obtenerArticulosDanados();
    }
}
?>