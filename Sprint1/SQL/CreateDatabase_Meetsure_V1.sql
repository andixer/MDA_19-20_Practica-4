

USE Meetsure
GO

CREATE TABLE Usuarios
(
	UsuarioID INT IDENTITY (1, 1) NOT NULL,
	Nombre NVARCHAR(50),
	Email NVARCHAR(50),
	Contraseña NVARCHAR(50),
	CONSTRAINT PK_User PRIMARY KEY (UsuarioID)
);

CREATE TABLE Patrocinadores
(
	UsuarioID INT UNIQUE,
	Empresa NVARCHAR (50),
	NumeroCuenta NVARCHAR (50),		-- Puede incluir letras
	NivelPrioridad INT DEFAULT 1,	-- Rangos de 1 a 5 (menor a mayor)
	PRIMARY KEY (UsuarioID),
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

CREATE TABLE Administradores
(
	UsuarioID INT UNIQUE,
	PRIMARY KEY (UsuarioID),
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

CREATE TABLE Valoraciones
(
	ValoracionID INT IDENTITY (1, 1) NOT NULL,
	Valoracion NVarChar(255),
	UsuarioEmisorID INT,
	UsuarioReceptorID INT,
	PRIMARY KEY (ValoracionID),
	FOREIGN KEY (UsuarioEmisorID) REFERENCES Usuarios(UsuarioID),
	FOREIGN KEY (UsuarioReceptorID) REFERENCES Usuarios(UsuarioID)
);

CREATE TABLE Categorias
(
	CategoriaID INT IDENTITY (1, 1) NOT NULL,
	Nombre NVARCHAR(20),
	Descripcion NVARCHAR (255),
	PRIMARY KEY (CategoriaID)
);

CREATE TABLE Notificaciones
(
	NotificacionID INT IDENTITY (1, 1) NOT NULL,
	Contenido NVARCHAR,
	PRIMARY KEY (NotificacionID)
);

CREATE TABLE Actividades
(
	ActividadID INT IDENTITY (1, 1) NOT NULL,
	Nombre NVARCHAR (50),
	Descripcion NVARCHAR (255),
	Fecha DATE,
	Hora TIME,
	Lugar NVARCHAR (255),
	CategoriaID INT,
	PRIMARY KEY (ActividadID),
	FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)

);

CREATE TABLE ActividadesUsuarios
(
	UsuarioID INT,
	NotificacionID INT,
	ActividadID INT
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
	FOREIGN KEY (NotificacionID) REFERENCES Notificaciones(NotificacionID),
	FOREIGN KEY (ActividadID) REFERENCES Actividades(ActividadID)
);