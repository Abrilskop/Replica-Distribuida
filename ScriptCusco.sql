-- Autores: Gianella Alexandra Ramos Ticahuanca Y Frank Mamani
-- Fecha: 21/10/2022
-- Tarea: Realizar los procedimientos almacenados de insertar, modificar y eliminar para la base de datos db_VentaCusco

-- Crear db_VentaCusco
create database db_VentaCusco
go
------------------------------------------------------------------------------------------------------------
use db_VentaCusco
go
------------------------------------------------------------------------------------------------------------
-- CREACIÓN DE TABLAS DE LA BASE DE DATOS
------------------------------------------------------------------------------------------------------------
create table TCliente(
 CodCliente			varchar(4) not null primary key,
 Apellidos			varchar(30)not null,
 Nombres 			varchar(30)not null,
 Direccion			varchar(50)not null,
 Localidad				varchar(50)not null
)
go

------------------------------------------------------------------------------------------------------------
create table TVendedor(
 CodVendedor		varchar(4) not null primary key,
 Apellidos			varchar(30) not null,
 Nombres			varchar(30)not null,
 Localidad				varchar(50) not null
)
go
------------------------------------------------------------------------------------------------------------
create table TCategoria(
 CodCategoria		varchar(4) not null primary key,
 Nombre 			varchar(50) not null,
 CategoriaPadre		varchar(4),
 Foreign Key		(CategoriaPadre) References TCategoria
 )
go
------------------------------------------------------------------------------------------------------------
create table TProducto(
 CodProducto		varchar(4) not null primary key,
 Nombre 			varchar(50) not null,
 UnidadMedida 		varchar(30) not null,
 Precio 			real not null check (Precio > 0),
 Stock				int default 1 check (Stock >=0 ),
 CodCategoria		varchar(4) not null,
 Foreign Key		(CodCategoria) References TCategoria
)
go
------------------------------------------------------------------------------------------------------------
create table TVenta(
 CodVenta			varchar(6) not null primary key,
 Fecha 				datetime not null,
 CodCliente 		varchar(4) not null,
 CodVendedor		varchar(4) not null,
 Anulado 			bit not null default 0,
 Localidad			varchar(50) not null,
 foreign key 		(CodCliente) references TCliente,
 foreign key 		(CodVendedor) references TVendedor
)
go
------------------------------------------------------------------------------------------------------------
create table TDetalle(
 CodVenta			varchar(6) not null,
 CodProducto 		varchar(4) not null,
 Cantidad  			real not null check (Cantidad > 0),
 PrecioUnitario		real not null check (PrecioUnitario > 0),
 primary key 		(CodVenta,CodProducto),
 foreign key 		(CodVenta) references TVenta,
 foreign key 		(CodProducto) references TProducto
)
go


-- 1. Procedimiento para TCliente: Insertar Cliente
CREATE PROCEDURE sp_InsertarClienteCuscoDesdeCusco
    @CodCliente VARCHAR(4),
    @Apellidos VARCHAR(30),
    @Nombres VARCHAR(30),
    @Direccion VARCHAR(50),
    @Localidad VARCHAR(50)
AS
BEGIN
    INSERT INTO TCliente (CodCliente, Apellidos, Nombres, Direccion, Localidad)
    VALUES (@CodCliente, @Apellidos, @Nombres, @Direccion, @Localidad);

    INSERT INTO [ADMINDEGIA].db_VentaCusco.dbo.TCliente (CodCliente, Apellidos, Nombres, Direccion, Localidad)
    VALUES (@CodCliente, @Apellidos, @Nombres, @Direccion, @Localidad);
END;
GO

-- 2. Procedimiento para TCliente: Modificar Cliente
CREATE PROCEDURE sp_ModificarClienteCuscoDesdeCusco
    @CodCliente VARCHAR(4),
    @Apellidos VARCHAR(30),
    @Nombres VARCHAR(30),
    @Direccion VARCHAR(50),
    @Localidad VARCHAR(50)
