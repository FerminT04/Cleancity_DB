--tabla padre

create table genero(
    id_genero serial primary key,
    genero varchar(9) 
);


create table metodo_Pago(
    id_metodoPago serial primary key,
    metodoPago varchar(10)
);

create table estado_Empleado(
    id_estadoEmpleado serial primary key,
    estadoEmpleado varchar(20)
);

create table tipo_Empleado(
    id_tipoEmpleado serial primary key,
    tipoEmpleado varchar(20)
);

create table tipo_Transaccion(
    id_tipoTransaccion serial primary key,
    tipoTransaccion varchar(20)
);

create table tipo_Producto(
    id_tipoProducto serial primary key,
    tipoProducto varchar(20)
);

create table departamento(
    id_departamento int primary key,
    departamento varchar(15),
    costoEnvio numeric(5,2)
);

create table material(
    id_material serial primary key,
    nombreMaterial varchar(20),
    descripcion varchar(500),
    precio_KG numeric(5,2),
    existencia_KG int
);

--tablas hijo

create table detalle_Material(
    id_EmpresaMaterial serial primary key,
    id_proveedor integer,
    id_material integer,

    foreign key (id_material) references material (id_material)
);

create table cliente(
    id_cliente serial primary key,
    nombre_cliente varchar(60),
    telefono numeric(8),
    DUI varchar(10),
    NIT varchar(20),
    correo varchar(100),
    contrasena varchar(100),
    direccion varchar(500),
    city varchar(30),
    col_res varchar(50), 
    zip_code varchar(6),
    pais_region varchar(30),
    id_genero integer,
    id_departamento integer,

    foreign key (id_genero) references genero (id_genero),
    foreign key (id_departamento) references departamento (id_departamento)
);

create table producto(
    id_producto serial primary key,
    nomber_producto varchar(60),
    existencia int,
    precio numeric(6,2),
    descripcion varchar(500),
    id_tipoProducto integer,

    foreign key (id_tipoProducto) references tipo_Producto (id_tipoProducto)
);

create table empleado(
    id_empleado serial primary key,
    nombre_empleado varchar(60),
    correo varchar(100),
    contrasena varchar(100),
    DUI varchar(10),
    NIT varchar(20),
    id_genero integer,
    id_tipoEmpleado integer,
    id_estadoEmpleado integer,

    foreign key (id_genero) references genero (id_genero),
    foreign key (id_tipoEmpleado) references tipo_Empleado (id_tipoEmpleado),
    foreign key (id_estadoEmpleado) references estado_Empleado (id_estadoEmpleado)
);

create table proveedor(
    id_proveedor serial primary key,
    nombre_empresa varchar(60),
    nombre_representante varchar(60),
    correo varchar(60),
    DUI varchar(10),
    NIT varchar(20),
    telefono numeric(8)
);

create table transaccion(
    id_transaccion serial primary key,
    fecha timestamptz DEFAULT Now(),
    montoTotal numeric (8,2),
    id_cliente integer,
    id_empleado integer,
    id_proveedor integer,
    id_tipoTransaccion integer,
    id_metodoPago integer,

    foreign key (id_cliente) references cliente (id_cliente),
    foreign key (id_empleado) references empleado (id_empleado),
    foreign key (id_proveedor) references proveedor (id_proveedor),
    foreign key (id_tipoTransaccion) references tipo_Transaccion (tipo_Transaccion),
    foreign key (id_metodoPago) references metodo_Pago (id_metodoPago),
);

create table detalle_Transaccion(
    id_detalleTransaccion serial primary key,
    precio numeric(8,2),
    cantidad int,
    id_producto integer,
    id_transaccion integer,

    foreign key (id_producto) references producto (id_producto),
    foreign key (id_transaccion) references transaccion (id_transaccion)
);

create table carrito(
    id_carrito serial primary key,
    cantidad int,
    id_cliente integer,
    id_producto integer,
    precio_venta numeric(6,2)

    foreign key (id_cliente) references cliente (id_cliente),
    foreign key (id_producto) references producto (id_producto)
);

create table comentarios(
    id_comentario serial primary key,
    comentario varchar(500),
    puntuacion numeric(1),
    id_cliente integer,
    id_producto integer,
    fecha timestamptz DEFAULT Now()

    foreign key (id_cliente) references cliente (id_cliente),
    foreign key (id_producto) references producto (id_producto)
);

--selects

