------------------------------------------------------------------------------------------------------------
-- BORRAR LAS TABLAS SI EXISTEN
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('TMovimiento', 'U') IS NOT NULL
	drop table TMovimiento
go

if OBJECT_ID('TProducto', 'U') IS NOT NULL
	drop table TProducto
go

------------------------------------------------------------------------------------------------------------
-- CREACIÓN DE TABLAS DE LA BASE DE DATOS
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
create table TProducto(
 CodProducto		varchar(4) not null primary key,
 Nombre 			varchar(50) not null,
 UnidadMedida 		varchar(30) not null,
 Precio 			real not null check (Precio > 0),
 Stock				int default 1 check (Stock >=0 )
 )
go
------------------------------------------------------------------------------------------------------------
create table TMovimiento(
 CodMovimiento		varchar(4) not null primary key,
 Fecha 				datetime not null,
 CodProducto		varchar(4) not null,
 TipoMovimiento		varchar(8) not null check (TipoMovimiento in ('ENTRADA','SALIDA')),
 Cantidad			real not null,
 foreign key 		(CodProducto) references TProducto
)
go
------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
-- INSERCIÓN DE DATOS DE EJEMPLO
------------------------------------------------------------------------------------------------------------
insert into TProducto values ('P001', 'LECHE','LITRO', 3, 3.5)
insert into TProducto values ('P002', 'FIDEO','KILO', 8, 4.0)
insert into TProducto values ('P003', 'ARROZ','KILO',4, 5.0)
insert into TProducto values ('P004', 'PAPA','KG', 3.5, 254)
go

SET DATEFORMAT DMY
------------------------------------------------------------------------------------------------------------
insert into TMovimiento values('M001', '12/08/2018', 'P001', 'ENTRADA', 100)
insert into TMovimiento values('M002', '12/08/2018', 'P002', 'ENTRADA', 200)
insert into TMovimiento values('M003', '12/08/2018', 'P003', 'ENTRADA', 500)
insert into TMovimiento values('M004', '12/08/2018', 'P004', 'ENTRADA', 400)
insert into TMovimiento values('M005', '12/08/2018', 'P002', 'SALIDA', 55)
insert into TMovimiento values('M006', '12/08/2018', 'P004', 'SALIDA', 150)

go

select 'OK'