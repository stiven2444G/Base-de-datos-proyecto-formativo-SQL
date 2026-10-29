-- ============================================================
-- Base de datos de ventas y domicilios
-- Motor: PostgreSQL
-- ============================================================

-- Opcional: crear y seleccionar una base de datos aparte desde psql:
-- CREATE DATABASE tienda_domicilios;
-- \c tienda_domicilios

-- 1. Tabla Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(255),
    direccion VARCHAR(200),
    telefono VARCHAR(10)
);

-- 2. Tabla Productos
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    description TEXT,
    precios NUMERIC(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

-- 3. Tabla Domicilios
CREATE TABLE IF NOT EXISTS domicilios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(10),
    descrpcion TEXT
);

-- 4. Tabla Ventas
-- Relaciona clientes, productos y domicilios.
CREATE TABLE IF NOT EXISTS ventas (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    producto_id INT REFERENCES productos(id),
    domicilio_id INT REFERENCES domicilios(id),
    cantidad_vendida INT NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Consultas de verificación
-- ============================================================

-- Ver todos los clientes
-- SELECT * FROM clientes;

-- Ver todos los productos
-- SELECT * FROM productos;

-- Ver todos los domicilios
-- SELECT * FROM domicilios;

-- Ver todas las ventas
-- SELECT * FROM ventas;

-- Consultar las ventas con los nombres relacionados
-- SELECT
--     v.id AS venta_id,
--     c.nombre AS cliente,
--     p.nombre AS producto,
--     d.nombre AS domicilio,
--     v.cantidad_vendida,
--     v.fecha_venta
-- FROM ventas AS v
-- LEFT JOIN clientes AS c ON v.cliente_id = c.id
-- LEFT JOIN productos AS p ON v.producto_id = p.id
-- LEFT JOIN domicilios AS d ON v.domicilio_id = d.id
-- ORDER BY v.fecha_venta DESC;
