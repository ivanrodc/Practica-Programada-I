-- CREACIÓN BASE DE DATOS
-- En esta primera parte se empieza por crear la base de datos que contendrá todas las tablas a información
-- necesaria para cumplir con esta asignación. Además, se establecen los tamaños de los archivos de la base.
CREATE DATABASE CompaniaIvanPractica;

-- Especificar al servidor que se va a utilizar esta base de datos creada (conexión): 
USE CompaniaIvanPractica;

-- CREACIÓN DE LAS TABLAS DEL MODELO E-R
-- TABLA TERRITORIO: esta tabla contiene un identificador único y los nombres de las provincias, cantones y distritos de un lugar ficticio. 
CREATE TABLE Territorio (
    IDTerritorio INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    provincia VARCHAR(200) NOT NULL,
    canton VARCHAR(200) NOT NULL,
    distrito VARCHAR(200) NOT NULL
);

-- TABLA CATEGORÍA: esta tabla contiene un código de cada categoría único y una descripción que corresponde a la categoría del producto. 
CREATE TABLE Categoria (
	codigoCategoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    descripcion VARCHAR(200) NOT NULL
);

-- TABLA SUBCATEGORIA: esta tabla contiene un código de cada subcategoría (único) y una descripción que corresponde a la subcategoría del producto.
CREATE TABLE Subcategoria (
	codigoSubcategoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    descripcion VARCHAR(200) NOT NULL
);

-- TABLA PROVEEDORES: en este caso la cédula es el identificador único (llave primaria) y además se establecen ciertos datos necesarios para
-- localizar a cada vendedor.
create table Proveedor (
    cedula VARCHAR(10) PRIMARY KEY NOT NULL,
    tipo_cedula VARCHAR(15) CHECK (tipo_cedula IN ('nacional', 'dimex', 'juridica')) NOT NULL,
	nombre_proveedor CHAR(100),
    numero_telefono VARCHAR(8),
	correo_electronico VARCHAR(100) CHECK (correo_electronico LIKE '%@%'),
    IDTerritorio INT NOT NULL,
   foreign key (IDTerritorio) REFERENCES Territorio(IDTerritorio)  
);


-- TABLA PRODUCTO: En esta tabla se establecen los aspectos que describen a un producto de esta empresa. Además, esta tabla se liga a las tres tablas anteriores. 
create table Producto (
	SKUProducto INT primary key NOT NULL AUTO_INCREMENT, 
    idInterno int NOT NULL, 
    nombre VARCHAR(500) NOT NULL,
    color VARCHAR(500) NOT NULL,
    tamanoFisico VARCHAR(500) NOT NULL,
    precio float NOT NULL,
    codigoCategoria INT,
	codigoSubcategoria INT,
	idProveedor VARCHAR(500),
    FOREIGN KEY (codigoCategoria) REFERENCES Categoria(codigoCategoria),
    FOREIGN KEY (codigoSubcategoria) REFERENCES Subcategoria(codigoSubcategoria),
    foreign key (idProveedor) references Proveedor(cedula)
);

-- TABLA CLIENTE: se describe a cada uno de los usuarios. 
create table Cliente(
	cedulaCliente VARCHAR(9) primary key NOT NULL,
    nombreCliente VARCHAR(100) NOT NULL,
    correoElectronico VARCHAR(100) NOT NULL,
    edad int NOT NULL,
    numeroCliente VARCHAR(8) ,
    IDTerritorio int NOT NULL,
    FOREIGN KEY (IDTerritorio) REFERENCES Territorio(IDTerritorio)
);


-- TABLA FACTURA: se establece la descripción básica de los datos que puede contener una factura. Asimismo, se asocia sus relaciones con la tabla de Productos
-- y también con la de clientes. 
create table Factura(
	numeroFactura INT primary key NOT NULL AUTO_INCREMENT,
    idProducto int NOT NULL,
    informacionProducto VARCHAR(500) NOT NULL,
    cantidadUnidades int NOT NULL,
    precioEstablecido float NOT NULL,
    impuestoCompra float NOT NULL,
    descuentoCompra float NOT NULL,
    cedulaCliente VARCHAR(500) NOT NULL,
    foreign key (idProducto) references Producto(SKUProducto),
    foreign key (cedulaCliente) references CLiente(cedulaCliente)
);