AS
BEGIN
    UPDATE TCliente
    SET Apellidos = @Apellidos, Nombres = @Nombres, Direccion = @Direccion, Localidad = @Localidad
    WHERE CodCliente = @CodCliente;

    UPDATE [ADMINDEGIA].db_VentaCusco.dbo.TCliente
    SET Apellidos = @Apellidos, Nombres = @Nombres, Direccion = @Direccion, Localidad = @Localidad
    WHERE CodCliente = @CodCliente;
END;
GO

-- 3. Procedimiento para TCliente: Eliminar Cliente
CREATE PROCEDURE sp_EliminarClienteCuscoDesdeCusco
    @CodCliente VARCHAR(4)
AS
BEGIN
    DELETE FROM TCliente WHERE CodCliente = @CodCliente;

    DELETE FROM [ADMINDEGIA].db_VentaCusco.dbo.TCliente WHERE CodCliente = @CodCliente;
END;
GO

-- 4. Procedimiento para TVendedor: Insertar Vendedor
CREATE PROCEDURE sp_InsertarVendedorCuscoDesdeCusco
    @CodVendedor VARCHAR(4),
    @Apellidos VARCHAR(30),
    @Nombres VARCHAR(30),
    @Localidad VARCHAR(50)
AS
BEGIN
    INSERT INTO TVendedor (CodVendedor, Apellidos, Nombres, Localidad)
    VALUES (@CodVendedor, @Apellidos, @Nombres, @Localidad);

    INSERT INTO [ADMINDEGIA].db_VentaCusco.dbo.TVendedor (CodVendedor, Apellidos, Nombres, Localidad)
    VALUES (@CodVendedor, @Apellidos, @Nombres, @Localidad);
END;
GO

-- 5. Procedimiento para TVendedor: Modificar Vendedor
CREATE PROCEDURE sp_ModificarVendedorCuscoDesdeCusco
    @CodVendedor VARCHAR(4),
    @Apellidos VARCHAR(30),
    @Nombres VARCHAR(30),
    @Localidad VARCHAR(50)
AS
BEGIN
    UPDATE TVendedor
    SET Apellidos = @Apellidos, Nombres = @Nombres, Localidad = @Localidad
    WHERE CodVendedor = @CodVendedor;

    UPDATE [ADMINDEGIA].db_VentaCusco.dbo.TVendedor
    SET Apellidos = @Apellidos, Nombres = @Nombres, Localidad = @Localidad
    WHERE CodVendedor = @CodVendedor;
END;
GO

-- 6. Procedimiento para TVendedor: Eliminar Vendedor
CREATE PROCEDURE sp_EliminarVendedorCuscoDesdeCusco
    @CodVendedor VARCHAR(4)
AS
BEGIN
    DELETE FROM TVendedor WHERE CodVendedor = @CodVendedor;

    DELETE FROM [ADMINDEGIA].db_VentaCusco.dbo.TVendedor WHERE CodVendedor = @CodVendedor;
END;
GO

-- 7. Procedimiento para TCategoria: Insertar Categoria
CREATE PROCEDURE sp_InsertarCategoriaCuscoDesdeCusco
    @CodCategoria VARCHAR(4),
    @Nombre VARCHAR(50),
    @CategoriaPadre VARCHAR(4) = NULL
AS
BEGIN
    INSERT INTO TCategoria (CodCategoria, Nombre, CategoriaPadre)
    VALUES (@CodCategoria, @Nombre, @CategoriaPadre);

    INSERT INTO [ADMINDEGIA].db_VentaCusco.dbo.TCategoria (CodCategoria, Nombre, CategoriaPadre)
    VALUES (@CodCategoria, @Nombre, @CategoriaPadre);
END;
GO

-- 8. Procedimiento para TCategoria: Modificar Categoria
CREATE PROCEDURE sp_ModificarCategoriaCuscoDesdeCusco
    @CodCategoria VARCHAR(4),
    @Nombre VARCHAR(50),
    @CategoriaPadre VARCHAR(4) = NULL
