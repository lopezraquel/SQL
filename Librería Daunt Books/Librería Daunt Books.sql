-- Librería: Daunt Books - CONSULTAS

-- Consultas

-- 1. Seleccionar todos los libros con un precio mayor a $20 y menor a 25$:

SELECT *
FROM libros
WHERE precio >20 AND precio <25;

-- 2. Encontrar el libro con la fecha de publicación más reciente:

SELECT titulo, fecha_publicacion
FROM libros
ORDER BY fecha_publicacion DESC
LIMIT 1;

-- 3. Mostrar los libros con precio superior a la media de precios:

SELECT *
FROM libros
WHERE precio > (
SELECT AVG(precio) FROM libros)
ORDER BY precio DESC;

-- 4. Mostrar el número de libros por categoría:

SELECT 
	categorias.nombre,
    COUNT(*) AS num_libros
FROM libros
INNER JOIN categorias
ON libros.categoria_id = categorias.id_categoria
GROUP BY categorias.nombre;

-- 5. Listar todos los autores ordenados alfabéticamente por su apellido:

SELECT *
FROM autores
ORDER BY apellido ASC;

-- 6. Encontrar el autor con el mayor número de libros publicados:

SELECT 
	autores.*,
	COUNT(*) AS num_libros
FROM autores
INNER JOIN libros
ON autores.id_autor = libros.autor_id
GROUP BY autores.id_autor
ORDER BY num_libros DESC
LIMIT 1;

-- 7. Obtener los nombres y apellidos de los autores junto con el número de libros que tienen en stock:

SELECT 
	autores.nombre,
	autores.apellido,
	SUM(libros.stock) AS stock_total
FROM autores
INNER JOIN libros
ON autores.id_autor = libros.autor_id
GROUP BY autores.id_autor;

-- 8. Mostrar los autores cuyos libros tienen un precio promedio superior a la media:

SELECT
	autores.nombre,
	autores.apellido,
	AVG(libros.precio) AS precio_promedio
FROM libros
INNER JOIN autores
ON libros.autor_id = autores.id_autor
GROUP BY autores.nombre, autores.apellido
HAVING AVG(libros.precio) > (SELECT AVG(precio) FROM libros);

-- 9. Contar cuántas categorías existen en total:

SELECT COUNT(*)
FROM categorias;

-- 10. Encontrar la categoría con más libros:

SELECT 
	categorias.nombre,
	COUNT(*) AS num_libros
FROM categorias
INNER JOIN libros
ON categorias.id_categoria = libros.categoria_id
GROUP BY categorias.id_categoria
ORDER BY num_libros DESC
LIMIT 1;

-- 11. Listar las categorías ordenadas alfabéticamente junto con el promedio de precio de los libros en cada una de ellas:

SELECT categorias.nombre,
	AVG(libros.precio) AS precio_promedio
FROM categorias
JOIN libros
ON categorias.id_categoria = libros.categoria_id
GROUP BY categorias.id_categoria
ORDER BY categorias.nombre ASC;

-- 12. Seleccionar el nombre de cada categoría junto con el autor que ha escrito más libros dentro de ella:

# sin limit: porque todos son 1 (no hay datos para testearlo mejor)
SELECT
	categorias.nombre,
	autores.nombre,
	autores.apellido,
	COUNT(*) as "num_libros"
FROM categorias
INNER JOIN libros
ON categorias.id_categoria = libros.categoria_id
INNER JOIN autores
ON libros.autor_id = autores.id_autor
GROUP BY
	categorias.nombre,
	autores.nombre,
	autores.apellido
ORDER BY num_libros DESC;

-- 13. Listar los préstamos realizados por un cliente específico (3):

SELECT *
FROM prestamos
WHERE cliente_id = 3;

-- 14. Calcular la cantidad de libros prestados por mes en un año específico:

SELECT MONTH(fecha_prestamo) AS mes,
	COUNT(*) AS num_prestamos
FROM prestamos
WHERE YEAR(fecha_prestamo) = 2022
GROUP BY MONTH(fecha_prestamo);

-- 15. Seleccionar el título de cada libro junto con la cantidad de veces que ha sido prestado:

# Libros que SI han sido prestados (inner: matchean)
SELECT libros.titulo,
	COUNT(*) AS num_libros_prestados
FROM libros
INNER JOIN prestamos
ON libros.id_libro = prestamos.libro_id
GROUP BY libros.titulo;

# Libros que NO han sido prestados (inner: matchean)
SELECT *
FROM libros
LEFT JOIN prestamos
ON libros.id_libro = prestamos.libro_id
WHERE prestamos.libro_id is null;

-- 16. Encontrar el libro más prestado:

SELECT libros.titulo,
	COUNT(*) AS num_prestamos
FROM libros
JOIN prestamos
ON libros.id_libro = prestamos.libro_id
GROUP BY libros.id_libro
ORDER BY num_prestamos DESC
LIMIT 1;

-- 17. Seleccionar el nombre del cliente y el título del libro que ha sido prestado por más tiempo:

SELECT libros.titulo, prestamos.cliente_id,
	DATEDIFF(prestamos.fecha_devolucion, prestamos.fecha_prestamo) AS dias_prestado
FROM libros
INNER JOIN prestamos
ON libros.id_libro = prestamos.libro_id
ORDER BY dias_prestado DESC
LIMIT 1;
