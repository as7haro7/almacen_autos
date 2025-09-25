-- Base de datos: almacen_autos - Adaptada para Bolivia
-- Eliminación en cascada y datos de prueba incluidos

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Eliminar tablas si existen (para recrear con cascada)
DROP DATABASE IF EXISTS almacen_autos;
CREATE DATABASE almacen_autos;
USE almacen_autos;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `roles`
-- --------------------------------------------------------

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla para la tabla `sucursales`
-- --------------------------------------------------------

CREATE TABLE `sucursales` (
  `id_sucursal` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `usuarios`
-- --------------------------------------------------------

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `nombre_completo` varchar(150) NOT NULL,
  `ci` varchar(15) DEFAULT NULL COMMENT 'Cédula de Identidad Bolivia',
  `email` varchar(100) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL COMMENT 'Formato Bolivia: 7XXXXXXX',
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `categorias`
-- --------------------------------------------------------

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `proveedores`
-- --------------------------------------------------------

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_proveedor` varchar(150) NOT NULL,
  `nit` varchar(20) DEFAULT NULL COMMENT 'NIT Bolivia',
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `industria` varchar(100) DEFAULT NULL,
  `calificacion` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `articulos`
-- --------------------------------------------------------

CREATE TABLE `articulos` (
  `id_articulo` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `codigo_articulo` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `codigo_barras_qr` varchar(100) DEFAULT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `costo_compra_promedio` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `clientes`
-- --------------------------------------------------------

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre_completo` varchar(150) NOT NULL,
  `ci_nit` varchar(20) DEFAULT NULL COMMENT 'CI o NIT del cliente',
  `celular` varchar(15) DEFAULT NULL COMMENT 'Formato Bolivia',
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `inventario_stock`
-- --------------------------------------------------------

CREATE TABLE `inventario_stock` (
  `id_stock` int(11) NOT NULL,
  `id_articulo` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0,
  `stock_minimo_rojo` int(11) NOT NULL DEFAULT 3,
  `stock_minimo_naranja` int(11) NOT NULL DEFAULT 6,
  `ubicacion_exacta` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para las órdenes de compra
-- --------------------------------------------------------

CREATE TABLE `ordenes_compra` (
  `id_orden_compra` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_emision` date NOT NULL,
  `monto_total` decimal(12,2) NOT NULL,
  `estado` enum('pendiente','recibida','cancelada') NOT NULL DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Estructura de tabla para el detalle de órdenes de compra
-- --------------------------------------------------------

CREATE TABLE `ordenes_compra_detalle` (
  `id_detalle` int(11) NOT NULL,
  `id_orden_compra` int(11) NOT NULL,
  `id_articulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Pedidos de venta
-- --------------------------------------------------------

CREATE TABLE `pedidos_venta` (
  `id_pedido` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL DEFAULT current_timestamp(),
  `monto_total` decimal(12,2) NOT NULL,
  `estado` enum('procesando','enviado','entregado','cancelado') NOT NULL DEFAULT 'procesando'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Detalle de pedidos de venta
-- --------------------------------------------------------

CREATE TABLE `pedidos_venta_detalle` (
  `id_detalle` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_articulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `descuento` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Facturas de proveedor
-- --------------------------------------------------------

CREATE TABLE `facturas_proveedor` (
  `id_factura_proveedor` int(11) NOT NULL,
  `id_orden_compra` int(11) NOT NULL,
  `numero_factura` varchar(50) NOT NULL,
  `codigo_autorizacion` varchar(100) NOT NULL COMMENT 'Código de autorización IMPUESTOS BOLIVIA',
  `codigo_control` varchar(100) DEFAULT NULL,
  `fecha_emision` date NOT NULL,
  `monto_total` decimal(12,2) NOT NULL,
  `estado_pago` enum('pendiente','pagada') NOT NULL DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Citas de mantenimiento
-- --------------------------------------------------------

CREATE TABLE `citas_mantenimiento` (
  `id_cita` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `vehiculo_descripcion` varchar(255) DEFAULT NULL COMMENT 'Ej: Toyota Hilux 2022, Placa 1234ABC',
  `motivo` text NOT NULL,
  `fecha_hora_cita` datetime NOT NULL,
  `estado` enum('agendada','en_proceso','completada','cancelada') NOT NULL DEFAULT 'agendada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Movimientos de inventario
-- --------------------------------------------------------

CREATE TABLE `movimientos_inventario` (
  `id_movimiento` int(11) NOT NULL,
  `id_articulo` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `tipo_movimiento` enum('compra','venta','transferencia','ajuste','dañado') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `referencia_id` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Control de asistencia
-- --------------------------------------------------------

CREATE TABLE `control_asistencia` (
  `id_asistencia` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `fecha_hora_ingreso` datetime NOT NULL,
  `fecha_hora_salida` datetime DEFAULT NULL,
  PRIMARY KEY (`id_asistencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Auditoría
-- --------------------------------------------------------

CREATE TABLE `auditoria` (
  `id_auditoria` bigint(20) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `accion` varchar(255) NOT NULL,
  `tabla_afectada` varchar(100) DEFAULT NULL,
  `registro_afectado_id` int(11) DEFAULT NULL,
  `detalles` text DEFAULT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Inserción de datos para ALMACENES DE AUTOS TOYOSA
-- Datos realistas para repuestos y mantenimiento automotriz

-- Insertar Roles
INSERT INTO `roles` (`nombre_rol`, `descripcion`) VALUES
('Administrador', 'Acceso completo al sistema, gestión de usuarios y configuraciones'),
('Gerente', 'Supervisión de operaciones, reportes y gestión de personal'),
('Vendedor', 'Gestión de ventas, atención al cliente y pedidos'),
('Almacenero', 'Control de inventario, recepción y despacho de mercancía'),
('Técnico', 'Servicios de mantenimiento y reparación de vehículos'),
('Contador', 'Gestión financiera, cuentas por pagar y reportes contables');

-- Insertar Usuarios
INSERT INTO `usuarios` (`id_rol`, `nombre_usuario`, `contrasena_hash`, `nombre_completo`, `email`, `estado`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carlos Mendoza Rodriguez', 'admin@toyosa.com', 'activo'),
(2, 'gerente01', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Maria Elena Gutierrez', 'gerencia@toyosa.com', 'activo'),
(3, 'vendedor01', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Juan Pablo Morales', 'ventas1@toyosa.com', 'activo'),
(3, 'vendedor02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Ana Sofia Vargas', 'ventas2@toyosa.com', 'activo'),
(4, 'almacenero01', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Roberto Castro Lima', 'almacen@toyosa.com', 'activo'),
(5, 'tecnico01', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Miguel Angel Quispe', 'taller@toyosa.com', 'activo'),
(6, 'contador01', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Patricia Fernandez Soto', 'contabilidad@toyosa.com', 'activo');

-- Insertar Sucursales
INSERT INTO `sucursales` (`nombre`, `direccion`) VALUES
('TOYOSA Central', 'Av. 6 de Agosto #2547, Zona San Jorge, La Paz'),
('TOYOSA El Alto', 'Av. Juan Pablo II #1234, Ciudad Satélite, El Alto'),
('TOYOSA Sur', 'Av. Los Sargentos #890, Zona Calacoto, La Paz');

-- Insertar Categorías de Repuestos
INSERT INTO `categorias` (`nombre_categoria`, `descripcion`) VALUES
('Motor y Transmisión', 'Componentes del motor, filtros, aceites y sistema de transmisión'),
('Sistema de Frenos', 'Pastillas, discos, líquido de frenos y componentes del sistema'),
('Suspensión y Dirección', 'Amortiguadores, resortes, rótulas y componentes de dirección'),
('Sistema Eléctrico', 'Baterías, alternadores, motores de arranque y componentes eléctricos'),
('Carrocería y Exterior', 'Parachoques, faros, espejos y accesorios de carrocería'),
('Interior y Confort', 'Asientos, tapicería, aire acondicionado y accesorios internos'),
('Neumáticos y Llantas', 'Neumáticos, llantas de aleación y válvulas'),
('Herramientas y Equipos', 'Herramientas de taller y equipos de diagnóstico'),
('Lubricantes', 'Aceites, grasas y líquidos automotrices'),
('Filtros', 'Filtros de aire, aceite, combustible y habitáculo');

-- Insertar Proveedores
INSERT INTO `proveedores` (`nombre_proveedor`, `nit`, `telefono`, `email`, `industria`, `calificacion`) VALUES
('Toyota Bolivia S.A.', '1234567890', '2-2345678', 'ventas@toyota.com.bo', 'Automotriz Original', 4.8),
('Repuestos Génova', '2345678901', '2-2456789', 'contacto@genova.com', 'Repuestos Aftermarket', 4.2),
('Bosch Bolivia', '3456789012', '2-2567890', 'bolivia@bosch.com', 'Componentes Automotrices', 4.6),
('Castrol Lubricantes', '4567890123', '2-2678901', 'ventas@castrol.bo', 'Lubricantes y Químicos', 4.4),
('Bridgestone Andes', '5678901234', '2-2789012', 'info@bridgestone.bo', 'Neumáticos', 4.5),
('Denso Parts Bolivia', '6789012345', '2-2890123', 'bolivia@denso.com', 'Componentes Eléctricos', 4.3),
('Mann Filter Bolivia', '7890123456', '2-2901234', 'contacto@mannfilter.bo', 'Filtros Automotrices', 4.1),
('SKF Rodamientos', '8901234567', '2-3012345', 'ventas@skf.bo', 'Rodamientos y Repuestos', 4.0);

-- Insertar Artículos
INSERT INTO `articulos` (`id_categoria`, `codigo_articulo`, `descripcion`, `codigo_barras_qr`, `precio_venta`, `costo_compra_promedio`) VALUES
-- Motor y Transmisión
(1, 'MOT-001', 'Filtro de Aceite Toyota Hilux 2.4 Diesel', '7501234567890', 85.00, 65.00),
(1, 'MOT-002', 'Aceite Motor 15W-40 Mineral 4L Castrol', '7501234567891', 180.00, 140.00),
(1, 'MOT-003', 'Correa de Distribución Toyota Fortuner 2.7', '7501234567892', 450.00, 350.00),
(1, 'MOT-004', 'Bomba de Agua Toyota Land Cruiser 4.0', '7501234567893', 520.00, 400.00),

-- Sistema de Frenos
(2, 'FRE-001', 'Pastillas Freno Delanteras Toyota RAV4', '7501234567894', 280.00, 220.00),
(2, 'FRE-002', 'Disco Freno Delantero Toyota Corolla', '7501234567895', 350.00, 270.00),
(2, 'FRE-003', 'Líquido Frenos DOT 4 Bosch 1L', '7501234567896', 95.00, 75.00),
(2, 'FRE-004', 'Pastillas Freno Traseras Toyota Prado', '7501234567897', 320.00, 250.00),

-- Suspensión y Dirección
(3, 'SUS-001', 'Amortiguador Delantero Toyota Hilux 4x4', '7501234567898', 680.00, 530.00),
(3, 'SUS-002', 'Rótula Superior Toyota Land Cruiser', '7501234567899', 150.00, 115.00),
(3, 'SUS-003', 'Resorte Espiral Delantero Toyota Yaris', '7501234567900', 220.00, 170.00),

-- Sistema Eléctrico
(4, 'ELE-001', 'Batería 12V 65Ah Toyota Hilux', '7501234567901', 850.00, 650.00),
(4, 'ELE-002', 'Alternador Toyota Corolla 1.8', '7501234567902', 1200.00, 950.00),
(4, 'ELE-003', 'Motor Arranque Toyota RAV4 2.0', '7501234567903', 980.00, 750.00),
(4, 'ELE-004', 'Sensor Oxígeno Toyota Camry 2.4', '7501234567904', 420.00, 320.00),

-- Neumáticos y Llantas
(7, 'NEU-001', 'Neumático 265/65R17 Bridgestone Dueler', '7501234567905', 1200.00, 950.00),
(7, 'NEU-002', 'Neumático 215/60R16 Michelin Energy', '7501234567906', 890.00, 680.00),
(7, 'NEU-003', 'Llanta Aleación 16" Toyota Original', '7501234567907', 1800.00, 1400.00),

-- Lubricantes
(9, 'LUB-001', 'Aceite Transmisión Automática Toyota ATF', '7501234567908', 120.00, 95.00),
(9, 'LUB-002', 'Grasa Multiuso Chassis Toyota 500g', '7501234567909', 65.00, 50.00),
(9, 'LUB-003', 'Refrigerante Toyota Long Life 1L', '7501234567910', 85.00, 65.00),

-- Filtros
(10, 'FIL-001', 'Filtro Aire Toyota Hilux 2.4 Diesel', '7501234567911', 145.00, 110.00),
(10, 'FIL-002', 'Filtro Combustible Toyota Prado 3.0', '7501234567912', 180.00, 140.00),
(10, 'FIL-003', 'Filtro Habitáculo Toyota Corolla', '7501234567913', 95.00, 75.00);

-- Insertar Stock por Sucursal
INSERT INTO `inventario_stock` (`id_articulo`, `id_sucursal`, `cantidad`, `stock_minimo_rojo`, `stock_minimo_naranja`, `ubicacion_exacta`) VALUES
-- Sucursal Central
(1, 1, 25, 3, 6, 'A1-E2-N3'),
(2, 1, 40, 5, 10, 'A1-E1-N1'),
(3, 1, 8, 2, 4, 'A2-E3-N2'),
(4, 1, 12, 2, 5, 'A2-E2-N4'),
(5, 1, 18, 3, 6, 'B1-E1-N2'),
(6, 1, 15, 3, 6, 'B1-E2-N1'),
(7, 1, 30, 5, 10, 'A1-E1-N2'),
(8, 1, 22, 4, 8, 'B1-E1-N3'),

-- Sucursal El Alto
(1, 2, 15, 3, 6, 'EA-A1-N1'),
(2, 2, 25, 5, 10, 'EA-A1-N2'),
(9, 2, 10, 2, 4, 'EA-B1-N1'),
(10, 2, 8, 2, 4, 'EA-B1-N2'),
(11, 2, 6, 2, 4, 'EA-B2-N1'),
(17, 2, 12, 2, 4, 'EA-C1-N1'),
(18, 2, 8, 2, 4, 'EA-C1-N2'),

-- Sucursal Sur
(1, 3, 20, 3, 6, 'SUR-A1-N1'),
(2, 3, 35, 5, 10, 'SUR-A1-N2'),
(12, 3, 5, 1, 3, 'SUR-B1-N1'),
(13, 3, 4, 1, 3, 'SUR-B1-N2'),
(14, 3, 6, 1, 3, 'SUR-B2-N1'),
(19, 3, 15, 3, 6, 'SUR-C1-N1'),
(20, 3, 12, 3, 6, 'SUR-C1-N2');

-- Insertar Clientes
INSERT INTO `clientes` (`nombre_completo`, `numero_documento`, `telefono`, `email`, `direccion`) VALUES
('Juan Carlos Mendoza Pérez', '4568123-LP', '70123456', 'jmendoza@email.com', 'Zona Miraflores, Calle 15 #234'),
('María Fernanda López Silva', '3245789-LP', '71234567', 'mlopez@email.com', 'Zona San Pedro, Av. Buenos Aires #567'),
('Roberto Quispe Mamani', '7891234-LP', '72345678', 'rquispe@email.com', 'El Alto, Villa Dolores, Calle 8 #123'),
('Ana Patricia Vargas Cruz', '5678234-LP', '73456789', 'avargas@email.com', 'Zona Sur, Calacoto, Calle 21 #890'),
('Luis Alberto Morales Inca', '9012345-LP', '74567890', 'lmorales@email.com', 'Zona Norte, Villa Fátima, Av. Saavedra #456'),
('Carmen Rosa Delgado Flores', '2345678-LP', '75678901', 'cdelgado@email.com', 'Zona Centro, Calle Sagárnaga #789'),
('Pedro Antonio Gutiérrez Luna', '6789012-LP', '76789012', 'pgutierrez@email.com', 'Zona Sopocachi, Calle Fernando Guachalla #321'),
('Empresa Transporte La Paz LTDA', '1023456789012', '2-2345678', 'transporte@lapaz.com', 'Zona Industrial, Av. Argentina #1234');

-- Insertar Citas de Mantenimiento
INSERT INTO `citas_mantenimiento` (`id_cliente`, `vehiculo_descripcion`, `motivo`, `fecha_hora_cita`, `estado`) VALUES
(1, 'Toyota Hilux 2020, Placa 1234-ABC', 'Mantenimiento preventivo 10,000 km', '2025-09-25 09:00:00', 'agendada'),
(2, 'Toyota Corolla 2019, Placa 5678-DEF', 'Cambio de pastillas de freno', '2025-09-25 14:30:00', 'agendada'),
(3, 'Toyota RAV4 2021, Placa 9012-GHI', 'Revisión sistema eléctrico', '2025-09-26 08:30:00', 'agendada'),
(4, 'Toyota Prado 2018, Placa 3456-JKL', 'Cambio de aceite y filtros', '2025-09-26 16:00:00', 'agendada'),
(5, 'Toyota Land Cruiser 2022, Placa 7890-MNO', 'Alineación y balanceado', '2025-09-27 10:00:00', 'agendada');

-- Insertar Órdenes de Compra
INSERT INTO `ordenes_compra` (`id_proveedor`, `id_usuario`, `fecha_emision`, `monto_total`, `estado`) VALUES
(1, 2, '2025-09-20', 15680.00, 'recibida'),
(2, 2, '2025-09-22', 8950.00, 'pendiente'),
(3, 2, '2025-09-23', 5420.00, 'recibida'),
(4, 2, '2025-09-24', 3200.00, 'pendiente');

-- Insertar Detalles de Órdenes de Compra
INSERT INTO `ordenes_compra_detalle` (`id_orden_compra`, `id_articulo`, `cantidad`, `costo_unitario`) VALUES
-- Orden 1 - Toyota Bolivia
(1, 1, 50, 65.00),
(1, 3, 20, 350.00),
(1, 4, 15, 400.00),

-- Orden 2 - Repuestos Génova
(2, 5, 30, 220.00),
(2, 6, 25, 270.00),

-- Orden 3 - Bosch Bolivia
(3, 7, 60, 75.00),
(3, 15, 8, 320.00),

-- Orden 4 - Castrol
(4, 2, 100, 140.00),
(4, 19, 50, 95.00);

-- Insertar Facturas de Proveedor
INSERT INTO `facturas_proveedor` (`id_orden_compra`, `numero_factura`, `codigo_autorizacion`, `codigo_control`, `fecha_emision`, `monto_total`, `estado_pago`) VALUES
(1, '001-002-0000234', '29040011007', 'F7-A8-B9-C2', '2025-09-20', 15680.00, 'pagada'),
(3, '001-003-0000567', '29040011008', 'G3-H4-I5-J6', '2025-09-23', 5420.00, 'pendiente');

-- Insertar Pedidos de Venta
INSERT INTO `pedidos_venta` (`id_cliente`, `id_usuario`, `fecha_pedido`, `monto_total`, `estado`) VALUES
(1, 3, '2025-09-24 10:30:00', 765.00, 'procesando'),
(2, 4, '2025-09-24 15:45:00', 1450.00, 'enviado'),
(3, 3, '2025-09-24 16:20:00', 280.00, 'entregado');

-- Insertar Detalles de Pedidos de Venta
INSERT INTO `pedidos_venta_detalle` (`id_pedido`, `id_articulo`, `cantidad`, `precio_unitario`, `descuento`) VALUES
(1, 1, 2, 85.00, 0.00),
(1, 7, 1, 95.00, 0.00),
(1, 2, 3, 180.00, 5.00),

(2, 5, 1, 280.00, 0.00),
(2, 17, 1, 1200.00, 2.00),

(3, 5, 1, 280.00, 0.00);

-- Insertar Movimientos de Inventario
INSERT INTO `movimientos_inventario` (`id_articulo`, `id_sucursal`, `id_usuario`, `tipo_movimiento`, `cantidad`, `referencia_id`, `fecha_hora`) VALUES
-- Compras
(1, 1, 5, 'compra', 50, 1, '2025-09-20 14:30:00'),
(3, 1, 5, 'compra', 20, 1, '2025-09-20 14:35:00'),
(7, 1, 5, 'compra', 60, 3, '2025-09-23 11:20:00'),

-- Ventas
(1, 1, 3, 'venta', -2, 1, '2025-09-24 10:35:00'),
(7, 1, 3, 'venta', -1, 1, '2025-09-24 10:36:00'),
(5, 1, 4, 'venta', -1, 2, '2025-09-24 15:50:00'),

-- Transferencias
(1, 1, 5, 'transferencia', -10, NULL, '2025-09-23 09:00:00'),
(1, 2, 5, 'transferencia', 10, NULL, '2025-09-23 09:05:00'),

-- Ajustes
(2, 1, 5, 'ajuste', 5, NULL, '2025-09-22 16:00:00'),
(11, 3, 5, 'dañado', -1, NULL, '2025-09-21 12:30:00');

-- Insertar Control de Asistencia
INSERT INTO `control_asistencia` (`id_usuario`, `fecha_hora_ingreso`, `fecha_hora_salida`) VALUES
(1, '2025-09-24 08:00:00', '2025-09-24 18:00:00'),
(2, '2025-09-24 08:15:00', '2025-09-24 17:45:00'),
(3, '2025-09-24 08:30:00', '2025-09-24 17:30:00'),
(4, '2025-09-24 08:20:00', '2025-09-24 17:40:00'),
(5, '2025-09-24 07:45:00', '2025-09-24 17:15:00'),
(6, '2025-09-24 08:10:00', '2025-09-24 18:10:00'),
(7, '2025-09-24 09:00:00', '2025-09-24 17:00:00');

-- Insertar Auditoría
INSERT INTO `auditoria` (`id_usuario`, `accion`, `tabla_afectada`, `registro_afectado_id`, `fecha_hora`) VALUES
(1, 'CREAR_USUARIO', 'usuarios', 7, '2025-09-20 10:00:00'),
(2, 'CREAR_ORDEN_COMPRA', 'ordenes_compra', 1, '2025-09-20 11:30:00'),
(5, 'RECIBIR_MERCANCIA', 'inventario_stock', 1, '2025-09-20 14:30:00'),
(3, 'PROCESAR_VENTA', 'pedidos_venta', 1, '2025-09-24 10:30:00'),
(5, 'TRANSFERIR_STOCK', 'movimientos_inventario', 8, '2025-09-23 09:00:00'),
(2, 'MODIFICAR_ARTICULO', 'articulos', 15, '2025-09-23 15:45:00');


-- --------------------------------------------------------
-- ÍNDICES Y CLAVES PRIMARIAS
-- --------------------------------------------------------

-- Índices de la tabla `articulos`
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id_articulo`),
  ADD UNIQUE KEY `codigo_articulo` (`codigo_articulo`),
  ADD UNIQUE KEY `descripcion` (`descripcion`),
  ADD UNIQUE KEY `codigo_barras_qr` (`codigo_barras_qr`),
  ADD KEY `id_categoria` (`id_categoria`);

-- Índices de la tabla `auditoria`
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id_auditoria`),
  ADD KEY `id_usuario` (`id_usuario`);

-- Índices de la tabla `categorias`
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre_categoria` (`nombre_categoria`);

-- Índices de la tabla `citas_mantenimiento`
ALTER TABLE `citas_mantenimiento`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_cliente` (`id_cliente`);

-- Índices de la tabla `clientes`
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `ci_nit` (`ci_nit`),
  ADD UNIQUE KEY `email` (`email`);

-- Índices de la tabla `control_asistencia`
ALTER TABLE `control_asistencia`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `id_usuario` (`id_usuario`);

-- Índices de la tabla `facturas_proveedor`
ALTER TABLE `facturas_proveedor`
  ADD PRIMARY KEY (`id_factura_proveedor`),
  ADD UNIQUE KEY `numero_factura` (`numero_factura`),
  ADD KEY `id_orden_compra` (`id_orden_compra`);

-- Índices de la tabla `inventario_stock`
ALTER TABLE `inventario_stock`
  ADD PRIMARY KEY (`id_stock`),
  ADD UNIQUE KEY `id_articulo_sucursal` (`id_articulo`,`id_sucursal`),
  ADD KEY `id_sucursal` (`id_sucursal`);

-- Índices de la tabla `movimientos_inventario`
ALTER TABLE `movimientos_inventario`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `id_articulo` (`id_articulo`),
  ADD KEY `id_sucursal` (`id_sucursal`),
  ADD KEY `id_usuario` (`id_usuario`);

-- Índices de la tabla `ordenes_compra`
ALTER TABLE `ordenes_compra`
  ADD PRIMARY KEY (`id_orden_compra`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_usuario` (`id_usuario`);

-- Índices de la tabla `ordenes_compra_detalle`
ALTER TABLE `ordenes_compra_detalle`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_orden_compra` (`id_orden_compra`),
  ADD KEY `id_articulo` (`id_articulo`);

-- Índices de la tabla `pedidos_venta`
ALTER TABLE `pedidos_venta`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_usuario` (`id_usuario`);

-- Índices de la tabla `pedidos_venta_detalle`
ALTER TABLE `pedidos_venta_detalle`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_articulo` (`id_articulo`);

-- Índices de la tabla `proveedores`
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD UNIQUE KEY `nit` (`nit`);

-- Índices de la tabla `roles`
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre_rol` (`nombre_rol`);

-- Índices de la tabla `sucursales`
ALTER TABLE `sucursales`
  ADD PRIMARY KEY (`id_sucursal`);

-- Índices de la tabla `usuarios`
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `ci` (`ci`),
  ADD KEY `id_rol` (`id_rol`);

-- --------------------------------------------------------
-- AUTO_INCREMENT de las tablas
-- --------------------------------------------------------

ALTER TABLE `articulos` MODIFY `id_articulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
ALTER TABLE `auditoria` MODIFY `id_auditoria` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `categorias` MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `citas_mantenimiento` MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `clientes` MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `control_asistencia` MODIFY `id_asistencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `facturas_proveedor` MODIFY `id_factura_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `inventario_stock` MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
ALTER TABLE `movimientos_inventario` MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `ordenes_compra` MODIFY `id_orden_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `ordenes_compra_detalle` MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
ALTER TABLE `pedidos_venta` MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `pedidos_venta_detalle` MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `proveedores` MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `roles` MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `sucursales` MODIFY `id_sucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `usuarios` MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

-- --------------------------------------------------------
-- RESTRICCIONES DE CLAVE FORÁNEA CON ELIMINACIÓN EN CASCADA
-- --------------------------------------------------------

-- Filtros para la tabla `articulos`
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Filtros para la tabla `auditoria`
ALTER TABLE `auditoria`
  ADD CONSTRAINT `auditoria_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

-- Filtros para la tabla `citas_mantenimiento`
ALTER TABLE `citas_mantenimiento`
  ADD CONSTRAINT `citas_mantenimiento_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Filtros para la tabla `control_asistencia`
ALTER TABLE `control_asistencia`
  ADD CONSTRAINT `control_asistencia_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Filtros para la tabla `facturas_proveedor`
ALTER TABLE `facturas_proveedor`
  ADD CONSTRAINT `facturas_proveedor_ibfk_1` FOREIGN KEY (`id_orden_compra`) REFERENCES `ordenes_compra` (`id_orden_compra`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Filtros para la tabla `inventario_stock`
ALTER TABLE `inventario_stock`
  ADD CONSTRAINT `inventario_stock_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventario_stock_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Filtros para la tabla `movimientos_inventario`
ALTER TABLE `movimientos_inventario`
  ADD CONSTRAINT `movimientos_inventario_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movimientos_inventario_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movimientos_inventario_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Filtros para la tabla `ordenes_compra`
ALTER TABLE `ordenes_compra`
  ADD CONSTRAINT `ordenes_compra_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `ordenes_compra_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Filtros para la tabla `ordenes_compra_detalle`
ALTER TABLE `ordenes_compra_detalle`
  ADD CONSTRAINT `ordenes_compra_detalle_ibfk_1` FOREIGN KEY (`id_orden_compra`) REFERENCES `ordenes_compra` (`id_orden_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordenes_compra_detalle_ibfk_2` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Filtros para la tabla `pedidos_venta`
ALTER TABLE `pedidos_venta`
  ADD CONSTRAINT `pedidos_venta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `pedidos_venta_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Filtros para la tabla `pedidos_venta_detalle`
ALTER TABLE `pedidos_venta_detalle`
  ADD CONSTRAINT `pedidos_venta_detalle_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos_venta` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pedidos_venta_detalle_ibfk_2` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Filtros para la tabla `usuarios`
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE;




COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;