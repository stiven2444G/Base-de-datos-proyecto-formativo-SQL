-- Script SQL para PostgreSQL
-- Inserta clientes, domiciliarios, productos, actualiza el stock
-- y registra 20 ventas de prueba.
--
-- Importante:
-- 1. Este script supone que las tablas clientes, domicilios, productos y ventas
--    ya existen y tienen las columnas usadas abajo.
-- 2. Usa generate_series, arrays y random(), funciones propias de PostgreSQL.
-- 3. Los ID generados en ventas se asumen consecutivos desde 1.
--    Si las tablas ya contienen registros, revisa los ID antes de ejecutar.

-- Insertar 10,000 clientes automáticos
INSERT INTO clientes (nombre, correo, direccion, telefono)
SELECT
    'Cliente ' || i,
    'cliente' || i || '@correo.com',
    'Calle ' || i || ' #' || (i % 100 + 1),
    '300' || LPAD(CAST(i AS TEXT), 7, '0')
FROM generate_series(1, 10000) AS s(i);

-- Insertar 5 domiciliarios de prueba
INSERT INTO domicilios (nombre, telefono)
SELECT
    'Domicilio ' || i,
    '300' || LPAD(CAST(i AS TEXT), 7, '0')
FROM generate_series(1, 5) AS s(i);

-- Asignar nombres y apellidos aleatorios a los clientes
UPDATE clientes
SET nombre = (
    (ARRAY['Carlos', 'María', 'Juan', 'Ana', 'Luis', 'Sofía', 'Pedro', 'Laura', 'Diego', 'Camila', 'Andrés', 'Valentina', 'Javier', 'Daniela', 'Fernando', 'Mariana'])[floor(random() * 16 + 1)::INT]
    || ' ' ||
    (ARRAY['Gómez', 'Rodríguez', 'López', 'Martínez', 'García', 'Pérez', 'Torres', 'Sánchez', 'Ramírez', 'Díaz', 'Vargas', 'Castro', 'Morales', 'Rojas'])[floor(random() * 14 + 1)::INT]
);

-- Asignar nombres y apellidos aleatorios a los domiciliarios
UPDATE domicilios
SET nombre = (
    (ARRAY['Carlos', 'María', 'Juan', 'Ana', 'Luis', 'Sofía', 'Pedro', 'Laura', 'Diego', 'Camila', 'Andrés', 'Valentina', 'Javier', 'Daniela', 'Fernando', 'Mariana'])[floor(random() * 16 + 1)::INT]
    || ' ' ||
    (ARRAY['Gómez', 'Rodríguez', 'López', 'Martínez', 'García', 'Pérez', 'Torres', 'Sánchez', 'Ramírez', 'Díaz', 'Vargas', 'Castro', 'Morales', 'Rojas'])[floor(random() * 14 + 1)::INT]
);

