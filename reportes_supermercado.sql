-- Consultas SQL para reportes del supermercado
-- Motor: PostgreSQL
-- Este archivo supone que existen las tablas clientes, domicilios, productos y ventas.

-- 1) Reporte detallado de todas las ventas
SELECT
    v.id AS id_venta,
    c.nombre AS cliente,
    p.nombre AS producto,
    v.cantidad_vendida,
    p.precios AS precio_unitario,
    (v.cantidad_vendida * p.precios) AS total_pagado,
    d.nombre AS domiciliario
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN productos p ON v.producto_id = p.id
JOIN domicilios d ON v.domicilio_id = d.id
ORDER BY v.id;

-- 2) Total de unidades vendidas y dinero recaudado por producto
SELECT
    p.nombre AS producto,
    SUM(v.cantidad_vendida) AS total_unidades_vendidas,
    SUM(v.cantidad_vendida * p.precios) AS dinero_recaudado
FROM ventas v
JOIN productos p ON v.producto_id = p.id
GROUP BY p.nombre
ORDER BY total_unidades_vendidas DESC;

-- 3) Clientes que más compras han realizado
SELECT
    c.nombre AS cliente,
    c.correo,
    COUNT(v.id) AS numero_de_compras,
    SUM(v.cantidad_vendida) AS total_productos_adquiridos
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
GROUP BY c.nombre, c.correo
ORDER BY total_productos_adquiridos DESC;

-- 4) Rendimiento de los domiciliarios
SELECT
    d.nombre AS domiciliario,
    d.telefono,
    COUNT(v.id) AS total_entregas_realizadas
FROM ventas v
JOIN domicilios d ON v.domicilio_id = d.id
GROUP BY d.nombre, d.telefono
ORDER BY total_entregas_realizadas DESC;

-- 5) Ventas con un valor total superior a $10.000
SELECT
    v.id AS id_venta,
    c.nombre AS cliente,
    p.nombre AS producto,
    v.cantidad_vendida,
    (v.cantidad_vendida * p.precios) AS total_pagado
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN productos p ON v.producto_id = p.id
WHERE (v.cantidad_vendida * p.precios) > 10000
ORDER BY total_pagado DESC;

-- 6) Productos que no han tenido ninguna venta
SELECT p.id, p.nombre, p.precios, p.stock
FROM productos p
WHERE NOT EXISTS (
    SELECT 1
    FROM ventas v
    WHERE v.producto_id = p.id
);

-- 7) Clientes que no han realizado ninguna compra
SELECT c.id, c.nombre, c.correo
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM ventas v
    WHERE v.cliente_id = c.id
);

-- 8) Venta más cara registrada en el sistema
SELECT
    v.id AS id_venta,
    c.nombre AS cliente,
    p.nombre AS producto,
    v.cantidad_vendida,
    (v.cantidad_vendida * p.precios) AS total_pagado
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN productos p ON v.producto_id = p.id
ORDER BY total_pagado DESC
LIMIT 1;

-- 9) Promedio de productos vendidos por transacción
SELECT ROUND(AVG(cantidad_vendida), 2) AS promedio_unidades_por_venta
FROM ventas;

-- 10) Total general de ingresos en la tienda
SELECT SUM(v.cantidad_vendida * p.precios) AS ingresos_totales_tienda
FROM ventas v
JOIN productos p ON v.producto_id = p.id;

-- 11) Conteo de ventas por cada cliente (incluye quienes no compraron)
SELECT
    c.nombre AS cliente,
    COALESCE(COUNT(v.id), 0) AS total_compras
FROM clientes c
LEFT JOIN ventas v ON c.id = v.cliente_id
GROUP BY c.id, c.nombre
ORDER BY total_compras DESC
LIMIT 20;

-- 12) Listar las últimas 5 ventas realizadas
SELECT
    v.id AS id_venta,
    c.nombre AS cliente,
    p.nombre AS producto,
    v.cantidad_vendida,
    v.fecha_venta
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN productos p ON v.producto_id = p.id
ORDER BY v.id DESC
LIMIT 5;

-- 13) Productos más vendidos cuyo nombre comienza con la letra A
SELECT
    p.nombre AS producto,
    SUM(v.cantidad_vendida) AS total_vendido
FROM ventas v
JOIN productos p ON v.producto_id = p.id
WHERE p.nombre LIKE 'A%'
GROUP BY p.nombre
ORDER BY total_vendido DESC;

-- 14) Ventas atendidas por cada domiciliario y porcentaje de participación
SELECT
    d.nombre AS domiciliario,
    COUNT(v.id) AS entregas,
    ROUND(
        COUNT(v.id) * 100.0 / NULLIF((SELECT COUNT(*) FROM ventas), 0),
        2
    ) AS porcentaje_participacion
FROM ventas v
JOIN domicilios d ON v.domicilio_id = d.id
GROUP BY d.nombre
ORDER BY entregas DESC;
