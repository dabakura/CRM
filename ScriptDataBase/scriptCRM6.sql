USE [master]
GO
/****** Object:  Database [CRM]    Script Date: 13/07/2019 4:19:13 ******/
CREATE DATABASE [CRM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CRM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CRM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CRM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CRM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CRM] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CRM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CRM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CRM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CRM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CRM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CRM] SET ARITHABORT OFF 
GO
ALTER DATABASE [CRM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CRM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CRM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CRM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CRM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CRM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CRM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CRM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CRM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CRM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CRM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CRM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CRM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CRM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CRM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CRM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CRM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CRM] SET RECOVERY FULL 
GO
ALTER DATABASE [CRM] SET  MULTI_USER 
GO
ALTER DATABASE [CRM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CRM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CRM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CRM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CRM] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CRM', N'ON'
GO
ALTER DATABASE [CRM] SET QUERY_STORE = OFF
GO
USE [CRM]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [CRM]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 13/07/2019 4:19:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresa](
	[Id_Empresa] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Correo] [varchar](100) NULL,
	[Cedula] [varchar](30) NULL,
	[Id_Pais] [int] NULL,
	[Id_Provincia] [int] NULL,
	[Id_Canton] [int] NULL,
	[Id_Distrito] [int] NULL,
	[Otras_Señas] [varchar](300) NOT NULL,
	[Codigo_Postal] [int] NOT NULL,
	[Tipo_Cedula] [varchar](50) NULL,
 CONSTRAINT [PK_Empresa] PRIMARY KEY CLUSTERED 