select * from cometarios;
select * from carrito;
select * from detalle_Transaccion;
select * from transaccion;
select * from proveedor;
select * from empleado;
select * from producto;
select * from cliente;
select * from detalle_material
select * from material;
select * from departamento;
select * from tipo_Producto;
select * from tipo_Transaccion;
select * from tipo_Empleado;
select * from estado_Empleado;
select * from metodo_Pago;
select * from genero;

/*------------------Consultas para gráficos (Ulises)--------------------*/

--1) Clientes por departamento:
select 
    cliente.id_departamento,
    departamento
    FROM
    cliente
    inner join departamento on departamento.id_departamento = cliente.id_departamento;

--2) Costo de envio por departamento:
select departamento, costoEnvio from departamento;

--3) transacciones por empleado:
select
    empleado.id_empleado,
    montoTotal
    FROM
    empleado
    inner join transaccion on transaccion.id_empleado = empleado.id_empleado;

--4) transacciones por empleado en un periodo de tiempo especifico:
select
    empleado.id_empleado,
    montoTotal
    FROM
    empleado
    inner join transaccion on transaccion.id_empleado = empleado.id_empleado where fecha between 02/10/2015 and 02/10/2015;

--5) precio de materia prima:
select nombreMaterial, precio_KG from material;

/*-----------------Consultas con rangos de fecha (Ulises)-----------------*/

--1) comentarios hechos por un cliente en un periodo de tiempo:
select 
    cliente.id_cliente,
    comentario
    FROM
    cliente
    inner join comentario on comentario.id_cliente = cliente.id_cliente where fecha between 09/26/2018 and 09/26/2019;

--2) comentarios de productos en un cierto tiempo:
select
    producto.id_producto
    comentario
    FROM
    producto
    inner join comentario on comentario.id_producto = porducto.id_producto where fecha between 12/10/2018 and 12/10/2019;

/*-----------------Consultas con rangos de fecha (Marco)-----------------*/ 
select id_transaccion, nombre_cliente, fecha, montoTotal
from transaccion
inner join nombre_cliente on cliente.id_cliente = transaccion.id_cliente
where fecha between '01/01/2000' and '31/12/2019'

select id_transaccion, nombre_empresa, fecha, montoTotal
from transaccion
inner join nombre_empresa on proveedor.id_proveedor = transaccion.id_proveedor
where fecha between '01/01/2010' and '02/04/2020'

/*------------Consultas para reportes con parametros (Marco)-------------*/
select nombre_cliente, telefono, DUI, direccion
from cliente
inner join departamento on departamento.id_departamento = cliente.id_departamento
where departamento = 'San Salvador';

select nombre_producto, existencia, precio, tipoEmpleado, estadoEmpleado, tipoProducto
from producto
inner join tipoProducto on tipo_Producto.id_tipoProducto = producto.id_tipoProducto
where existencia <= 30;

select nombre_empleado, correo, DUI
from ((empleado
inner join tipoEmpleado on tipo_Empleado.id_Empleado = empleado.id_tipoEmpleado)
inner join estadoEmpleado on estado_Empleado.id_estadoEmpleado = empleado.id_estadoEmpleado)
where tipoEmpleado = 'Gerente' and estadoEmpleado = 'Activo';

select id_transaccion, fecha, montoTotal, nombre_cliente, tipoTransaccion
from ((transaccion
inner join nombre_cliente on cliente.id_cliente = transaccion.id_cliente)
inner join tipoTransaccion on tipo_Transaccion.id_tipoTransaccion = transaccion.id_tipoTransaccion)
where tipoTransaccion = 'Venta';

select comentario, puntuacion, nombre_producto
from comentarios
inner join nombre_producto on producto.id_producto = comentarios.id_producto
where puntuacion between 2 and 4;

--selects

select * from cometarios;
select * from carrito;
select * from detalle_Transaccion;
select * from transaccion;
select * from proveedor;
select * from empleado;
select * from producto;
select * from cliente;
select * from detalle_material
select * from material;
select * from departamento;
select * from tipo_Producto;
select * from tipo_Transaccion;
select * from tipo_Empleado;
select * from estado_Empleado;
select * from metodo_Pago;
select * from genero;

--Inner Join (Ejemplo)

 select
 	usuario.id_usuario,
	nombre_usuario,
	contrasena,
	correo,
	tipo_usuario,
	estado_usuario,
	genero
	from
	(((usuario
	inner join genero on genero.id_genero = usuario.id_genero)
	inner join tipo_usuario on tipo_usuario.id_tipousuario = usuario.id_tipousuario)
	inner join estado_usuario on estado_usuario.id_estadousuario = usuario.id_estadousuario);