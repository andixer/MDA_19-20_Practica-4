-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 01-12-2019 a las 17:18:41
-- Versión del servidor: 5.7.28-0ubuntu0.18.04.4
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `MeetSure`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Actividades`
--

CREATE TABLE `Actividades` (
  `ActividadID` int(10) UNSIGNED NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `Lugar` varchar(255) NOT NULL,
  `MaximoParticipantes` int(11) NOT NULL,
  `MinimoParticipantes` int(11) NOT NULL,
  `Lider` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ActividadesCategorias`
--

CREATE TABLE `ActividadesCategorias` (
  `ActividadID` int(10) UNSIGNED NOT NULL,
  `CategoriaID` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Categorias`
--

CREATE TABLE `Categorias` (
  `CategoriaID` int(10) UNSIGNED NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Notificaciones`
--

CREATE TABLE `Notificaciones` (
  `NotificacionID` int(10) UNSIGNED NOT NULL,
  `Contenido` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Patrocinadores`
--

CREATE TABLE `Patrocinadores` (
  `UsuarioID` int(10) UNSIGNED NOT NULL,
  `Empresa` varchar(255) NOT NULL,
  `NivelPrioridad` int(11) NOT NULL,
  `NumeroCuenta` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

CREATE TABLE `Usuarios` (
  `UsuarioID` int(10) UNSIGNED NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `UsuariosParticipaActividades`
--

CREATE TABLE `UsuariosParticipaActividades` (
  `UsuarioID` int(10) UNSIGNED NOT NULL,
  `ActividadID` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `UsuariosParticipaActividades_Notificaciones`
--

CREATE TABLE `UsuariosParticipaActividades_Notificaciones` (
  `UsuarioID` int(10) UNSIGNED NOT NULL,
  `ActividadID` int(10) UNSIGNED NOT NULL,
  `NotificacionID` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Actividades`
--
ALTER TABLE `Actividades`
  ADD PRIMARY KEY (`ActividadID`),
  ADD KEY `Lider` (`Lider`);

--
-- Indices de la tabla `ActividadesCategorias`
--
ALTER TABLE `ActividadesCategorias`
  ADD PRIMARY KEY (`ActividadID`,`CategoriaID`),
  ADD KEY `ActividadID` (`ActividadID`),
  ADD KEY `CategoriaID` (`CategoriaID`);

--
-- Indices de la tabla `Categorias`
--
ALTER TABLE `Categorias`
  ADD PRIMARY KEY (`CategoriaID`);

--
-- Indices de la tabla `Notificaciones`
--
ALTER TABLE `Notificaciones`
  ADD PRIMARY KEY (`NotificacionID`);

--
-- Indices de la tabla `Patrocinadores`
--
ALTER TABLE `Patrocinadores`
  ADD PRIMARY KEY (`UsuarioID`);

--
-- Indices de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`UsuarioID`),
  ADD UNIQUE KEY `Nombre` (`Nombre`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indices de la tabla `UsuariosParticipaActividades`
--
ALTER TABLE `UsuariosParticipaActividades`
  ADD PRIMARY KEY (`UsuarioID`,`ActividadID`),
  ADD KEY `UsuarioID` (`UsuarioID`),
  ADD KEY `ActividadID` (`ActividadID`);

--
-- Indices de la tabla `UsuariosParticipaActividades_Notificaciones`
--
ALTER TABLE `UsuariosParticipaActividades_Notificaciones`
  ADD PRIMARY KEY (`UsuarioID`,`ActividadID`,`NotificacionID`),
  ADD KEY `UsuarioID` (`UsuarioID`),
  ADD KEY `ActividadID` (`ActividadID`),
  ADD KEY `NotificacionID` (`NotificacionID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Actividades`
--
ALTER TABLE `Actividades`
  MODIFY `ActividadID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `Categorias`
--
ALTER TABLE `Categorias`
  MODIFY `CategoriaID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `Notificaciones`
--
ALTER TABLE `Notificaciones`
  MODIFY `NotificacionID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `UsuarioID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Actividades`
--
ALTER TABLE `Actividades`
  ADD CONSTRAINT `Actividades_ibfk_1` FOREIGN KEY (`ActividadID`) REFERENCES `ActividadesCategorias` (`ActividadID`);

--
-- Filtros para la tabla `ActividadesCategorias`
--
ALTER TABLE `ActividadesCategorias`
  ADD CONSTRAINT `ActividadesCategorias_ibfk_1` FOREIGN KEY (`CategoriaID`) REFERENCES `Categorias` (`CategoriaID`);

--
-- Filtros para la tabla `Patrocinadores`
--
ALTER TABLE `Patrocinadores`
  ADD CONSTRAINT `Patrocinadores_ibfk_1` FOREIGN KEY (`UsuarioID`) REFERENCES `Usuarios` (`UsuarioID`);

--
-- Filtros para la tabla `UsuariosParticipaActividades`
--
ALTER TABLE `UsuariosParticipaActividades`
  ADD CONSTRAINT `UsuariosParticipaActividades_ibfk_1` FOREIGN KEY (`ActividadID`) REFERENCES `Actividades` (`ActividadID`);

--
-- Filtros para la tabla `UsuariosParticipaActividades_Notificaciones`
--
ALTER TABLE `UsuariosParticipaActividades_Notificaciones`
  ADD CONSTRAINT `UsuariosParticipaActividades_Notificaciones_ibfk_1` FOREIGN KEY (`ActividadID`) REFERENCES `Actividades` (`ActividadID`),
  ADD CONSTRAINT `UsuariosParticipaActividades_Notificaciones_ibfk_2` FOREIGN KEY (`UsuarioID`) REFERENCES `Usuarios` (`UsuarioID`),
  ADD CONSTRAINT `UsuariosParticipaActividades_Notificaciones_ibfk_3` FOREIGN KEY (`NotificacionID`) REFERENCES `Notificaciones` (`NotificacionID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