-- Correciones: aumentar la cantidad de caracteres en cedulaCliente:
ALTER TABLE Cliente
MODIFY cedulaCliente VARCHAR(15);


-- DATOS FICTICIOS: Se crearan un total de n datos por cada una de las tablas. 

-- Tabla TERRITORIO:
insert into Territorio(provincia, canton, distrito) values("Heredia","Flores","San Joaquin");
insert into Territorio(provincia, canton, distrito) values("Cartago","Cartago","San Nicolas");
insert into Territorio(provincia, canton, distrito) values("Alajuela","Alajuela","Montecillos");
insert into Territorio(provincia, canton, distrito) values("Limon","Paraiso","Llanos de Santa Lucia");
insert into Territorio(provincia, canton, distrito) values("San Jose","Montes de Oca","Sabanilla");
insert into Territorio(provincia, canton, distrito) values("Cartago","Oreamuno","Cot");
insert into Territorio(provincia, canton, distrito) values("Puntarenas","Esparza","Caldera");
insert into Territorio(provincia, canton, distrito) values("Heredia","Santo Domingo","Paracito");
insert into Territorio(provincia, canton, distrito) values("Guanacaste","Nicoya","Nosara");
insert into Territorio(provincia, canton, distrito) values("Guanacaste","Santa Cruz","Tempate");
insert into Territorio(provincia, canton, distrito) values("Cartago","Paraiso","Orosi");
insert into Territorio(provincia, canton, distrito) values("Alajuela","San Ramoon","San Juan");
insert into Territorio(provincia, canton, distrito) values("San Jose","Dota","Copey");
insert into Territorio(provincia, canton, distrito) values("San Jose","Curridabat","Granadilla");

select * from Territorio;

-- Tabla CATEGORIA:
insert into Categoria(descripcion) values ("Abarrotes");
insert into Categoria(descripcion) values ("Carnes");
insert into Categoria(descripcion) values ("Limpieza");
select * from Categoria;

-- Tabla SUBCATEGORIA:
insert into Subcategoria(descripcion) values ("Bebidas");
insert into Subcategoria(descripcion) values ("Granos");
insert into Subcategoria(descripcion) values ("Arroz");
insert into Subcategoria(descripcion) values ("Suavitel");
insert into Subcategoria(descripcion) values ("Pollo");
insert into Subcategoria(descripcion) values ("Res");
insert into Subcategoria(descripcion) values ("Lysol");
insert into Subcategoria(descripcion) values ("Pescado");
insert into Subcategoria(descripcion) values ("Pasta");
insert into Subcategoria(descripcion) values ("Bolsas de basura");
select * from Subcategoria;

-- Tabla PROVEEDEOR:

INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES ("3101296668","nacional", "Florida Bebidas S.A", "22971212", "compras@fifco.com", 1);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("345678456", "nacional", "Gloria Bebidas", "21345678", "gloriempre@gmail.com", 2);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("719834562", "nacional", "Bebidas del Norte S.A", "22223333", "ventas@bdnorte.com", 3);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES ("420956812", "nacional", "Importaciones Exóticas S.A", "88934562", "info@importex.com", 4);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("612378945", "nacional", "Productos del Caribe S.A", "26665555", "contacto@caribeprod.com", 5);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("876543567", "dimex", "Global Suppliers Inc.", "24457632", "info@globalsuppliers.com", 6);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("936749165", "juridica", "International Trade Co.", "28889999", "sales@inttradeco.com", 7);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("354387654", "juridica", "Overseas Products Ltd.", "29991000", "contact@overseasprod.com", 8);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("568987654", "nacional", "Carnicos Sanchez JP", "65431287", "carnesluissanchez@sanches.com", 9);
INSERT INTO Proveedor(cedula, tipo_cedula, nombre_proveedor, numero_telefono, correo_electronico, IDTerritorio) VALUES("187542364", "nacional", "Rodriguez Limpieza S.A", "76542378", "compras@fifco.com", 10);

