create database db_VentaArequipa
go
------------------------------------------------------------------------------------------------------------
use db_VentaArequipa
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