AS
BEGIN
    UPDATE TCategoria
    SET Nombre = @Nombre, CategoriaPadre = @CategoriaPadre
    WHERE CodCategoria = @CodCategoria;

    UPDATE [ADMINDEGIA].db_VentaCusco.dbo.TCategoria
    SET Nombre = @Nombre, CategoriaPadre = @CategoriaPadre
    WHERE CodCategoria = @CodCategoria;
END;
GO

-- 9. Procedimiento para TCategoria: Eliminar Categoria
CREATE PROCEDURE sp_EliminarCategoriaCuscoDesdeCusco
    @CodCategoria VARCHAR(4)
AS
BEGIN
    DELETE FROM TCategoria WHERE CodCategoria = @CodCategoria;

    DELETE FROM [ADMINDEGIA].db_VentaCusco.dbo.TCategoria WHERE CodCategoria = @CodCategoria;
END;
GO

-- 10. Procedimiento para TProducto: Insertar Producto
CREATE PROCEDURE sp_InsertarProductoCuscoDesdeCusco
    @CodProducto VARCHAR(4),
    @Nombre VARCHAR(50),
    @UnidadMedida VARCHAR(30),
    @Precio REAL,
    @Stock INT = 1,
    @CodCategoria VARCHAR(4)
AS
BEGIN
    INSERT INTO TProducto (CodProducto, Nombre, UnidadMedida, Precio, Stock, CodCategoria)
    VALUES (@CodProducto, @Nombre, @UnidadMedida, @Precio, @Stock, @CodCategoria);

    INSERT INTO [ADMINDEGIA].db_VentaCusco.dbo.TProducto (CodProducto, Nombre, UnidadMedida, Precio, Stock, CodCategoria)
    VALUES (@CodProducto, @Nombre, @UnidadMedida, @Precio, @Stock, @CodCategoria);
END;
GO

-- 11. Procedimiento para TProducto: Modificar Producto
CREATE PROCEDURE sp_ModificarProductoCuscoDesdeCusco
    @CodProducto VARCHAR(4),
    @Nombre VARCHAR(50),
    @UnidadMedida VARCHAR(30),
    @Precio REAL,
    @Stock INT,
    @CodCategoria VARCHAR(4)
AS
BEGIN
    UPDATE TProducto
    SET Nombre = @Nombre, UnidadMedida = @UnidadMedida, Precio = @Precio, Stock = @Stock, CodCategoria = @CodCategoria
    WHERE CodProducto = @CodProducto;

    UPDATE [ADMINDEGIA].db_VentaCusco.dbo.TProducto
    SET Nombre = @Nombre, UnidadMedida = @UnidadMedida, Precio = @Precio, Stock = @Stock, CodCategoria = @CodCategoria
    WHERE CodProducto = @CodProducto;
END;
GO

-- 12. Procedimiento para TProducto: Eliminar Producto
CREATE PROCEDURE sp_EliminarProductoCuscoDesdeCusco
    @CodProducto VARCHAR(4)
AS
BEGIN
    DELETE FROM TProducto WHERE CodProducto = @CodProducto;

    DELETE FROM [ADMINDEGIA].db_VentaCusco.dbo.TProducto WHERE CodProducto = @CodProducto;
END;
GO

-- 13. Procedimiento para TVenta: Insertar Venta
CREATE PROCEDURE sp_InsertarVentaCuscoDesdeCusco
    @CodVenta VARCHAR(6),
    @Fecha DATETIME,
    @CodCliente VARCHAR(4),
    @CodVendedor VARCHAR(4),
    @Anulado BIT = 0,
    @Localidad VARCHAR(50)
