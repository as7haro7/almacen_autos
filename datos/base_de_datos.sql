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

INSERT INTO `roles` (`id_rol`, `nombre_rol`, `descripcion`) VALUES
(1, 'Administrador', 'Acceso completo al sistema'),
(2, 'Gerente', 'Gestión de inventario, ventas y reportes'),
(3, 'Vendedor', 'Gestión de ventas y clientes'),
(4, 'Almacenero', 'Gestión de inventario y recepción'),
(5, 'Comprador', 'Gestión de compras y proveedores');

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `sucursales`
-- --------------------------------------------------------

CREATE TABLE `sucursales` (
  `id_sucursal` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sucursales` (`id_sucursal`, `nombre`, `direccion`) VALUES
(1, 'Sucursal La Paz - Centro', 'Av. Mariscal Santa Cruz 1234, La Paz'),
(2, 'Sucursal El Alto', 'Av. 6 de Marzo 567, El Alto'),
(3, 'Sucursal Cochabamba', 'Av. América 890, Cochabamba'),
(4, 'Sucursal Santa Cruz', 'Av. Cristo Redentor 432, Santa Cruz');

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

INSERT INTO `usuarios` (`id_usuario`, `id_rol`, `nombre_usuario`, `contrasena_hash`, `nombre_completo`, `ci`, `email`, `celular`, `estado`) VALUES
(1, 1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Juan Carlos Mamani', '12345678LP', 'admin@almacenautos.bo', '70123456', 'activo'),
(2, 2, 'gerente1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'María Elena Quispe', '87654321CB', 'gerente@almacenautos.bo', '71987654', 'activo'),
(3, 3, 'vendedor1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carlos Mendoza Rojas', '11223344SC', 'ventas@almacenautos.bo', '72334455', 'activo'),
(4, 4, 'almacen1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Ana Lucía Condori', '55667788TJ', 'almacen@almacenautos.bo', '76554433', 'activo'),
(5, 5, 'comprador1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Roberto Flores Nina', '99887766OR', 'compras@almacenautos.bo', '75998877', 'activo');

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `categorias`
-- --------------------------------------------------------

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categorias` (`id_categoria`, `nombre_categoria`, `descripcion`) VALUES
(1, 'Motor', 'Componentes del sistema motor'),
(2, 'Transmisión', 'Caja de cambios y componentes'),
(3, 'Frenos', 'Sistema de frenos y componentes'),
(4, 'Suspensión', 'Amortiguadores y componentes de suspensión'),
(5, 'Eléctrico', 'Sistema eléctrico del vehículo'),
(6, 'Carrocería', 'Partes externas del vehículo'),
(7, 'Neumáticos', 'Llantas y neumáticos'),
(8, 'Accesorios', 'Accesorios diversos para vehículos');

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

INSERT INTO `proveedores` (`id_proveedor`, `nombre_proveedor`, `nit`, `telefono`, `email`, `direccion`, `ciudad`, `industria`, `calificacion`) VALUES
(1, 'Autopartes Bolivia SRL', '1023456789015', '2-2234567', 'ventas@autopartesbo.com', 'Av. Buenos Aires 1234', 'La Paz', 'Autopartes', 4.50),
(2, 'Repuestos Andinos S.A.', '2034567890016', '4-4123456', 'info@repuestosandinos.com', 'Zona Norte Km 3', 'Cochabamba', 'Repuestos', 4.20),
(3, 'Importadora Oriental', '3045678901017', '3-3987654', 'oriental@repuestos.bo', 'Av. Roca y Coronado 567', 'Santa Cruz', 'Importación', 4.80),
(4, 'Neumáticos del Sur', '4056789012018', '4-6543210', 'sur@neumaticos.bo', 'Circunvalación Este 890', 'Cochabamba', 'Neumáticos', 4.10),
(5, 'Talleres Unidos', '5067890123019', '2-7890123', 'unidos@talleres.bo', 'Villa Fátima 432', 'La Paz', 'Servicios', 3.90);

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

INSERT INTO `articulos` (`id_articulo`, `id_categoria`, `codigo_articulo`, `descripcion`, `codigo_barras_qr`, `precio_venta`, `costo_compra_promedio`) VALUES
(1, 1, 'MOT001', 'Filtro de aceite Toyota Hilux', '7891234567890', 85.00, 60.00),
(2, 1, 'MOT002', 'Bujía NGK Iridium', '7892345678901', 45.00, 28.00),
(3, 2, 'TRA001', 'Kit Embrague Suzuki Alto', '7893456789012', 680.00, 480.00),
(4, 3, 'FRE001', 'Pastillas Freno Delanteras Toyota', '7894567890123', 320.00, 220.00),
(5, 4, 'SUS001', 'Amortiguador Trasero Nissan', '7895678901234', 420.00, 280.00),
(6, 5, 'ELE001', 'Batería 12V 65Ah', '7896789012345', 550.00, 380.00),
(7, 6, 'CAR001', 'Parachoque Delantero Hyundai', '7897890123456', 1250.00, 850.00),
(8, 7, 'NEU001', 'Neumático 185/65R14', '7898901234567', 480.00, 320.00),
(9, 8, 'ACC001', 'Alfombrillas Universales', '7899012345678', 65.00, 40.00),
(10, 1, 'MOT003', 'Aceite Motor 15W40 5L', '7890123456789', 180.00, 120.00);

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

INSERT INTO `clientes` (`id_cliente`, `nombre_completo`, `ci_nit`, `celular`, `email`, `direccion`, `ciudad`) VALUES
(1, 'Luis Fernando Torrez', '6677889LP', '70456789', 'luis.torrez@email.com', 'Zona Sur, Calle 21 #456', 'La Paz'),
(2, 'Carmen Rosa Velasco', '7788990CB', '71567890', 'carmen.velasco@gmail.com', 'Av. Heroínas 789', 'Cochabamba'),
(3, 'Pedro Alejandro Cruz', '8899001SC', '72678901', 'pedro.cruz@hotmail.com', 'Barrio Equipetrol Norte', 'Santa Cruz'),
(4, 'Silvia Patricia Mamani', '9900112TJ', '73789012', 'silvia.mamani@yahoo.com', 'Villa Adela, Calle 15', 'El Alto'),
(5, 'Jorge Antonio Flores', '1011223OR', '74890123', 'jorge.flores@outlook.com', 'Av. Villarroel 1234', 'Oruro');

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

INSERT INTO `inventario_stock` (`id_stock`, `id_articulo`, `id_sucursal`, `cantidad`, `stock_minimo_rojo`, `stock_minimo_naranja`, `ubicacion_exacta`) VALUES
(1, 1, 1, 25, 3, 6, 'Estante A-1-2'),
(2, 2, 1, 45, 5, 10, 'Estante A-2-1'),
(3, 3, 1, 8, 2, 4, 'Estante B-1-3'),
(4, 4, 1, 15, 3, 6, 'Estante B-2-1'),
(5, 5, 1, 12, 2, 5, 'Estante C-1-2'),
(6, 6, 2, 18, 3, 6, 'Depósito A-Sección 1'),
(7, 7, 2, 5, 1, 3, 'Depósito B-Área Grande'),
(8, 8, 3, 32, 4, 8, 'Área Neumáticos A1'),
(9, 9, 1, 50, 10, 20, 'Estante D-1-1'),
(10, 10, 1, 35, 5, 10, 'Depósito Aceites');

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

INSERT INTO `ordenes_compra` (`id_orden_compra`, `id_proveedor`, `id_usuario`, `fecha_emision`, `monto_total`, `estado`) VALUES
(1, 1, 5, '2025-09-20', 3600.00, 'recibida'),
(2, 2, 5, '2025-09-22', 2800.00, 'pendiente'),
(3, 3, 5, '2025-09-24', 4200.00, 'pendiente');

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

INSERT INTO `ordenes_compra_detalle` (`id_detalle`, `id_orden_compra`, `id_articulo`, `cantidad`, `costo_unitario`) VALUES
(1, 1, 1, 60, 60.00),
(2, 1, 2, 100, 28.00),
(3, 1, 10, 20, 120.00),
(4, 2, 3, 5, 480.00),
(5, 2, 4, 12, 220.00),
(6, 3, 6, 10, 380.00),
(7, 3, 8, 8, 320.00);

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

INSERT INTO `pedidos_venta` (`id_pedido`, `id_cliente`, `id_usuario`, `fecha_pedido`, `monto_total`, `estado`) VALUES
(1, 1, 3, '2025-09-23 10:30:00', 450.00, 'entregado'),
(2, 2, 3, '2025-09-24 14:15:00', 680.00, 'procesando'),
(3, 3, 3, '2025-09-24 16:45:00', 740.00, 'enviado');

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

INSERT INTO `pedidos_venta_detalle` (`id_detalle`, `id_pedido`, `id_articulo`, `cantidad`, `precio_unitario`, `descuento`) VALUES
(1, 1, 1, 3, 85.00, 0.00),
(2, 1, 2, 4, 45.00, 5.00),
(3, 2, 3, 1, 680.00, 0.00),
(4, 3, 4, 2, 320.00, 0.00),
(5, 3, 9, 2, 65.00, 10.00);

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

INSERT INTO `facturas_proveedor` (`id_factura_proveedor`, `id_orden_compra`, `numero_factura`, `codigo_autorizacion`, `codigo_control`, `fecha_emision`, `monto_total`, `estado_pago`) VALUES
(1, 1, '001-002-0001234', '29040011007', 'CF-84-A2-E5', '2025-09-21', 3600.00, 'pagada');

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

INSERT INTO `citas_mantenimiento` (`id_cita`, `id_cliente`, `vehiculo_descripcion`, `motivo`, `fecha_hora_cita`, `estado`) VALUES
(1, 1, 'Toyota Hilux 2020, Placa 1234-ABC', 'Cambio de aceite y filtros', '2025-09-25 09:00:00', 'agendada'),
(2, 2, 'Suzuki Alto 2019, Placa 5678-DEF', 'Revisión sistema de frenos', '2025-09-25 14:30:00', 'agendada'),
(3, 3, 'Nissan Frontier 2021, Placa 9012-GHI', 'Mantenimiento preventivo 20,000 km', '2025-09-26 10:15:00', 'agendada');

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

INSERT INTO `movimientos_inventario` (`id_movimiento`, `id_articulo`, `id_sucursal`, `id_usuario`, `tipo_movimiento`, `cantidad`, `referencia_id`, `observaciones`) VALUES
(1, 1, 1, 4, 'compra', 60, 1, 'Ingreso por OC #1'),
(2, 1, 1, 3, 'venta', -3, 1, 'Venta pedido #1'),
(3, 2, 1, 4, 'compra', 100, 1, 'Ingreso por OC #1'),
(4, 2, 1, 3, 'venta', -4, 1, 'Venta pedido #1'),
(5, 3, 1, 3, 'venta', -1, 2, 'Venta pedido #2');

-- --------------------------------------------------------
-- Control de asistencia
-- --------------------------------------------------------

CREATE TABLE `control_asistencia` (
  `id_asistencia` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_hora_ingreso` datetime NOT NULL,
  `fecha_hora_salida` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `control_asistencia` (`id_asistencia`, `id_usuario`, `fecha_hora_ingreso`, `fecha_hora_salida`) VALUES
(1, 3, '2025-09-24 08:30:00', '2025-09-24 18:15:00'),
(2, 4, '2025-09-24 08:45:00', '2025-09-24 17:30:00'),
(3, 5, '2025-09-24 09:00:00', '2025-09-24 17:45:00'),
(4, 3, '2025-09-25 08:35:00', NULL),
(5, 4, '2025-09-25 08:50:00', NULL);

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

INSERT INTO `auditoria` (`id_auditoria`, `id_usuario`, `accion`, `tabla_afectada`, `registro_afectado_id`, `detalles`) VALUES
(1, 1, 'CREATE', 'articulos', 1, 'Creación de artículo: Filtro de aceite Toyota Hilux'),
(2, 3, 'UPDATE', 'inventario_stock', 1, 'Actualización stock por venta - Cantidad: 28 -> 25'),
(3, 4, 'CREATE', 'movimientos_inventario', 1, 'Movimiento de compra registrado'),
(4, 5, 'CREATE', 'ordenes_compra', 1, 'Nueva orden de compra creada');

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