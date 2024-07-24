-- Librería: Daunt Books - DATABASE

CREATE SCHEMA daunt_books;
USE daunt_books;

CREATE TABLE autores (
id_autor INTEGER PRIMARY KEY,
nombre TEXT,
apellido TEXT
);

INSERT INTO autores (id_autor, nombre, apellido)
VALUES
(1, 'Gabriel', 'García Márquez'),
(2, 'Mario', 'Vargas Llosa'),
(3, 'Isabel', 'Allende'),
(4, 'Julio', 'Cortázar'),
(5, 'Jorge Luis', 'Borges');

CREATE TABLE categorias (
id_categoria INTEGER PRIMARY KEY,
nombre TEXT
);

INSERT INTO categorias (id_categoria, nombre) 
VALUES
(1, 'Realismo mágico'),
(2, 'Narrativa'),
(3, 'Novela'),
(4, 'Ficción'),
(5, 'Biografía'),
(6, 'Histórico'),
(7, 'Ensayo');

CREATE TABLE libros (
id_libro INTEGER PRIMARY KEY,
titulo TEXT,
autor_id INTEGER,
descripcion TEXT,
fecha_publicacion DATE,
categoria_id INTEGER,
precio DECIMAL(10,2),
stock INTEGER,
FOREIGN KEY (autor_id) REFERENCES autores(id_autor),
FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria)
);

INSERT INTO libros (id_libro, titulo, autor_id, descripcion, fecha_publicacion, categoria_id, precio, stock)
VALUES
(1, 'Cien años de soledad', 1, 'Una de las obras cumbres de la literatura latinoamericana', '1967-05-30', 1, 25.99, 10),
(2, 'La ciudad y los perros', 2, 'Una novela de formación ambientada en una escuela militar', '1963-06-28', 1, 19.99, 15),
(3, 'La casa de los espíritus', 3, 'Una novela de realismo mágico que narra la historia de tres generaciones de mujeres', '1982-01-01', 1, 19.99, 14),
(4, 'Rayuela', 4, 'Una obra experimental que juega con el lenguaje y la estructura narrativa', '1963-06-28', 4, 17.50, 20),
(5, 'Paula', 3, 'Una narrativa que te identifica con el dolor de una madre', '1994-01-01', 2, 19.95, 6);

CREATE TABLE prestamos (
id_prestamo INTEGER PRIMARY KEY,
libro_id INTEGER,
cliente_id INTEGER,
fecha_prestamo DATE,
fecha_devolucion DATE,
FOREIGN KEY(libro_id) REFERENCES libros(id_libro)
);

INSERT INTO prestamos (id_prestamo, libro_id, cliente_id, fecha_prestamo, fecha_devolucion)
VALUES
(1, 1, 1, '2022-03-01', '2022-03-07'),
(2, 2, 2, '2022-03-02', '2022-03-08'),
(3, 3, 3, '2022-03-03', '2022-03-09'),
(4, 4, 4, '2022-03-04', '2022-03-10'),
(5, 5, 5, '2022-03-05', '2022-03-11'),
(6, 1, 5, '2022-04-01', '2022-04-07'),
(7, 1, 3, '2022-03-09', '2022-03-15'),
(8, 5, 3, '2022-03-15', '2022-03-24');