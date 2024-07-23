-- Supermercado Online - CONSULTAS

-- Consultas Básicas

-- 1. Seleccionar todos los productos:

SELECT *
FROM supermercado.productos;

-- 2. Seleccionar los productos con un stock menor o igual a 10

SELECT *
FROM supermercado.productos
WHERE stock <= 10;

-- 3. Seleccionar el nombre y precio del producto con el mayor precio:

SELECT nombre, precio 
FROM supermercado.productos
ORDER BY precio DESC
LIMIT 1;

-- 4. Seleccionar todos los productos con un precio mayor a 5 euros:

SELECT *
FROM supermercado.productos
WHERE precio >= 5;

-- 5. Seleccionar el nombre y descripción de los productos que contienen la palabra "ternera" en su descripción:

SELECT nombre, descripcion
FROM supermercado.productos
WHERE descripcion LIKE '%ternera%';

-- 6. Mostrar los nombres únicos de todos los productos disponibles en la tienda:

SELECT DISTINCT nombre
FROM supermercado.productos
WHERE stock >= 1;

-- 7. Seleccionar el id_pedido y la cantidad de todos los pedidos:

SELECT id_pedido, cantidad
FROM supermercado.pedidos;

-- 8. Seleccionar todos los pedidos que se realizaron en el día de ayer, 2023-04-17:

SELECT *
FROM supermercado.pedidos
WHERE fecha LIKE "2023-04-17";

-- 9. Seleccionar la cantidad total del producto número 8 en todos los pedidos:

SELECT id_producto, SUM(stock) AS total_producto
FROM supermercado.productos
WHERE id_producto = 8;

-- 10. Seleccionar los pedidos que contengan productos con id_producto 1, 3 o 5:

SELECT *
FROM supermercado.pedidos
WHERE id_producto IN (1, 3, 5);


-- Consultas con JOINS


-- 1. Seleccionar los pedidos que se hayan realizado en una fecha específica (ayer: 2023-04-17) y los nombres de los productos correspondientes:

SELECT pedidos.*, productos.nombre
FROM pedidos
INNER JOIN productos
ON pedidos.id_producto = productos.id_producto
WHERE pedidos.fecha = '2023-04-17';

-- 2. Seleccionar los productos que tienen un stock menor o igual a 10 unidades y lospedidos correspondientes, incluyendo aquellos productos que no tienen ningún pedido:

SELECT productos.*, pedidos.cantidad
FROM productos
LEFT JOIN pedidos
ON productos.id_producto = pedidos.id_producto
WHERE productos.stock <= 10;

-- 3. Seleccionar los productos que no han sido vendidos y mostrar su nombre junto con un mensaje que indique que no se han vendido todavía:

# insertamos datos que estamos seguros no se han vendido todavía
INSERT INTO supermercado.productos
(id_producto, nombre, descripcion, precio, stock)
VALUES
(11, 'Mantequilla', 'Mantequilla sin sal 250g', 1.80, 15),
(12, 'cereales', 'Caja de cereales para el desayuno', 2.50, 50);

SELECT productos.nombre,
IFNULL(pedidos.cantidad, 'No se ha vendido todavía') AS cantidad
FROM productos
LEFT JOIN pedidos
ON productos.id_producto = pedidos.id_producto
WHERE pedidos.id_producto IS NULL;

-- 4. Seleccionar el nombre de los productos y la cantidad vendida en cada pedido, incluyendo los productos que no han sido vendidos todavía:

SELECT p.nombre, COALESCE(SUM(pedidos.cantidad), 0) as cantidad_vendida
FROM productos p
LEFT JOIN pedidos pe
ON p.id_producto = pe.id_producto
GROUP BY p.nombre;
SELECT productos.nombre, SUM(pedidos.cantidad) AS cantidad_vendida_total
FROM pedidos
RIGHT JOIN productos
ON productos.id_producto = pedidos.id_producto
GROUP BY productos.id_producto;

-- 5. Seleccionar el nombre de los productos y la cantidad vendida en cada pedido, excluyendo los productos que no han sido vendidos todavía:

SELECT p.nombre, SUM(pe.cantidad) as cantidad_vendida
FROM productos p
INNER JOIN pedidos pe
ON p.id_producto = pe.id_producto
GROUP BY p.nombre;

-- 6. Seleccionar el nombre de los productos y la cantidad vendida en cada pedido, excluyendo los productos que no han sido vendidos todavía y los que tengan menos de 3 ventas realizadas:

SELECT p.nombre, SUM(pe.cantidad) AS cantidad_vendida_total
FROM pedidos pe
INNER JOIN productos p
ON p.id_producto = pe.id_producto
GROUP BY p.id_producto
HAVING cantidad_vendida_total > 3;

-- 7. Seleccionar los productos que han sido vendidos al menos una vez, incluyendo los que no tienen descripción asociada:

SELECT p.nombre, p.descripcion, SUM(pe.cantidad) as cantidad_vendida
FROM productos p
LEFT JOIN pedidos pe ON p.id_producto = pe.id_producto
GROUP BY p.nombre, p.descripcion
HAVING SUM(pe.cantidad) > 0;