(
	[Id_Empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[Id_Producto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Codigo] [varchar](10) NOT NULL,
	[Tipo_Producto] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED 
(
	[Id_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuenta]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuenta](
	[Id_Cuenta] [int] IDENTITY(1,1) NOT NULL,
	[Servicio_Empresa] [int] NOT NULL,
	[Fecha_Pago] [date] NOT NULL,
	[Monto_Abono] [float] NOT NULL,
	[Monto_Pendiente] [float] NULL,
	[Descripcion] [nvarchar](250) NULL,
 CONSTRAINT [PK_Cuenta] PRIMARY KEY CLUSTERED 
(
	[Id_Cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServicioEmpresa]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicioEmpresa](
	[Id_Servicio_Empresa] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Fecha_Creacion] [date] NOT NULL,
	[Primer_Pago] [date] NULL,
	[Renovacion] [date] NOT NULL,
	[Id_Empresa] [int] NOT NULL,
	[Precio] [float] NOT NULL,
 CONSTRAINT [PK_ServicioEmpresa] PRIMARY KEY CLUSTERED 
(
	[Id_Servicio_Empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_ReportCuentas]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ReportCuentas]
AS
SELECT        dbo.ServicioEmpresa.Fecha_Creacion, dbo.ServicioEmpresa.Primer_Pago, dbo.ServicioEmpresa.Renovacion, dbo.ServicioEmpresa.Precio, dbo.Cuenta.Monto_Pendiente, dbo.Cuenta.Monto_Abono, dbo.Cuenta.Fecha_Pago, 
                         dbo.Empresa.Nombre, dbo.Empresa.Correo, dbo.Empresa.Cedula, dbo.Cuenta.Descripcion, dbo.Producto.Nombre AS Producto_Adquirido, dbo.ServicioEmpresa.Id_Servicio_Empresa
FROM            dbo.Cuenta INNER JOIN
                         dbo.ServicioEmpresa ON dbo.Cuenta.Servicio_Empresa = dbo.ServicioEmpresa.Id_Servicio_Empresa INNER JOIN
                         dbo.Empresa ON dbo.ServicioEmpresa.Id_Empresa = dbo.Empresa.Id_Empresa INNER JOIN
                         dbo.Producto ON dbo.ServicioEmpresa.Id_Producto = dbo.Producto.Id_Producto
GO
/****** Object:  Table [dbo].[Canton]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Canton](
	[Id_Canton] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Provincia] [int] NULL,
 CONSTRAINT [PK_Canton] PRIMARY KEY CLUSTERED 
(
	[Id_Canton] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacto]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacto](
	[Id_Contacto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Apellido1] [varchar](100) NULL,
	[Apellido2] [varchar](100) NULL,
	[Puesto] [varchar](100) NULL,
	[Id_Empresa] [int] NULL,
 CONSTRAINT [PK_Contacto] PRIMARY KEY CLUSTERED 
(
	[Id_Contacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacto_Correo]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacto_Correo](
	[Id_Contacto] [int] NOT NULL,
	[Id_Correo] [int] NOT NULL,
 CONSTRAINT [PK_Contacto_Correo] PRIMARY KEY CLUSTERED 
(
	[Id_Contacto] ASC,
	[Id_Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacto_Telefono]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacto_Telefono](
	[Id_Contacto] [int] NOT NULL,
	[Id_Telefono] [int] NOT NULL,
 CONSTRAINT [PK_Contacto_Telefono] PRIMARY KEY CLUSTERED 
(
	[Id_Contacto] ASC,
	[Id_Telefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Correo]    Script Date: 13/07/2019 4:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Correo](
	[Id_Correo] [int] IDENTITY(1,1) NOT NULL,
	[Direccion] [varchar](100) NULL,
 CONSTRAINT [PK_Correo] PRIMARY KEY CLUSTERED 
(
	[Id_Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distrito]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distrito](
	[Id_Distrito] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Canton] [int] NOT NULL,
 CONSTRAINT [PK_Distrito] PRIMARY KEY CLUSTERED 
(
	[Id_Distrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadodeCuenta]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadodeCuenta](
	[Id_Empresa] [int] NOT NULL,
	[Credito_Disponible] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_EstadodeCuenta_1] PRIMARY KEY CLUSTERED 
(
	[Id_Empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marketing]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marketing](
	[Id_Marketing] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Id_Empresa] [int] NOT NULL,
	[Sugerencia_Producto] [int] NOT NULL,
	[URL] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Marketing] PRIMARY KEY CLUSTERED 
(
	[Id_Marketing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedioPublicitario]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedioPublicitario](
	[Id_Medio_Publicitario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
 CONSTRAINT [PK_MedioPublicitario] PRIMARY KEY CLUSTERED 
(
	[Id_Medio_Publicitario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimiento]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimiento](
	[Id_Movimiento] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [varchar](100) NULL,
	[Monto] [float] NULL,
	[Detalle] [varchar](200) NULL,
	[Fecha] [date] NULL,
 CONSTRAINT [PK_Movimiento] PRIMARY KEY CLUSTERED 
(
	[Id_Movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[Id_Pais] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Pais] PRIMARY KEY CLUSTERED 
(
	[Id_Pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permiso]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permiso](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Eliminar] [bit] NOT NULL,
	[Crear] [bit] NOT NULL,
	[Editar] [bit] NOT NULL,
	[Mostrar] [bit] NOT NULL,
 CONSTRAINT [PK_Permiso] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermisoRol]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermisoRol](
	[Id_Rol] [int] NOT NULL,
	[Id_Permiso] [int] NOT NULL,
	[Modulo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PermisoRol] PRIMARY KEY CLUSTERED 
(
	[Id_Rol] ASC,
	[Id_Permiso] ASC,
	[Modulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[Id_Provincia] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
 CONSTRAINT [PK_Provincia] PRIMARY KEY CLUSTERED 
(
	[Id_Provincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publicidad]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publicidad](
	[Id_Publicidad] [int] IDENTITY(1,1) NOT NULL,
	[Medio] [int] NULL,
	[Id_empresa] [int] NOT NULL,
	[Fecha_Inicio] [date] NULL,
	[Fecha_Caducidad] [date] NULL,
	[Costo] [float] NULL,
 CONSTRAINT [PK_Publicidad] PRIMARY KEY CLUSTERED 
(
	[Id_Publicidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recordatorio]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recordatorio](
	[Id_Recordatorio] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [varchar](200) NULL,
	[Fecha] [date] NOT NULL,
	[Hora] [int] NULL,
	[Minutos] [int] NULL,
	[Abreviatura] [varchar](10) NOT NULL,
	[Detalle] [varchar](200) NOT NULL,
	[Id_empresa] [int] NULL,
	[Mensaje] [text] NOT NULL,
 CONSTRAINT [PK_Recordatorio] PRIMARY KEY CLUSTERED 
(
	[Id_Recordatorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Telefono]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Telefono](
	[Id_Telefono] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](8) NULL,
	[N_Telefonico] [int] NULL,
 CONSTRAINT [PK_Telefono] PRIMARY KEY CLUSTERED 
(
	[Id_Telefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/07/2019 4:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellido1] [varchar](100) NOT NULL,
	[Apellido2] [varchar](100) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Contraseña] [varchar](100) NOT NULL,
	[Fecha_Creacion] [date] NULL,
	[Id_Empresa] [int] NULL,
	[Id_Rol] [int] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Canton] ON 

INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (1, N'Abangares', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (2, N'Acosta ', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (3, N'Aguirre', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (4, N'Alajuela', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (5, N'Alajuelita', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (6, N'Alvarado ', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (7, N'Aserrí', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (8, N'Atenas', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (9, N'Bagaces ', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (10, N'Barva ', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (11, N'Belén', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (12, N'Buenos Aires', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (13, N'Cañas', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (14, N'Carrillo', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (15, N'Cartago', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (16, N'Corredores ', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (17, N'Coto Brus', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (18, N'Curridabat', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (19, N'Desamparados', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (20, N'Dota', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (21, N'El Guarco', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (22, N'Escazú', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (23, N'Esparza', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (24, N'Flores', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (25, N'Garabito', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (26, N'Goicoechea', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (27, N'Golfito', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (28, N'Grecia ', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (29, N'Guácimo', 6)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (30, N'Guatuso ', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (31, N'Heredia', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (32, N'Hojancha ', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (33, N'Jiménez', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (34, N'La Cruz ', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (35, N'La Unión', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (36, N'León Cortés', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (37, N'Liberia', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (38, N'Limón', 6)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (39, N'Los Chiles', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (40, N'Matina', 6)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (41, N'Montes de Oca', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (42, N'Montes de Oro', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (43, N'Mora', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (44, N'Moravia', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (45, N'Nandayure', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (46, N'Naranjo', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (47, N'Nicoya', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (48, N'Oreamuno', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (49, N'Orotina', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (50, N'Osa', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (51, N'Palmares', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (52, N'Paraíso', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (53, N'Parrita ', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (54, N'Pérez Zeledón', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (55, N'Poás', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (56, N'Pococí', 6)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (57, N'Puntarenas', 7)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (58, N'Puriscal', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (59, N'Río Cuarto', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (60, N'San Carlos', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (61, N' San Isidro', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (62, N'San José ', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (63, N'San Mateo', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (64, N'San Pablo', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (65, N'San Rafael', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (66, N'San Ramón', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (67, N'Santa Ana', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (68, N'Santa Bárbara', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (69, N'Santa Cruz', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (70, N'Santo Domingo', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (71, N'Sarapiquí ', 4)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (72, N'Siquirres', 6)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (73, N'Talamanca', 6)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (74, N'Tarrazú', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (75, N'Tibás', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (76, N'Tilarán ', 3)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (77, N'Turrialba ', 2)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (78, N'Turrubares ', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (79, N'Upala', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (80, N'Valverde Vega', 1)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (81, N'Vázquez de Coronado', 5)
INSERT [dbo].[Canton] ([Id_Canton], [Nombre], [Provincia]) VALUES (82, N'Zarcero', 1)
SET IDENTITY_INSERT [dbo].[Canton] OFF
SET IDENTITY_INSERT [dbo].[Contacto] ON 

INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (1, N'1', N'22', N'3', N'4', 2)
INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (2, N'a', N'asdf', N'asdf', N'asdf', 3)
INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (4, N'4', N'4', N'4', N'4', 1)
INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (5, N'uu', N'ju', N'hh', N'op', 3)
INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (6, N'dada', N'dada', N'dada', N'addd', 1)
INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (7, N'dfg', N'dfgd', N'dgfd', N'fgdfg', 1)
INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (8, N'asd', N'asd', N'asd', N'asd', 1)
INSERT [dbo].[Contacto] ([Id_Contacto], [Nombre], [Apellido1], [Apellido2], [Puesto], [Id_Empresa]) VALUES (10, N'juan', N'asda', N'asdasd', N'asdad', 1)
SET IDENTITY_INSERT [dbo].[Contacto] OFF
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (4, 1)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (4, 3)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (6, 1)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (6, 2)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (7, 17)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (7, 18)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (7, 19)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (8, 20)
INSERT [dbo].[Contacto_Correo] ([Id_Contacto], [Id_Correo]) VALUES (8, 21)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (4, 5)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (4, 6)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (4, 7)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (6, 8)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (6, 9)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (7, 19)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (7, 20)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (8, 21)
INSERT [dbo].[Contacto_Telefono] ([Id_Contacto], [Id_Telefono]) VALUES (10, 22)
SET IDENTITY_INSERT [dbo].[Correo] ON 

INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (1, N'asda@ss.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (2, N'h@h.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (3, N'qweq@gs.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (4, N'adasda')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (5, N'asdasd')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (6, N'adad@ss.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (7, N'adadd@gs.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (8, N'aaa@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (9, N'adad@ss.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (10, N'adadd@gs.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (11, N'aaa@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (12, N'zasd@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (13, N'zasd@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (14, N'zasd@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (15, N'zasd@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (16, N'zasd@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (17, N'adad@ss.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (18, N'adadd@gs.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (19, N'aaa@gmail.com')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (20, N'adasda')
INSERT [dbo].[Correo] ([Id_Correo], [Direccion]) VALUES (21, N'asdasd')
SET IDENTITY_INSERT [dbo].[Correo] OFF
SET IDENTITY_INSERT [dbo].[Cuenta] ON 

INSERT [dbo].[Cuenta] ([Id_Cuenta], [Servicio_Empresa], [Fecha_Pago], [Monto_Abono], [Monto_Pendiente], [Descripcion]) VALUES (2, 2, CAST(N'2019-06-21' AS Date), 50055, 500055, N'4545')
INSERT [dbo].[Cuenta] ([Id_Cuenta], [Servicio_Empresa], [Fecha_Pago], [Monto_Abono], [Monto_Pendiente], [Descripcion]) VALUES (3, 4, CAST(N'2019-06-20' AS Date), 5000, 5000, N'fdf')
INSERT [dbo].[Cuenta] ([Id_Cuenta], [Servicio_Empresa], [Fecha_Pago], [Monto_Abono], [Monto_Pendiente], [Descripcion]) VALUES (5, 2, CAST(N'2019-06-23' AS Date), 5000, 500, N'no ses')
SET IDENTITY_INSERT [dbo].[Cuenta] OFF
SET IDENTITY_INSERT [dbo].[Distrito] ON 

INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (1, N'San Rafael ', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (2, N'Carmen', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (3, N'Catedral', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (4, N'Hatillo', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (5, N'Hospital', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (6, N'Mata Redonda', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (7, N'Merced', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (8, N'Uruca', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (9, N'Zapote', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (10, N'Pavas', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (11, N'San Francisco de Dos Ríos', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (12, N'San Sebastián', 62)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (13, N'Escazú', 22)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (14, N'San Antonio', 22)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (15, N'San Rafael', 22)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (16, N'Desamparados', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (17, N'San Miguel', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (18, N'San Juan de Dios', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (19, N'San Rafael Arriba', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (20, N'San Antonio', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (21, N'Frailes', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (22, N'Patarrá', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (23, N'San Cristóbal', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (24, N'Rosario', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (25, N'Damas', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (26, N'San Rafael Abajo', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (27, N'Gravilias', 19)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (28, N'Santiago', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (29, N'Mercedes Sur', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (30, N'Barbacoas', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (31, N'Grifo Alto', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (32, N'San Rafael', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (33, N'Candelarita', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (34, N'Desamparaditos', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (35, N'San Antonio', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (36, N'Chires', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (37, N'La Cangreja', 58)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (38, N'San Marcos', 74)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (39, N'San Lorenzo', 74)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (40, N'San Carlos', 74)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (41, N'Aserrí', 7)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (42, N'Tarbaca o Praga', 7)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (43, N'Vuelta de Jorco', 7)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (44, N'San Gabriel', 7)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (45, N'La Legua', 7)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (46, N'Monterrey', 7)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (47, N'Salitrillos', 7)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (48, N'Ciudad Colón', 43)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (49, N'Guayabo', 43)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (50, N'Tabarcia', 43)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (51, N'Piedras Negras', 43)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (52, N'Picagres', 43)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (53, N'Jaris', 43)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (54, N'Quitirrisi', 43)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (55, N'Guadalupe', 26)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (56, N'San Francisco', 26)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (57, N'Calle Blancos', 26)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (58, N'Mata de Plátano', 26)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (59, N'Ipís', 26)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (60, N'Rancho Redondo', 26)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (61, N'Purral', 26)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (62, N'Santa Ana', 67)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (63, N'Salitral', 67)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (64, N'Pozos o Concepción', 67)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (65, N'Uruca o San Joaquín', 67)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (66, N'Piedades', 67)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (67, N'Brasil', 67)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (68, N'Alajuelita', 5)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (69, N'San Josecito', 5)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (70, N'San Antonio', 5)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (71, N'Concepción', 5)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (72, N'San Felipe', 5)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (73, N'San Isidro', 81)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (74, N'San Rafael', 81)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (75, N'Dulce Nombre o Jesús', 81)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (76, N'Patalillo', 81)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (77, N'Cascajal', 81)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (78, N'San Ignacio', 2)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (79, N'Guaitil', 2)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (80, N'Palmichal', 2)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (81, N'Cangrejal', 2)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (82, N'Sabanillas', 2)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (83, N'San Juan', 75)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (84, N'Cinco Esquinas', 75)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (85, N'Anselmo Llorente', 75)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (86, N'León XIII', 75)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (87, N'Colima', 75)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (88, N'San Vicente', 44)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (89, N'San Jerónimo', 44)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (90, N'La Trinidad', 44)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (91, N'San Pedro', 41)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (92, N'Sabanilla', 41)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (93, N'Mercedes o Betania', 41)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (94, N'San Rafael', 41)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (95, N'San Pablo', 78)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (96, N'San Pedro', 78)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (97, N'San Juan de Mata', 78)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (98, N'San Luis', 78)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (99, N'Carara', 78)
GO
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (100, N'Santa María', 20)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (101, N'Jardín', 20)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (102, N'Copey', 20)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (103, N'Curridabat', 18)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (104, N'Granadilla', 18)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (105, N'Sánchez', 18)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (106, N'Tirrases', 18)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (107, N'San Isidro de El General', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (108, N'General', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (109, N'Daniel Flores', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (110, N'Rivas', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (111, N'San Pedro', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (112, N'Platanares', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (113, N'Pejibaye', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (114, N'Carmen', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (115, N'Barú', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (116, N'Río Nuevo', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (117, N'Páramo', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (118, N'La Amistad', 54)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (119, N'San Pablo', 36)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (120, N'San Andrés', 36)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (121, N'Llano Bonito', 36)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (122, N'San Isidro', 36)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (123, N'Santa Cruz', 36)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (124, N'San Antonio', 36)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (125, N'Alajuela', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (126, N'San José', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (127, N'Carrizal', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (128, N'San Antonio', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (129, N'Guácima', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (130, N'San Isidro', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (131, N'Sabanilla', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (132, N'San Rafael', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (133, N'Río Segundo', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (134, N'Desamparados', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (135, N'Turrucares', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (136, N'Tambor', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (137, N'La Garita', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (138, N'Sarapiquí', 4)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (139, N'San Ramón', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (140, N'Santiago', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (141, N'San Juan', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (142, N'Piedades Norte', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (143, N'Piedades Sur', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (144, N'San Rafael', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (145, N'San Isidro', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (146, N'Angeles', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (147, N'Alfaro', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (148, N'Volio', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (149, N'Concepción', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (150, N'Zapotal', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (151, N'San Isidro de Peñas Blancas', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (152, N'San Lorenzo', 66)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (153, N'Grecia', 28)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (154, N'San Isidro', 28)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (155, N'San José', 28)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (156, N'San Roque', 28)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (157, N'Tacares', 28)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (158, N'Puente Piedra', 28)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (159, N'Bolívar', 28)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (160, N'San Mateo', 63)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (161, N'Desmonte', 63)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (162, N'Jesús María', 63)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (163, N'Labrador', 63)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (164, N'Atenas', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (165, N'Jesús', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (166, N'Mercedes', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (167, N'San Isidro', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (168, N'Concepción', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (169, N'San José', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (170, N'Santa Eulalia', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (171, N'Escobal', 8)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (172, N'Naranjo', 46)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (173, N'San Miguel', 46)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (174, N'San José', 46)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (175, N'Cirrí Sur', 46)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (176, N'San Jerónimo', 46)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (177, N'San Juan', 46)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (178, N'Rosario', 46)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (179, N'Palmares', 51)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (180, N'Zaragoza', 51)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (181, N'Buenos Aires', 51)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (182, N'Santiago', 51)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (183, N'Candelaria', 51)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (184, N'Esquipulas', 51)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (185, N'La Granja', 51)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (186, N'San Pedro', 55)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (187, N'San Juan', 55)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (188, N'San Rafael', 55)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (189, N'Carrillos', 55)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (190, N'Sabana Redonda', 55)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (191, N'Orotina', 49)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (192, N'Mastate', 49)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (193, N'Hacienda Vieja', 49)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (194, N'Coyolar', 49)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (195, N'Ceiba', 49)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (196, N'Quesada', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (197, N'Florencia', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (198, N'Buenavista', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (199, N'Aguas Zarcas', 60)
GO
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (200, N'Venecia', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (201, N'Pital', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (202, N'Fortuna', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (203, N'Tigra', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (204, N'Palmera', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (205, N'Venado', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (206, N'Cutris', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (207, N'Monterrey', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (208, N'Pocosol', 60)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (209, N'Zarcero', 82)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (210, N'Laguna', 82)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (211, N'Tapezco', 82)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (212, N'Guadalupe', 82)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (213, N'Palmira', 82)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (214, N'Zapote', 82)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (215, N'Brisas', 82)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (216, N'Sarchí Norte', 80)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (217, N'Sarchí Sur', 80)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (218, N'Toro Amarillo', 80)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (219, N'San Pedro', 80)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (220, N'Rodríguez', 80)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (221, N'Upala', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (222, N'Aguas Claras', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (223, N'San José o Pizote', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (224, N'Bijagua', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (225, N'Delicias', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (226, N'Dos Ríos', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (227, N'Yolillal', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (228, N'Canalete', 79)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (229, N'Los Chiles', 39)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (230, N'Caño Negro', 39)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (231, N'Amparo', 39)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (232, N'San Jorge', 39)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (233, N'San Rafael', 30)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (234, N'Buenavista', 30)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (235, N'Cote', 30)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (236, N'Katira', 30)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (237, N'Rio Cuarto', 59)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (238, N'Oriental', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (239, N'Occidental', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (240, N'Carmen', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (241, N'San Nicolás', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (242, N'Aguacaliente', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (243, N'Guadalupe', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (244, N'Corralillo', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (245, N'Tierra Blanca', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (246, N'Dulce Nombre', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (247, N'Llano Grande', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (248, N'Quebradilla', 15)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (249, N'Paraíso', 52)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (250, N'Santiago', 52)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (251, N'Orosi', 52)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (252, N'Cachí', 52)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (253, N'Llanos de Sta Lucia', 52)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (254, N'Tres Ríos', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (255, N'San Diego', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (256, N'San Juan', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (257, N'San Rafael', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (258, N'Concepción', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (259, N'Dulce Nombre', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (260, N'San Ramón', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (261, N'Río Azul', 35)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (262, N'Juan Viñas', 33)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (263, N'Tucurrique', 33)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (264, N'Pejibaye', 33)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (265, N'Turrialba', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (266, N'La Suiza', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (267, N'Peralta', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (268, N'Santa Cruz', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (269, N'Santa Teresita', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (270, N'Pavones', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (271, N'Tuis', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (272, N'Tayutic', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (273, N'Santa Rosa', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (274, N'Tres Equis', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (275, N'La Isabel', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (276, N'Chirripo', 77)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (277, N'Pacayas', 6)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (278, N'Cervantes', 6)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (279, N'Capellades', 6)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (280, N'San Rafael', 48)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (281, N'Cot', 48)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (282, N'Potrero Cerrado', 48)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (283, N'Cipreses', 48)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (284, N'Santa Rosa', 48)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (285, N'El Tejar', 21)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (286, N'San Isidro', 21)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (287, N'Tobosi', 21)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (288, N'Patio de Agua', 21)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (289, N'Heredia', 31)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (290, N'Mercedes', 31)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (291, N'San Francisco', 31)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (292, N'Ulloa', 31)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (293, N'Vara Blanca', 31)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (294, N'Barva', 10)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (295, N'San Pedro', 10)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (296, N'San Pablo', 10)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (297, N'San Roque', 10)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (298, N'Santa Lucía', 10)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (299, N'San José de la Montaña', 10)
GO
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (300, N'Santo Domingo', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (301, N'San Vicente', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (302, N'San Miguel', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (303, N'Paracito', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (304, N'Santo Tomás', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (305, N'Santa Rosa', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (306, N'Tures', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (307, N'Pará', 70)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (308, N'Santa Bárbara', 68)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (309, N'San Pedro', 68)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (310, N'San Juan', 68)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (311, N'Jesús', 68)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (312, N'Santo Domingo del Roble', 68)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (313, N'Puraba', 68)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (314, N'San Rafael', 65)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (315, N'San Josecito', 65)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (316, N'Santiago', 65)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (317, N'Angeles', 65)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (318, N'Concepción', 65)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (319, N'San Isidro', 61)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (320, N'San José', 61)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (321, N'Concepción', 61)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (322, N'San Francisco', 61)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (323, N'San Antonio', 11)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (324, N'La Rivera', 11)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (325, N'Asunción', 11)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (326, N'San Joaquín', 24)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (327, N'Barrantes', 24)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (328, N'Llorente', 24)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (329, N'San Pablo', 64)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (330, N'Rincon de Sabanilla', 64)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (331, N'Puerto Viejo', 71)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (332, N'La Virgen', 71)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (333, N'Horquetas', 71)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (334, N'Llanuras del Gaspar', 71)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (335, N'Cureña', 71)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (336, N'Liberia', 37)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (337, N'Cañas Dulces', 37)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (338, N'Mayorga', 37)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (339, N'Nacascolo', 37)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (340, N'Curubande', 37)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (341, N'Nicoya', 47)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (342, N'Mansión', 47)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (343, N'San Antonio', 47)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (344, N'Quebrada Honda', 47)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (345, N'Sámara', 47)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (346, N'Nosara', 47)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (347, N'Belén de Nosarita', 47)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (348, N'Santa Cruz', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (349, N'Bolsón', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (350, N'Veintisiete de Abril', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (351, N'Tempate', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (352, N'Cartagena', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (353, N'Cuajiniquil', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (354, N'Diriá', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (355, N'Cabo Velas', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (356, N'Tamarindo', 69)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (357, N'Bagaces', 9)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (358, N'Fortuna', 9)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (359, N'Mogote', 9)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (360, N'Río Naranjo', 9)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (361, N'Filadelfia', 14)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (362, N'Palmira', 14)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (363, N'Sardinal', 14)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (364, N'Belén', 14)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (365, N'Cañas', 13)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (366, N'Palmira', 13)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (367, N'San Miguel', 13)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (368, N'Bebedero', 13)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (369, N'Porozal', 13)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (370, N'Juntas', 1)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (371, N'Sierra', 1)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (372, N'San Juan', 1)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (373, N'Colorado', 1)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (374, N'Tilarán', 76)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (375, N'Quebrada Grande', 76)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (376, N'Tronadora', 76)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (377, N'Santa Rosa', 76)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (378, N'Líbano', 76)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (379, N'Tierras Morenas', 76)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (380, N'Arenal', 76)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (381, N'Carmona', 45)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (382, N'Santa Rita', 45)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (383, N'Zapotal', 45)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (384, N'San Pablo', 45)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (385, N'Porvenir', 45)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (386, N'Bejuco', 45)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (387, N'La Cruz', 34)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (388, N'Santa Cecilia', 34)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (389, N'Garita', 34)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (390, N'Santa Elena', 34)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (391, N'Hojancha', 32)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (392, N'Monte Romo', 32)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (393, N'Puerto Carrillo', 32)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (394, N'Huacas', 32)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (396, N'Puntarenas', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (397, N'Pitahaya', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (398, N'Chomes', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (399, N'Lepanto', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (400, N'Paquera', 57)
GO
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (401, N'Manzanillo', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (402, N'Guacimal', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (403, N'Barranca', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (404, N'Monte Verde', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (405, N'Isla del Coco', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (406, N'Cóbano', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (407, N'Chacarita', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (408, N'Chira (Isla)', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (409, N'Acapulco', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (410, N'El Roble', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (411, N'Arancibia', 57)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (412, N'Espíritu Santo', 23)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (413, N'San Juan Grande', 23)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (414, N'Macacona', 23)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (415, N'San Rafael', 23)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (416, N'San Jerónimo', 23)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (417, N'Caldera', 23)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (418, N'Buenos Aires', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (419, N'Volcán', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (420, N'Potrero Grande', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (421, N'Boruca', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (422, N'Pilas', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (423, N'Colinas o Bajo de Maíz', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (424, N'Chánguena', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (425, N'Biolley', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (426, N'Brunka', 12)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (427, N'Miramar', 42)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (428, N'Unión', 42)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (429, N'San Isidro', 42)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (430, N'Ciudad Cortés', 50)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (431, N'Palmar', 50)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (432, N'Sierpe', 50)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (433, N'Bahía Ballena', 50)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (434, N'Piedras Blancas', 50)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (435, N'Bahia Drake', 50)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (436, N'Quepos', 3)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (437, N'Savegre', 3)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (438, N'Naranjito', 3)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (439, N'Golfito', 27)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (440, N'Puerto Jiménez', 27)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (441, N'Guaycará', 27)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (442, N'Pavones', 27)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (443, N'San Vito', 17)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (444, N'Sabalito', 17)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (445, N'Agua Buena', 17)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (446, N'Limoncito', 17)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (447, N'Pittier', 17)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (448, N'Gutierrez Brown', 17)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (449, N'Parrita', 53)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (450, N'Corredores', 16)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (451, N'La Cuesta', 16)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (452, N'Paso Canoas', 16)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (453, N'Laurel', 16)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (454, N'Jacó', 25)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (455, N'Tárcoles', 25)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (456, N'Limón', 38)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (457, N'Valle  La Estrella', 38)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (458, N'Río Blanco', 38)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (459, N'Matama', 38)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (460, N'Guápiles', 56)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (461, N'Jiménez', 56)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (462, N'Rita', 56)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (463, N'Roxana', 56)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (464, N'Cariari', 56)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (465, N'Colorado', 56)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (466, N'La Colonia', 56)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (467, N'Siquirres', 72)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (468, N'Pacuarito', 72)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (469, N'Florida', 72)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (470, N'Germania', 72)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (471, N'Cairo', 72)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (472, N'Alegría', 72)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (473, N'Bratsi', 73)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (474, N'Sixaola', 73)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (475, N'Cahuita', 73)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (476, N'Telire', 73)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (477, N'Matina', 40)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (478, N'Batán', 40)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (479, N'Carrandí', 40)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (480, N'Guácimo', 29)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (481, N'Mercedes', 29)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (482, N'Pocora', 29)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (483, N'Río Jiménez', 29)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (484, N'Duacarí', 29)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (485, N'Río Jiménez', 29)
INSERT [dbo].[Distrito] ([Id_Distrito], [Nombre], [Canton]) VALUES (486, N'Palmitos', 46)
SET IDENTITY_INSERT [dbo].[Distrito] OFF
SET IDENTITY_INSERT [dbo].[Empresa] ON 

INSERT [dbo].[Empresa] ([Id_Empresa], [Nombre], [Correo], [Cedula], [Id_Pais], [Id_Provincia], [Id_Canton], [Id_Distrito], [Otras_Señas], [Codigo_Postal], [Tipo_Cedula]) VALUES (1, N'Empresa', N'davidcamposch@gmail.com', N'12345', 48, 1, 1, 1, N'calle 25', 506, N'Fisica')
INSERT [dbo].[Empresa] ([Id_Empresa], [Nombre], [Correo], [Cedula], [Id_Pais], [Id_Provincia], [Id_Canton], [Id_Distrito], [Otras_Señas], [Codigo_Postal], [Tipo_Cedula]) VALUES (2, N'palmer', N'p@p.com', N'123', 48, 1, 15, 17, N'calle 2', 234, N'Juridica')
INSERT [dbo].[Empresa] ([Id_Empresa], [Nombre], [Correo], [Cedula], [Id_Pais], [Id_Provincia], [Id_Canton], [Id_Distrito], [Otras_Señas], [Codigo_Postal], [Tipo_Cedula]) VALUES (3, N'Empresa2', N'em@em.com', N'234', 48, 1, 1, 1, N'calle 2', 506, N'Fisica')
INSERT [dbo].[Empresa] ([Id_Empresa], [Nombre], [Correo], [Cedula], [Id_Pais], [Id_Provincia], [Id_Canton], [Id_Distrito], [Otras_Señas], [Codigo_Postal], [Tipo_Cedula]) VALUES (4, N'nose', N'da@gmail.com', N'4545454', 2, 1, 1, 1, N'asd', 454, N'Juridica')
SET IDENTITY_INSERT [dbo].[Empresa] OFF
INSERT [dbo].[EstadodeCuenta] ([Id_Empresa], [Credito_Disponible]) VALUES (1, CAST(70000.00 AS Decimal(18, 2)))
INSERT [dbo].[EstadodeCuenta] ([Id_Empresa], [Credito_Disponible]) VALUES (2, CAST(-50000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Marketing] ON 

INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (4, 1, 1, 3, N'https://msdn.microsoft.com/es-es/')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (5, 3, 2, 4, N'www.charksd.com')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (6, 3, 2, 4, N'www.charksd.com')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (7, 3, 2, 4, N'www.charksd.com')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (8, 3, 2, 4, N'www.charksd.com')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (9, 3, 2, 4, N'www.charksd.com')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (10, 3, 2, 4, N'www.charksd.com')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (11, 3, 2, 4, N'www.charksd.com')
INSERT [dbo].[Marketing] ([Id_Marketing], [Id_Producto], [Id_Empresa], [Sugerencia_Producto], [URL]) VALUES (12, 1, 1, 3, N'www.ter.com')
SET IDENTITY_INSERT [dbo].[Marketing] OFF
SET IDENTITY_INSERT [dbo].[MedioPublicitario] ON 

INSERT [dbo].[MedioPublicitario] ([Id_Medio_Publicitario], [Nombre]) VALUES (1, N'Email')
INSERT [dbo].[MedioPublicitario] ([Id_Medio_Publicitario], [Nombre]) VALUES (2, N'Facebook')
SET IDENTITY_INSERT [dbo].[MedioPublicitario] OFF
SET IDENTITY_INSERT [dbo].[Movimiento] ON 

INSERT [dbo].[Movimiento] ([Id_Movimiento], [Tipo], [Monto], [Detalle], [Fecha]) VALUES (1, N'Pago', 5000, N'Pago adelantado', NULL)
INSERT [dbo].[Movimiento] ([Id_Movimiento], [Tipo], [Monto], [Detalle], [Fecha]) VALUES (2, N'2', 213, N's', CAST(N'2019-01-01' AS Date))
INSERT [dbo].[Movimiento] ([Id_Movimiento], [Tipo], [Monto], [Detalle], [Fecha]) VALUES (3, N'1', 1, N'1', CAST(N'2019-01-01' AS Date))
INSERT [dbo].[Movimiento] ([Id_Movimiento], [Tipo], [Monto], [Detalle], [Fecha]) VALUES (4, N'Abono', 500, N'abono', CAST(N'2019-04-23' AS Date))
INSERT [dbo].[Movimiento] ([Id_Movimiento], [Tipo], [Monto], [Detalle], [Fecha]) VALUES (5, N'Gasto', 899, N'asfd', CAST(N'2014-03-06' AS Date))
SET IDENTITY_INSERT [dbo].[Movimiento] OFF
SET IDENTITY_INSERT [dbo].[Pais] ON 

INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (2, N'Afganistán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (3, N'Albania   ')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (4, N'Alemania  ')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (5, N'Andorra   ')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (6, N'Angola    ')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (7, N'Antigua y Barbuda')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (8, N'Arabia Saudita')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (9, N'Argentina')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (10, N'Argentina')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (11, N'Armenia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (12, N'Australia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (13, N'Austria')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (14, N'Azerbaiyán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (15, N'Bahamas')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (16, N'Bangladés')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (17, N'Barbados')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (18, N'Baréin')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (19, N'Bélgica')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (20, N'Belice')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (21, N'Benín')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (22, N'Bielorrusia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (23, N'Birmania')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (24, N'Bolivia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (25, N'Bosnia y Herzegovina')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (26, N'Botsuana')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (27, N'Brasil')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (28, N'Brunéi')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (29, N'Bulgaria')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (30, N'Burkina Faso')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (31, N'Burundi')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (32, N'Bután')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (33, N'Cabo Verde')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (34, N'Camboya')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (35, N'Camerún')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (36, N'Canadá')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (37, N'Catar')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (38, N'Chad')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (39, N'Chile')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (40, N'China')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (41, N'Chipre')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (42, N'Ciudad del Vaticano')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (43, N'Colombia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (44, N'Comoras')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (45, N'Corea del Norte')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (46, N'Corea del Sur')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (47, N'Costa de Marfil')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (48, N'Costa Rica')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (49, N'Croacia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (50, N'Cuba')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (51, N'Dinamarca')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (52, N'Dominica')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (53, N'Ecuador')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (54, N'Egipto')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (55, N'El Salvador')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (56, N'Emiratos Árabes Unidos')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (57, N'Eritrea')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (58, N'Eslovaquia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (59, N'Eslovenia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (60, N'España')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (61, N'Estados Unidos')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (62, N'Estonia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (63, N'Etiopía')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (64, N'Filipinas')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (65, N'Finlandia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (66, N'Fiyi')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (67, N'Francia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (68, N'Gabón')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (69, N'Gambia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (70, N'Georgia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (71, N'Ghana')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (72, N'Granada')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (73, N'Grecia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (74, N'Guatemala')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (75, N'Guyana')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (76, N'Guinea')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (77, N'Guinea ecuatorial')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (78, N'Guinea-Bisáu')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (79, N'Haití')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (80, N'Honduras')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (81, N'Hungría')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (82, N'India')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (83, N'Indonesia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (84, N'Irak')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (85, N'Irán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (86, N'Irlanda')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (87, N'Islandia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (88, N'Islas Marshall')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (89, N'Islas Salomón')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (90, N'Israel')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (91, N'Italia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (92, N'Jamaica')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (93, N'Japón')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (94, N'Jordania')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (95, N'Kazajistán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (96, N'Kenia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (97, N'Kirguistán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (98, N'Kiribati')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (99, N'Kuwait')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (100, N'Laos')
GO
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (101, N'Lesoto')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (102, N'Letonia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (103, N'Líbano')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (104, N'Liberia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (105, N'Libia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (106, N'Liechtenstein')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (107, N'Lituania')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (108, N'Luxemburgo')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (109, N'Madagascar')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (110, N'Malasia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (111, N'Malaui')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (112, N'Maldivas')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (113, N'Malí')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (114, N'Malta')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (115, N'Marruecos')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (116, N'Mauricio')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (117, N'Mauritania')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (118, N'México')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (119, N'Micronesia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (120, N'Moldavia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (121, N'Mónaco')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (122, N'Mongolia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (123, N'Montenegro')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (124, N'Mozambique')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (125, N'Namibia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (126, N'Nauru')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (127, N'Nepal')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (128, N'Nicaragua')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (129, N'Níger')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (130, N'Nigeria')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (131, N'Noruega')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (132, N'Nueva Zelanda')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (133, N'Omán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (134, N'Países Bajos')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (135, N'Pakistán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (136, N'Palaos')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (137, N'Panamá')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (138, N'Papúa Nueva Guinea')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (139, N'Paraguay')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (140, N'Perú')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (141, N'Polonia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (142, N'Portugal')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (143, N'Reino Unido')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (144, N'República Centroafricana')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (145, N'República Checa')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (146, N'República de Macedonia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (147, N'República del Congo')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (148, N'República Democrática del Congo')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (149, N'República Dominicana')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (150, N'República Sudafricana')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (151, N'Ruanda')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (152, N'Rumanía')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (153, N'Rusia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (154, N'Samoa')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (155, N'San Cristóbal y Nieves')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (156, N'San Marino')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (157, N'San Vicente y las Granadinas')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (158, N'Santa Lucía')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (159, N'Santo Tomé y Príncipe')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (160, N'Senegal')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (161, N'Serbia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (162, N'Seychelles')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (163, N'Sierra Leona')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (164, N'Singapur')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (165, N'Siria')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (166, N'Somalia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (167, N'Sri Lanka')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (168, N'Suazilandia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (169, N'Sudán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (170, N'Sudán del Sur')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (171, N'Suecia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (172, N'Suiza')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (173, N'Surinam')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (174, N'Tailandia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (175, N'Tanzania')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (176, N'Tayikistán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (177, N'Timor Oriental')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (178, N'Togo')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (179, N'Tonga')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (180, N'Trinidad y Tobago')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (181, N'Túnez')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (182, N'Turkmenistán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (183, N'Turquía')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (184, N'Tuvalu')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (185, N'Ucrania')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (186, N'Uganda')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (187, N'Uruguay')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (188, N'Uzbekistán')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (189, N'Vanuatu')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (190, N'Venezuela')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (191, N'Vietnam')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (192, N'Yemen')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (193, N'Yibuti')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (194, N'Zambia')
INSERT [dbo].[Pais] ([Id_Pais], [Nombre]) VALUES (195, N'Zimbabue')
SET IDENTITY_INSERT [dbo].[Pais] OFF
SET IDENTITY_INSERT [dbo].[Permiso] ON 

INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (1, 0, 0, 0, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (2, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (3, 0, 0, 1, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (4, 0, 0, 1, 1)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (5, 0, 1, 0, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (6, 0, 1, 0, 1)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (7, 0, 1, 1, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (8, 0, 1, 1, 1)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (9, 1, 0, 0, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (10, 1, 0, 0, 1)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (11, 1, 0, 1, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (12, 1, 0, 1, 1)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (13, 1, 1, 0, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (14, 1, 1, 0, 1)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (15, 1, 1, 1, 0)
INSERT [dbo].[Permiso] ([Id], [Eliminar], [Crear], [Editar], [Mostrar]) VALUES (16, 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Permiso] OFF
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Contactoes')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Contactoes-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Empresas')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Empresas-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'EstadodeCuentas')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'EstadodeCuentas-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Marketings')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Marketings-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'MedioPublicitarios')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'MedioPublicitarios-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Movimientoes')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Movimientoes-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Productoes')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Productoes-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Publicidads')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Publicidads-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Recordatorios')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Recordatorios-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Recordatorios-RecordatoriosDia')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Report-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Rols')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Rols-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'ServicioEmpresas')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'ServicioEmpresas-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'ServiciosContratados-Details')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'ServiciosContratados-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Usuarios')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (1, 16, N'Usuarios-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Contactoes')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Contactoes-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Empresas')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Empresas-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'EstadodeCuentas')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'EstadodeCuentas-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Marketings')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Marketings-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'MedioPublicitarios')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'MedioPublicitarios-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Movimientoes')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Movimientoes-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Productoes')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Productoes-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Publicidads')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Publicidads-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Recordatorios')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Recordatorios-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Recordatorios-RecordatoriosDia')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Report-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Rols')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Rols-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'ServicioEmpresas')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'ServicioEmpresas-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 1, N'Usuarios-Index')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 2, N'Usuarios')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 16, N'ServiciosContratados-Details')
INSERT [dbo].[PermisoRol] ([Id_Rol], [Id_Permiso], [Modulo]) VALUES (2, 16, N'ServiciosContratados-Index')
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([Id_Producto], [Nombre], [Codigo], [Tipo_Producto]) VALUES (1, N'1', N'1', N'1')
INSERT [dbo].[Producto] ([Id_Producto], [Nombre], [Codigo], [Tipo_Producto]) VALUES (2, N'Producto 1', N'Ac', N'Producto')
INSERT [dbo].[Producto] ([Id_Producto], [Nombre], [Codigo], [Tipo_Producto]) VALUES (3, N'Publicidad', N'PR', N'Servicio')
INSERT [dbo].[Producto] ([Id_Producto], [Nombre], [Codigo], [Tipo_Producto]) VALUES (4, N'charlas', N'ch', N'Servicio')
SET IDENTITY_INSERT [dbo].[Producto] OFF
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([Id_Provincia], [Nombre]) VALUES (1, N'Alajuela')
INSERT [dbo].[Provincia] ([Id_Provincia], [Nombre]) VALUES (2, N'Cartago')
INSERT [dbo].[Provincia] ([Id_Provincia], [Nombre]) VALUES (3, N'Guanacaste')
INSERT [dbo].[Provincia] ([Id_Provincia], [Nombre]) VALUES (4, N'Heredia')
INSERT [dbo].[Provincia] ([Id_Provincia], [Nombre]) VALUES (5, N'San José')
INSERT [dbo].[Provincia] ([Id_Provincia], [Nombre]) VALUES (6, N'Limón')
INSERT [dbo].[Provincia] ([Id_Provincia], [Nombre]) VALUES (7, N'Puntarenas')
SET IDENTITY_INSERT [dbo].[Provincia] OFF
SET IDENTITY_INSERT [dbo].[Publicidad] ON 

INSERT [dbo].[Publicidad] ([Id_Publicidad], [Medio], [Id_empresa], [Fecha_Inicio], [Fecha_Caducidad], [Costo]) VALUES (2, 2, 1, CAST(N'2019-06-18' AS Date), CAST(N'2019-07-01' AS Date), 40000)
INSERT [dbo].[Publicidad] ([Id_Publicidad], [Medio], [Id_empresa], [Fecha_Inicio], [Fecha_Caducidad], [Costo]) VALUES (4, 1, 2, CAST(N'2019-07-11' AS Date), CAST(N'2019-07-19' AS Date), 50000)
SET IDENTITY_INSERT [dbo].[Publicidad] OFF
SET IDENTITY_INSERT [dbo].[Recordatorio] ON 

INSERT [dbo].[Recordatorio] ([Id_Recordatorio], [Tipo], [Fecha], [Hora], [Minutos], [Abreviatura], [Detalle], [Id_empresa], [Mensaje]) VALUES (4, N'323', CAST(N'2019-06-30' AS Date), 11, 11, N'er', N'fsdf', 1, N'sdf
sdf
sdf
s
s
ss')
INSERT [dbo].[Recordatorio] ([Id_Recordatorio], [Tipo], [Fecha], [Hora], [Minutos], [Abreviatura], [Detalle], [Id_empresa], [Mensaje]) VALUES (5, N'nose', CAST(N'2019-07-12' AS Date), 11, 11, N'revor', N'sdfsdf', 2, N'sdfsd fsdc
sdc
sdc

sdc')
SET IDENTITY_INSERT [dbo].[Recordatorio] OFF
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([Id], [Nombre]) VALUES (1, N'Administrador')
INSERT [dbo].[Rol] ([Id], [Nombre]) VALUES (2, N'Usuario')
SET IDENTITY_INSERT [dbo].[Rol] OFF
SET IDENTITY_INSERT [dbo].[ServicioEmpresa] ON 

INSERT [dbo].[ServicioEmpresa] ([Id_Servicio_Empresa], [Id_Producto], [Descripcion], [Fecha_Creacion], [Primer_Pago], [Renovacion], [Id_Empresa], [Precio]) VALUES (2, 1, N'1', CAST(N'2019-10-04' AS Date), CAST(N'2019-11-04' AS Date), CAST(N'2019-12-04' AS Date), 1, 1)
INSERT [dbo].[ServicioEmpresa] ([Id_Servicio_Empresa], [Id_Producto], [Descripcion], [Fecha_Creacion], [Primer_Pago], [Renovacion], [Id_Empresa], [Precio]) VALUES (4, 3, N'publicidad para plamer', CAST(N'2019-07-01' AS Date), CAST(N'2019-07-07' AS Date), CAST(N'2019-07-31' AS Date), 2, 59000)
SET IDENTITY_INSERT [dbo].[ServicioEmpresa] OFF
SET IDENTITY_INSERT [dbo].[Telefono] ON 

INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (5, N'506', 54454544)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (6, N'506', 65656654)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (7, N'506', 33565335)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (8, N'506', 45345343)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (9, N'506', 76786756)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (10, N'aaa', 44545444)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (11, N'506', 45454545)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (12, N'506', 12121212)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (13, N'506', 45454545)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (14, N'506', 12121212)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (15, N'(506)', 11111111)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (16, N'(506)', 444444444)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (17, N'(506)', 45454545)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (18, N'(506)', 45454545)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (19, N'506', 45454545)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (20, N'(506)', 11111111)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (21, N'(506)', 44545444)
INSERT [dbo].[Telefono] ([Id_Telefono], [Codigo], [N_Telefonico]) VALUES (22, N'(506)', NULL)
SET IDENTITY_INSERT [dbo].[Telefono] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([Id_Usuario], [Nombre], [Apellido1], [Apellido2], [Correo], [Contraseña], [Fecha_Creacion], [Id_Empresa], [Id_Rol]) VALUES (1, N'josue', N'dsf', N'sdfsf', N'a@a.com', N'LCbWZqu8CwGN+W/FN4/3qw==', CAST(N'2019-07-12' AS Date), 1, 2)
INSERT [dbo].[Usuario] ([Id_Usuario], [Nombre], [Apellido1], [Apellido2], [Correo], [Contraseña], [Fecha_Creacion], [Id_Empresa], [Id_Rol]) VALUES (2, N'administrador', N'admin', N'admin', N'admin@gmail.com', N'3leSgH333GSyE9NUFfFt3Q==', CAST(N'2019-06-12' AS Date), 1, 1)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_Nombre_Rol]    Script Date: 13/07/2019 4:19:16 ******/
ALTER TABLE [dbo].[Rol] ADD  CONSTRAINT [Unique_Nombre_Rol] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Permiso] ADD  CONSTRAINT [DF_Permiso_Eliminar]  DEFAULT ((0)) FOR [Eliminar]
GO
ALTER TABLE [dbo].[Permiso] ADD  CONSTRAINT [DF_Permiso_Crear]  DEFAULT ((0)) FOR [Crear]
GO
ALTER TABLE [dbo].[Permiso] ADD  CONSTRAINT [DF_Permiso_Editar]  DEFAULT ((0)) FOR [Editar]
GO
ALTER TABLE [dbo].[Permiso] ADD  CONSTRAINT [DF_Permiso_Mostrar]  DEFAULT ((0)) FOR [Mostrar]
GO
ALTER TABLE [dbo].[Telefono] ADD  CONSTRAINT [DF_Telefono_Codigo]  DEFAULT ((506)) FOR [Codigo]
GO
ALTER TABLE [dbo].[Telefono] ADD  CONSTRAINT [DF_Telefono_N_Telefonico]  DEFAULT ((0)) FOR [N_Telefonico]
GO
ALTER TABLE [dbo].[Canton]  WITH CHECK ADD  CONSTRAINT [FK_Canton_Canton] FOREIGN KEY([Provincia])
REFERENCES [dbo].[Provincia] ([Id_Provincia])
GO
ALTER TABLE [dbo].[Canton] CHECK CONSTRAINT [FK_Canton_Canton]
GO
ALTER TABLE [dbo].[Contacto]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Empresa] FOREIGN KEY([Id_Empresa])
REFERENCES [dbo].[Empresa] ([Id_Empresa])
GO
ALTER TABLE [dbo].[Contacto] CHECK CONSTRAINT [FK_Contacto_Empresa]
GO
ALTER TABLE [dbo].[Contacto_Correo]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Correo_Contacto] FOREIGN KEY([Id_Contacto])
REFERENCES [dbo].[Contacto] ([Id_Contacto])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contacto_Correo] CHECK CONSTRAINT [FK_Contacto_Correo_Contacto]
GO
ALTER TABLE [dbo].[Contacto_Correo]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Correo_Correo] FOREIGN KEY([Id_Correo])
REFERENCES [dbo].[Correo] ([Id_Correo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contacto_Correo] CHECK CONSTRAINT [FK_Contacto_Correo_Correo]
GO
ALTER TABLE [dbo].[Contacto_Telefono]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Telefono_Contacto] FOREIGN KEY([Id_Contacto])
REFERENCES [dbo].[Contacto] ([Id_Contacto])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contacto_Telefono] CHECK CONSTRAINT [FK_Contacto_Telefono_Contacto]
GO
ALTER TABLE [dbo].[Contacto_Telefono]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Telefono_Telefono] FOREIGN KEY([Id_Telefono])
REFERENCES [dbo].[Telefono] ([Id_Telefono])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contacto_Telefono] CHECK CONSTRAINT [FK_Contacto_Telefono_Telefono]
GO
ALTER TABLE [dbo].[Cuenta]  WITH CHECK ADD  CONSTRAINT [FK_Cuenta_ServicioEmpresa] FOREIGN KEY([Servicio_Empresa])
REFERENCES [dbo].[ServicioEmpresa] ([Id_Servicio_Empresa])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cuenta] CHECK CONSTRAINT [FK_Cuenta_ServicioEmpresa]
GO
ALTER TABLE [dbo].[Distrito]  WITH CHECK ADD  CONSTRAINT [FK_Distrito_Canton] FOREIGN KEY([Canton])
REFERENCES [dbo].[Canton] ([Id_Canton])
GO
ALTER TABLE [dbo].[Distrito] CHECK CONSTRAINT [FK_Distrito_Canton]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Canton] FOREIGN KEY([Id_Canton])
REFERENCES [dbo].[Canton] ([Id_Canton])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Canton]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Distrito] FOREIGN KEY([Id_Distrito])
REFERENCES [dbo].[Distrito] ([Id_Distrito])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Distrito]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Pais] FOREIGN KEY([Id_Pais])
REFERENCES [dbo].[Pais] ([Id_Pais])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Pais]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Provincia] FOREIGN KEY([Id_Provincia])
REFERENCES [dbo].[Provincia] ([Id_Provincia])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Provincia]
GO
ALTER TABLE [dbo].[EstadodeCuenta]  WITH CHECK ADD  CONSTRAINT [FK_EstadodeCuenta_Empresa1] FOREIGN KEY([Id_Empresa])
REFERENCES [dbo].[Empresa] ([Id_Empresa])
GO
ALTER TABLE [dbo].[EstadodeCuenta] CHECK CONSTRAINT [FK_EstadodeCuenta_Empresa1]
GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD  CONSTRAINT [FK_Marketing_Empresa] FOREIGN KEY([Id_Empresa])
REFERENCES [dbo].[Empresa] ([Id_Empresa])
GO
ALTER TABLE [dbo].[Marketing] CHECK CONSTRAINT [FK_Marketing_Empresa]
GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD  CONSTRAINT [FK_Marketing_Producto] FOREIGN KEY([Id_Producto])
REFERENCES [dbo].[Producto] ([Id_Producto])
GO
ALTER TABLE [dbo].[Marketing] CHECK CONSTRAINT [FK_Marketing_Producto]
GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD  CONSTRAINT [FK_Marketing_Producto1] FOREIGN KEY([Sugerencia_Producto])
REFERENCES [dbo].[Producto] ([Id_Producto])
GO
ALTER TABLE [dbo].[Marketing] CHECK CONSTRAINT [FK_Marketing_Producto1]
GO
ALTER TABLE [dbo].[PermisoRol]  WITH CHECK ADD  CONSTRAINT [FK_PermisoRol_Permiso] FOREIGN KEY([Id_Permiso])
REFERENCES [dbo].[Permiso] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PermisoRol] CHECK CONSTRAINT [FK_PermisoRol_Permiso]
GO
ALTER TABLE [dbo].[PermisoRol]  WITH CHECK ADD  CONSTRAINT [FK_PermisoRol_Rol] FOREIGN KEY([Id_Rol])
REFERENCES [dbo].[Rol] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PermisoRol] CHECK CONSTRAINT [FK_PermisoRol_Rol]
GO
ALTER TABLE [dbo].[Publicidad]  WITH CHECK ADD  CONSTRAINT [FK_Publicidad_Empresa] FOREIGN KEY([Id_empresa])
REFERENCES [dbo].[Empresa] ([Id_Empresa])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Publicidad] CHECK CONSTRAINT [FK_Publicidad_Empresa]
GO
ALTER TABLE [dbo].[Publicidad]  WITH CHECK ADD  CONSTRAINT [FK_Publicidad_MedioPublicitario] FOREIGN KEY([Medio])
REFERENCES [dbo].[MedioPublicitario] ([Id_Medio_Publicitario])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Publicidad] CHECK CONSTRAINT [FK_Publicidad_MedioPublicitario]
GO
ALTER TABLE [dbo].[Recordatorio]  WITH CHECK ADD  CONSTRAINT [FK_Recordatorio_Empresa] FOREIGN KEY([Id_empresa])
REFERENCES [dbo].[Empresa] ([Id_Empresa])
GO
ALTER TABLE [dbo].[Recordatorio] CHECK CONSTRAINT [FK_Recordatorio_Empresa]
GO
ALTER TABLE [dbo].[ServicioEmpresa]  WITH CHECK ADD  CONSTRAINT [FK_ServicioEmpresa_Empresa] FOREIGN KEY([Id_Empresa])
REFERENCES [dbo].[Empresa] ([Id_Empresa])
GO
ALTER TABLE [dbo].[ServicioEmpresa] CHECK CONSTRAINT [FK_ServicioEmpresa_Empresa]
GO
ALTER TABLE [dbo].[ServicioEmpresa]  WITH CHECK ADD  CONSTRAINT [FK_ServicioEmpresa_Producto] FOREIGN KEY([Id_Producto])
REFERENCES [dbo].[Producto] ([Id_Producto])
GO
ALTER TABLE [dbo].[ServicioEmpresa] CHECK CONSTRAINT [FK_ServicioEmpresa_Producto]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Empresa] FOREIGN KEY([Id_Empresa])
REFERENCES [dbo].[Empresa] ([Id_Empresa])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Empresa]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([Id_Rol])
REFERENCES [dbo].[Rol] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cuenta"
            Begin Extent = 
               Top = 22
               Left = 697
               Bottom = 152
               Right = 880
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ServicioEmpresa"
            Begin Extent = 
               Top = 13
               Left = 383
               Bottom = 143
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Empresa"
            Begin Extent = 
               Top = 15
               Left = 20
               Bottom = 145
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Producto"
            Begin Extent = 
               Top = 144
               Left = 228
               Bottom = 274
               Right = 398
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ReportCuentas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ReportCuentas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ReportCuentas'
GO
USE [master]
GO
ALTER DATABASE [CRM] SET  READ_WRITE 
GO