-- Insertar el catálogo de productos
INSERT INTO productos (nombre, description, precios, stock)
VALUES
('Arroz Diana', 'Arroz Blanco 500 G', '2500.00', '1'),
('Arroz Boluga', 'Arroz Blanco 500 G', '2500.00', '1'),
('Arroz Premium', 'Arroz Blanco 500 G', '3000.00', '1'),
('Arroz Con Fideos', 'Arroz Blanco 500 G', '3000.00', '1'),
('Arroz Roa', 'Arroz Blanco 500 G', '2500.00', '1'),
('Lentejas Diana', 'Lentejas 400 G', '3500.00', '1'),
('Lentejas Maritza', 'Lentejas 454 G', '3500.00', '1'),
('Frijol Diana', 'Frijol 250 G', '2900.00', '1'),
('Frijol Maritza', 'Frijol 454 G', '11900.00', '1'),
('Fideos Doria', 'Pasta 250 G', '2700.00', '1'),
('Spaghetti Doria', 'Pasta 250 G', '2700.00', '1'),
('Concha Doria', 'Pasta 250 G', '2700.00', '1'),
('Lassagna Doria', 'Pasta 200 G', '7400.00', '1'),
('Spagetti La Muñeca', 'Pasta 250 G', '2500.00', '1'),
('Rigatone La Muñeca', 'Pasta 250 G', '2500.00', '1'),
('Cebolla De Angel La Muñeca', 'Pasta 200 G', '2500.00', '1'),
('Azúcar Mayagüez Blanca', 'Azúcar 500 G', '2800.00', '1'),
('Azúcar Mayagüez Morena', 'Azúcar 500 G', '3000.00', '1'),
('Sal Refisal Marina', 'Sal 400 G', '2500.00', '1'),
('Sal Refisal Alta Pureza', 'Sal 400 G', '2000.00', '1'),
('Salero Refisal Limon', 'Sal 110 G', '4800.00', '1'),
('Salero Refisal Tomillo Laurel', 'Sal 100 G', '5000.00', '1'),
('Salero Refisal Alta Pureza', 'Sal 130 G', '1500.00', '1'),
('Pop Corn Maritza', 'Maíz Pira 450 G', '3300.00', '1'),
('Garbanzos Diana', 'Garbanzos 500 G', '3200.00', '1'),
('Arveja Amarilla Maritza', 'Arvejas 450 G', '2000.00', '1'),
('Arvejas Diana', 'Arvejas 500 G', '2600.00', '1'),
('Carne de res', 'Carne de res 500 g', '12000.00', '1'),
('Pollo', 'Pechuga de pollo', '10500.00', '1'),
('Gaseosa', 'Gaseosa coca cola 1.75 L', '4000.00', '1'),
('Speeed Max Lata', 'Speed 250 Ml', '2000.00', '1'),
('Speeed Max', 'Speed 250 Ml', '1500.00', '1'),
('Pepsi', 'Gaseosa 400 Ml', '2200.00', '1'),
('Postobon Uva', 'Gaseosa 400 Ml', '2500.00', '1'),
('Postobon Uva', 'Gaseosa 400 Ml', '2500.00', '1'),
('Postobon Colombiana', 'Gaseosa 400 Ml', '2500.00', '1'),
('Postobon Manzana', 'Gaseosa 400 Ml', '2500.00', '1'),
('Coca-Cola', 'Gaseosa 250 Ml', '2000.00', '1'),
('Gaseosa Del Valle', 'Gaseosa 400 Ml', '25000.00', '1'),
('Gaseosa Quatro', 'Gaseosa 400 Ml', '25000.00', '1'),
('Coca & Cola', 'Gaseosa 400 Ml', '3000.00', '1'),
('H2OH!', 'H2OH! 1.5 L', '2500.00', '1'),
('Leche Colanta', 'Leche 1 litro', '4200.00', '1'),
('Leche Trebol', 'Leche 900 Ml', '4000.00', '1'),
('Leche Trebol', 'Leche 900 Ml', '4000.00', '1'),
('Leche Colanta Entera', 'Leche 1 L', '5900.00', '1'),
('Leche Alqueria Media', 'Leche 400 Ml', '2400.00', '1'),
('Leche Alqueria Meg', 'Leche 1.100 Ml', '6900.00', '1'),
('Leche Alqueria Meg Delactosada', 'Leche 1.100 Ml', '6900.00', '1'),
('Leche Semidescremada Deslactosada', 'Leche 1.100 Ml', '5900.00', '1'),
('Leche Trebol', 'Leche 900 Ml', '4000.00', '1'),
('Jabón', 'Jabón Tigre 450 g', '3000.00', '1'),
('Detergente', 'Detergente AK-1.3 Lt', '6500.00', '1'),
('Papel higiénico', 'familia-expert', '7000.00', '1'),
('Manzana', 'Manzana roja', '4500.00', '1'),
('Banano', 'Banano por kilo', '3500.00', '1'),
('Zanahoria', 'Zanahoria por kilo', '3000.00', '1'),
('Queso', 'Queso Colanta 250 g', '8000.00', '1'),
('Yogur', 'Yogur original fresa 900 g', '5500.00', '1'),
('Galletas', 'Galletas festival de x6 unidades', '2500.00', '1'),
('Palomitas', 'Palomitas de maíz', '3000.00', '1');

-- Actualizar el stock de los productos con valores aleatorios entre 10 y 100
UPDATE productos
SET stock = floor(random() * (100 - 10 + 1) + 10);

-- Insertar 20 ventas aleatorias de prueba
INSERT INTO ventas (cliente_id, producto_id, domicilio_id, cantidad_vendida)
SELECT
    floor(random() * 10000 + 1)::INT,
    floor(random() * 61 + 1)::INT,
    floor(random() * 5 + 1)::INT,
    floor(random() * 3 + 1)::INT
FROM generate_series(1, 20);