AS
BEGIN
    INSERT INTO TVenta (CodVenta, Fecha, CodCliente, CodVendedor, Anulado, Localidad)
    VALUES (@CodVenta, @Fecha, @CodCliente, @CodVendedor, @Anulado, @Localidad);

    INSERT INTO [ADMINDEGIA].db_VentaCusco.dbo.TVenta (CodVenta, Fecha, CodCliente, CodVendedor, Anulado, Localidad)
    VALUES (@CodVenta, @Fecha, @CodCliente, @CodVendedor, @Anulado, @Localidad);
END;
GO

-- 14. Procedimiento para TVenta: Modificar Venta
CREATE PROCEDURE sp_ModificarVentaCuscoDesdeCusco
    @CodVenta VARCHAR(6),
    @Fecha DATETIME,
    @CodCliente VARCHAR(4),
    @CodVendedor VARCHAR(4),
    @Anulado BIT,
    @Localidad VARCHAR(50)
AS
BEGIN
    UPDATE TVenta
    SET Fecha = @Fecha, CodCliente = @CodCliente, CodVendedor = @CodVendedor, Anulado = @Anulado, Localidad = @Localidad
    WHERE CodVenta = @CodVenta;

    UPDATE [ADMINDEGIA].db_VentaCusco.dbo.TVenta
    SET Fecha = @Fecha, CodCliente = @CodCliente, CodVendedor = @CodVendedor, Anulado = @Anulado, Localidad = @Localidad
    WHERE CodVenta = @CodVenta;
END;
GO

-- 15. Procedimiento para TVenta: Eliminar Venta
CREATE PROCEDURE sp_EliminarVentaCuscoDesdeCusco
    @CodVenta VARCHAR(6)
AS
BEGIN
    DELETE FROM TVenta WHERE CodVenta = @CodVenta;

    DELETE FROM [ADMINDEGIA].db_VentaCusco.dbo.TVenta WHERE CodVenta = @CodVenta;
END;
GO

-- 16. Procedimiento para TDetalle: Insertar Detalle de Venta
CREATE PROCEDURE sp_InsertarDetalleCuscoDesdeCusco
    @CodVenta VARCHAR(6),
    @CodProducto VARCHAR(4),
    @Cantidad REAL,
    @PrecioUnitario REAL
AS
BEGIN
    INSERT INTO TDetalle (CodVenta, CodProducto, Cantidad, PrecioUnitario)
    VALUES (@CodVenta, @CodProducto, @Cantidad, @PrecioUnitario);

    INSERT INTO [ADMINDEGIA].db_VentaCusco.dbo.TDetalle (CodVenta, CodProducto, Cantidad, PrecioUnitario)
    VALUES (@CodVenta, @CodProducto, @Cantidad, @PrecioUnitario);
END;
GO

-- 17. Procedimiento para TDetalle: Modificar Detalle de Venta
CREATE PROCEDURE sp_ModificarDetalleCuscoDesdeCusco
    @CodVenta VARCHAR(6),
    @CodProducto VARCHAR(4),
    @Cantidad REAL,
    @PrecioUnitario REAL
AS
BEGIN
    UPDATE TDetalle
    SET Cantidad = @Cantidad, PrecioUnitario = @PrecioUnitario
    WHERE CodVenta = @CodVenta AND CodProducto = @CodProducto;

    UPDATE [ADMINDEGIA].db_VentaCusco.dbo.TDetalle
    SET Cantidad = @Cantidad, PrecioUnitario = @PrecioUnitario
    WHERE CodVenta = @CodVenta AND CodProducto = @CodProducto;
END;
GO

-- 18. Procedimiento para TDetalle: Eliminar Detalle de Venta
CREATE PROCEDURE sp_EliminarDetalleCuscoDesdeCusco
    @CodVenta VARCHAR(6),
    @CodProducto VARCHAR(4)
AS
BEGIN
    DELETE FROM TDetalle WHERE CodVenta = @CodVenta AND CodProducto = @CodProducto;

    DELETE FROM [ADMINDEGIA].db_VentaCusco.dbo.TDetalle WHERE CodVenta = @CodVenta AND CodProducto = @CodProducto;
END;
GO
