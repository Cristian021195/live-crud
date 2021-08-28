CREATE TABLE usuarios(
    mail VARCHAR(50) NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    foto VARCHAR(255) NOT NULL DEFAULT 'default.svg',
    dni VARCHAR(20),
    contra VARCHAR(255) NOT NULL,
    nacimiento DATE,
    tipo ENUM('administrador', 'empleado', 'super', 'secretaria'),
    telefono VARCHAR(20),
    zona VARCHAR(20) NOT NULL,
    direccion VARCHAR(50),
    estado ENUM('activo', 'inactivo')
);

CREATE TABLE clientes(
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    dni VARCHAR(20) NOT NULL UNIQUE,
    tipo ENUM('representante', 'distribuidor', 'mayorista', 'minorista'),
    telefono VARCHAR(20) NOT NULL,
    mail VARCHAR(50) UNIQUE,
    zona VARCHAR(20) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    estado ENUM('activo', 'inactivo')
);

CREATE TABLE publicaciones(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    publicacion VARCHAR(512) NOT NULL,
    empresa VARCHAR(10) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE productos(
    id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL CHECK (nombre > ''),
    zona VARCHAR(20) NOT NULL,
    base FLOAT(6,2) NOT NULL CHECK (precio_base >= 0),
    distribuidor FLOAT(6,2) NOT NULL CHECK (precio_distribuidor >= 0),
    mayorista FLOAT(6,2) NOT NULL CHECK (precio_mayorista >= 0),
    minorista FLOAT(6,2) NOT NULL CHECK (precio_minorista >= 0),
    estado ENUM('activo', 'inactivo')
);




CREATE TABLE tmp_productos(
    id_producto INT NOT NULL,
    mail VARCHAR(50) NOT NULL,
    precio FLOAT(8,2) NOT NULL CHECK (precio<=0),
    cantidad INT NOT NULL CHECK (cantidad <=0),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (mail) REFERENCES usuarios(mail)
);

CREATE TABLE comprobantes(
    id_comprobante INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    mail VARCHAR(50) NOT NULL,
    /*fecha DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,*/
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pagado', 'pendiente', 'deudor') DEFAULT 'pendiente',
    total FLOAT(10,2) NOT NULL,
    entregado TINYINT(1) NOT NULL DEFAULT 0,
    zona VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    /*FOREIGN KEY (mail) REFERENCES usuarios(mail)*/
    FOREIGN KEY (mail) REFERENCES usuarios(mail) ON UPDATE CASCADE
);

CREATE TABLE detalles(
    id_detalle INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_comprobante INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    devolucion INT NOT NULL,
    precio FLOAT(10,2),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_comprobante) REFERENCES comprobantes(id_comprobante) ON DELETE CASCADE
);

CREATE TABLE tmp_carga(
    id_carga INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_comprobante INT NOT NULL,
    zona VARCHAR(20) NOT NULL
);

INSERT INTO usuarios (mail, nombre, foto, dni, contra, nacimiento, tipo, telefono, zona, direccion, estado) VALUES
('cristiangramajo015@gmail.com', 'Cristian Ismael Gramajo', 'foto en carpeta local', '20393567008', '$2y$10$CGZyYcJIFEkCjARNM2Xc6.C0SNSvg7I.t0gf75HuD7mODrb2Gcb3y', '2016-05-21', 'administrador', '+543865332311', 'catamarca', 'San Luis 1216', 1);


/*RUTA 38 EXPREBUS*/

CREATE VIEW `vista-exp-38-hab-ns` AS
SELECT tucuman, famailla, monteros, concepcion, aguilares, `santa ana`, alberdi, `la cocha`, `los pizarros`, `rio huacra`, expreso FROM `exp-38-hab-ns` WHERE activo = 'si';

CREATE VIEW `vista-exp-38-hab-sn` AS
SELECT `rio huacra`, `los pizarros`, `la cocha`, alberdi, `santa ana`, aguilares, concepcion, monteros, famailla, tucuman,  expreso FROM `exp-38-hab-sn` WHERE activo = 'si';



CREATE TABLE usuarios(
    mail VARCHAR(50) NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
CREATE TABLE notas(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    contenido VARCHAR(255) NOT NULL CHECK (CHAR_LENGTH(contenido)>2),
    usuario VARCHAR(50) NOT NULL,
  	FOREIGN KEY (usuario) REFERENCES usuarios(mail)
);

INSERT INTO usuarios (mail,nombre) VALUES ('cristiangramajo015@gmail.com', 'cristian');
INSERT INTO usuarios (mail,nombre) VALUES ('cristiangramajo015@outlook.com', 'ismael');

INSERT INTO notas (contenido, usuario, importancia) VALUES ('primera nota','cristiangramajo015@gmail.com', 'baja');
INSERT INTO notas (contenido, usuario, importancia) VALUES ('segunda nota','cristiangramajo015@gmail.com', 'alta');
INSERT INTO notas (contenido, usuario, importancia) VALUES ('tercer nota','cristiangramajo015@gmail.com', 'alta');
INSERT INTO notas (contenido, usuario, importancia) VALUES ('cuarta nota','cristiangramajo015@outlook.com', 'alta');
INSERT INTO notas (contenido, usuario, importancia) VALUES ('quinta nota','cristiangramajo015@outlook.com', 'alta');
INSERT INTO notas (contenido, usuario, importancia) VALUES ('sexta nota','cristiangramajo015@gmail.com', 'media');