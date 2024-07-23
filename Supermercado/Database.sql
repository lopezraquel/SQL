-- Supermercado Online - DATABASE

CREATE DATABASE supermercado;

CREATE TABLE supermercado.productos (
id_producto INT PRIMARY KEY NOT NULL,
nombre VARCHAR (50),
descripcion VARCHAR (100),
precio DECIMAL(10,2),
stock INT
);

INSERT INTO supermercado.productos (id_producto, nombre, descripcion, precio, stock)
VALUES
(1, 'Leche', 'Leche entera en envase de 1L', 1.20, 100),
(2, 'Queso', 'Queso curado en bloque de 500g', 4.50, 50),
(3, 'Yogurt', 'Yogurt natural sin azúcar en envase de 500g', 2.00, 80),
(4, 'Pan', 'Pan blanco recién horneado en barra de 500g', 1.50, 200),
(5, 'Huevos', 'Huevos de gallina campera de tamaño L en docena', 2.80, 30),
(6, 'Arroz', 'Arroz blanco de grano largo en paquete de 1Kg', 1.70, 150),
(7, 'Pasta', 'Pasta italiana en paquete de 500g', 2.30, 120),
(8, 'Carne', 'Carne de ternera en bandeja de 500g', 8.90, 20),
(9, 'Pescado', 'Pescado fresco de la costa en pieza de 1Kg', 12.50, 10),
(10, 'Frutas', 'Cesta de frutas variadas de temporada', 7.20, 15);

CREATE TABLE supermercado.pedidos (
id_pedido INT PRIMARY KEY NOT NULL,
id_producto INT NOT NULL, 
cantidad INT,
fecha DATE,
FOREIGN KEY (id_producto) REFERENCES supermercado.productos(id_producto)
);

INSERT INTO supermercado.pedidos (id_pedido, id_producto, cantidad, fecha)
VALUES
(1, 3, 2, '2023-04-15'),
(2, 5, 1, '2023-04-16'),
(3, 1, 4, '2023-04-16'),
(4, 8, 3, '2023-04-16'),
(5, 2, 2, '2023-04-17'),
(6, 9, 1, '2023-04-17'),
(7, 4, 3, '2023-04-17'),
(8, 8, 1, '2023-04-17'),
(9, 6, 2, '2023-04-17'),
(10, 10, 2, '2023-04-18'),
(11, 8, 5, '2023-04-18'),
(12, 7, 4, '2023-04-18');