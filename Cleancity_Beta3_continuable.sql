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

--Inner Joins

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
