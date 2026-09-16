-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Manuel Silva
-- Fecha: [16/09/2026]
-- ══════════════════════════════════════════
-- ── SECCIÓN DDL ──────────────────────────

-- Eliminamos la tabla si ya existe para poder re-ejecutar el script sin errores
DROP TABLE IF EXISTS inventario;

-- Creamos la tabla inventario
CREATE TABLE inventario (
    id_producto     INT PRIMARY KEY,          -- INT: identificador numérico simple y eficiente para PK
    nombre_producto VARCHAR(100),             -- VARCHAR(100): suficiente para nombres descriptivos sin desperdiciar espacio
    categoria       VARCHAR(50),              -- VARCHAR(50): categorías cortas y controladas
    precio_unitario DECIMAL(10,2),            -- DECIMAL(10,2): valores monetarios con precisión en centavos
    stock_actual    INT,                      -- INT: cantidad de unidades disponibles
    stock_minimo    INT,                      -- INT: umbral mínimo para reposición
    fecha_ingreso   DATE,                     -- DATE: solo necesitamos la fecha, sin hora
    activo          SMALLINT                  -- 1 = disponible, 0 = descontinuado (tipo numérico simple)
);

-- ── SECCIÓN DML ──────────────────────────
-- INSERT INTO: carga inicial de productos

INSERT INTO inventario (
    id_producto, nombre_producto, categoria,
    precio_unitario, stock_actual, stock_minimo,
    fecha_ingreso, activo
) VALUES
(1, 'Laptop Pro 15',        'Computación',   1200.00, 15, 3, '2024-01-10', 1),
(2, 'Mouse Inalámbrico',    'Accesorios',    28.00,   80, 10, '2024-01-10', 1),
(3, 'Monitor 4K 27"',       'Computación',   450.00,  12, 2, '2024-01-15', 1),
(4, 'Teclado Mecánico',     'Accesorios',    95.00,   40, 5, '2024-01-15', 1),
(5, 'Laptop Basic 14',      'Computación',   650.00,  20, 3, '2024-02-01', 1),
(6, 'Auriculares BT Pro',   'Audio',         120.00,  35, 5, '2024-02-01', 1),
(7, 'Hub USB-C 7 puertos',  'Accesorios',    45.00,   60, 10, '2024-02-10', 1),
(8, 'Webcam HD 1080p',      'Accesorios',    85.00,   25, 5, '2024-02-10', 1),
(9, 'SSD Externo 1TB',      'Almacenamiento',130.00,  18, 3, '2024-03-01', 1),
(10,'Parlante Bluetooth',   'Audio',         60.00,   45, 8, '2024-03-01', 1);

-- UPDATE: ventas del día (siempre con WHERE)

-- Laptop Pro 15 (id 1) vendió 3 unidades → stock pasa de 15 a 12
UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto = 1;

-- Mouse Inalámbrico (id 2) vendió 12 unidades → stock pasa de 80 a 68
UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto = 2;

-- Auriculares BT Pro (id 6) vendió 5 unidades → stock pasa de 35 a 30
UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto = 6;

-- UPDATE: producto descontinuado

-- La Webcam HD 1080p (id 8) fue descontinuada → activo = 0
UPDATE inventario
SET activo = 0
WHERE id_producto = 8;

-- SELECT de validación

-- Ver la tabla completa para confirmar que los datos se cargaron y actualizaron correctamente
SELECT * FROM inventario;