-- Tabla PRODUCTO: 

insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(101,"Coca Cola","Cafe","1000 ml","1200",1,1,"719834562");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(102,"Lysol limon","Amarillo","700 ml","2300",3,7,"876543567");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(103,"Alas de pollo 4 piezas","Blanco","1 kg","1800",2,5,"568987654");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(104,"Lasagna Romass","Beige","400 gm","2350",1,9,"354387654");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(105,"Arroz precocido TT","Blanco","4 kg","4570",1,3,"354387654");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(106,"Atun precocido","Rosado","1.5 kg","7700",2,8,"420956812");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(107,"Bolsas pequeñas Peki","Verde","290 g","760",1,10,"612378945");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(108,"Te de arandanos","Amarillo","3 l","1400",1,1,"3101296668");  
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(109,"Lysol olor mar","Azul","10 l","11200",3,7,"187542364");
insert into Producto(idInterno,nombre,color,tamanoFisico,precio,codigoCategoria,codigoSubcategoria,idProveedor) values(110,"Pechugas marinadas","Naranja","2 kg","6780",2,5,"936749165");

-- Tabla CLIENTE: solo incluí 5 clientes
insert into Cliente(cedulaCliente,nombreCliente,correoElectronico,edad,numeroCliente,IDTerritorio) values("207730539","Ariel Rodriguez", "arocruz8@gmail.com",26,"83938935",2);
insert into Cliente(cedulaCliente,nombreCliente,correoElectronico,edad,numeroCliente,IDTerritorio) values("901220797","Valeria Martinez", "valemar3108@gmail.com",23,"87852339",4);
insert into Cliente(cedulaCliente,nombreCliente,correoElectronico,edad,numeroCliente,IDTerritorio) values("567654634","Juan Perez", "juanmi98@gmail.com",45,"78654534",5);
insert into Cliente(cedulaCliente,nombreCliente,correoElectronico,edad,numeroCliente,IDTerritorio) values("345416278","Natalia Lopez", "nat67tt@hotmail.com",19,"65432178",6);
insert into Cliente(cedulaCliente,nombreCliente,correoElectronico,edad,numeroCliente,IDTerritorio) values("765478905","Rodrigo Cubero", "cuberod@gmail.com",65,"87567643",3);
insert into Cliente(cedulaCliente,nombreCliente,correoElectronico,edad,numeroCliente,IDTerritorio) values("456754326","Martha Jimenez", "jimenezmart66@gmail.com",20,"82346712",8);
insert into Cliente(cedulaCliente,nombreCliente,correoElectronico,edad,numeroCliente,IDTerritorio) values("190876990","Saul Dengo", "dengortts@outlook.com",33,"89007765",1);

-- Tabla FACTURA: al poner por ejemplo, 2 cantidades de "Coca cola" el precio sería de 2400, el unitario es de 1200. Así con los demás ejemplos.
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(2,"Coca Cola 1000ml",2,2400,0.13,0.0,"207730539");
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(6, "Arroz precocido TT 4kg", 1, 4570, 0.13, 0, "765478905");
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(11, "Pechugas marinadas 2kg", 6, 40680, 0.13, 0, "190876990");
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(3, "Lysol limon 700ml", 3, 6900, 0.13, 0, "567654634");
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(8, "Bolsas pequeñas Peki", 1, 760, 0.13, 0, "345416278");
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(9, "Te de arandanos 3l", 5, 7000, 0.13, 0, "207730539");
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(5, "Lasagna Romass", 2, 4700, 0.13, 0, "190876990");
insert into Factura(idProducto, informacionProducto, cantidadUnidades, precioEstablecido, impuestoCompra, descuentoCompra, cedulaCliente) values(4, "Alas de pollo 4 piezas", 2, 3600, 0.13, 0.15, "567654634");
   













