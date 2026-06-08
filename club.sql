-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2025 a las 16:37:24
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `club`
--
CREATE DATABASE IF NOT EXISTS `club` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `club`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas`
--

CREATE TABLE `cajas` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(50) NOT NULL,
  `descripcion` varchar(80) NOT NULL,
  `codigointerno` varchar(50) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_edicion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_borrado` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `liquidaciones`
--

CREATE TABLE `liquidaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `monto` double NOT NULL,
  `fecha_vencimiento` date DEFAULT curdate(),
  `activo` tinyint(1) DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_edicion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_borrado` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int(11) NOT NULL,
  `monto` float NOT NULL,
  `fecha_pago` datetime DEFAULT current_timestamp(),
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `id_socio` int(11) DEFAULT NULL,
  `id_liquidacion` int(11) DEFAULT NULL,
  `id_caja` int(11) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recaudadores`
--

CREATE TABLE `recaudadores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `dni` varchar(30) NOT NULL,
  `id_caja` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_edicion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_borrado` datetime DEFAULT NULL,
  `telefono` varchar(30) NOT NULL,
  `id_zona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE `socios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `domicilio` varchar(80) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `fecha_nac` date DEFAULT curdate(),
  `dni` varchar(30) NOT NULL,
  `email` varchar(80) DEFAULT NULL,
  `id_zona` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_edicion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_borrado` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `username` varchar(80) NOT NULL,
  `clave` varchar(200) NOT NULL,
  `dni` varchar(30) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_edicion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_borrado` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `username`, `clave`, `dni`, `activo`, `fecha_alta`, `fecha_edicion`, `fecha_borrado`) VALUES
(2, 'Admin', 'Admin', 'admin', '$2y$10$KDWR61anUKO0/9Ozi4ePbOtnijM/ZB5EY9bXn6Tlx5Kvcn4LEbLkW', '00000000', 1, '2025-11-03 19:25:54', '2025-11-23 17:28:24', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zonas`
--

CREATE TABLE `zonas` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(80) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_edicion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_borrado` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cajas`
--
ALTER TABLE `cajas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `liquidaciones`
--
ALTER TABLE `liquidaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_socio` (`id_socio`),
  ADD KEY `id_liquidacion` (`id_liquidacion`),
  ADD KEY `id_caja` (`id_caja`);

--
-- Indices de la tabla `recaudadores`
--
ALTER TABLE `recaudadores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_caja` (`id_caja`),
  ADD KEY `recaudadores_zonas_fk` (`id_zona`);

--
-- Indices de la tabla `socios`
--
ALTER TABLE `socios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_zona` (`id_zona`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `zonas`
--
ALTER TABLE `zonas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cajas`
--
ALTER TABLE `cajas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `liquidaciones`
--
ALTER TABLE `liquidaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recaudadores`
--
ALTER TABLE `recaudadores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `socios`
--
ALTER TABLE `socios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `zonas`
--
ALTER TABLE `zonas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id`),
  ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`id_liquidacion`) REFERENCES `liquidaciones` (`id`),
  ADD CONSTRAINT `pagos_ibfk_3` FOREIGN KEY (`id_caja`) REFERENCES `cajas` (`id`);

--
-- Filtros para la tabla `recaudadores`
--
ALTER TABLE `recaudadores`
  ADD CONSTRAINT `recaudadores_ibfk_1` FOREIGN KEY (`id_caja`) REFERENCES `cajas` (`id`),
  ADD CONSTRAINT `recaudadores_zonas_fk` FOREIGN KEY (`id_zona`) REFERENCES `zonas` (`id`),
  ADD CONSTRAINT `recuadadores_zonas_fk` FOREIGN KEY (`id_zona`) REFERENCES `zonas` (`id`);

--
-- Filtros para la tabla `socios`
--
ALTER TABLE `socios`
  ADD CONSTRAINT `socios_ibfk_1` FOREIGN KEY (`id_zona`) REFERENCES `zonas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
