CREATE DATABASE Mobileinfinix;

USE MobileInfinix;

-- CREACIÓN DE TABLAS
CREATE TABLE CLIENTES (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    documento VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    fecha_registro DATE 
);

CREATE TABLE CELULARES (
    id_celular INT PRIMARY KEY,
    modelo VARCHAR(50) UNIQUE NOT NULL,
    marca VARCHAR(30) NOT NULL,
    almacenamiento INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'Disponible'
);

CREATE TABLE EMPLEADOS (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cargo VARCHAR(30) NOT NULL,
    turno VARCHAR(20) NOT NULL,
    contacto VARCHAR(100) NOT NULL
);

CREATE TABLE ACCESORIOS (
    id_accesorio INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2) NOT NULL,
    disponibilidad BIT DEFAULT 1
);

CREATE TABLE VENTAS (
    id_venta INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_celular INT NOT NULL,
    fecha_venta DATE NOT NULL,
    total_pago DECIMAL(12,2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'Completada',
    FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id_cliente),
    FOREIGN KEY (id_celular) REFERENCES CELULARES(id_celular)
);

-- TABLAS PIVOTE
CREATE TABLE VENTA_ACCESORIOS (
    id_venta_accesorio INT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_accesorio INT NOT NULL,
    cantidad INT DEFAULT 1,
    FOREIGN KEY (id_venta) REFERENCES VENTAS(id_venta),
    FOREIGN KEY (id_accesorio) REFERENCES ACCESORIOS(id_accesorio)
);

CREATE TABLE ASIGNACIONES_VENTAS (
    id_asignacion INT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha DATETIME,
    observaciones VARCHAR(200),
    FOREIGN KEY (id_venta) REFERENCES VENTAS(id_venta),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADOS(id_empleado)
);

-- INSERCIÓN DE DATOS
INSERT INTO CLIENTES (id_cliente, nombre, apellido, documento, telefono, fecha_registro) 
VALUES
(1, 'Juan', 'Pérez', '1001234567', '3101234567', '2023-01-15'),
(2, 'María', 'Gómez', '2002345678', '3202345678', '2023-02-20'),
(3, 'Carlos', 'Rodríguez', '3003456789', '3153456789', '2023-03-10'),
(4, 'Ana', 'Martínez', '4004567890', '3004567890', '2023-04-05'),
(5, 'Luis', 'Hernández', '5005678901', '3015678901', '2023-05-12'),
(6, 'Sofía', 'López', '6006789012', '3026789012', '2023-06-18'),
(7, 'Pedro', 'García', '7007890123', '3177890123', '2023-07-22'),
(8, 'Laura', 'Díaz', '8008901234', '3188901234', '2023-08-30');

INSERT INTO CELULARES (id_celular, modelo, marca, almacenamiento, precio, estado) 
VALUES
(1, 'Infinix Hot 30i', 'Infinix', 64, 499000, 'Disponible'),
(2, 'Infinix Hot 30', 'Infinix', 128, 699000, 'Disponible'),
(3, 'Infinix Note 30', 'Infinix', 256, 899000, 'Disponible'),
(4, 'Infinix Zero 30 5G', 'Infinix', 256, 1299000, 'Disponible'),
(5, 'Infinix Smart 8', 'Infinix', 64, 549000, 'Disponible'),
(6, 'Infinix GT 10 Pro', 'Infinix', 256, 1199000, 'Disponible'),
(7, 'Infinix Note 40 pro', 'Infinix', 256, 999000, 'Disponible'),
(8, 'Infinix Hot 20 Play', 'Infinix', 64, 599000, 'Disponible');

INSERT INTO EMPLEADOS (id_empleado, nombre, apellido, cargo, turno, contacto) VALUES
(1, 'Andrés', 'Vargas', 'Asesor de ventas', 'Mañana', 'andres.vargas@mobileinfinix.com'),
(2, 'Camila', 'Rojas', 'Asesor de ventas', 'Tarde', 'camila.rojas@mobileinfinix.com'),
(3, 'Jorge', 'Silva', 'Gerente', 'Completo', 'jorge.silva@mobileinfinix.com'),
(4, 'Diana', 'Mendoza', 'Técnico de servicio', 'Mañana', 'diana.mendoza@mobileinfinix.com'),
(5, 'Ricardo', 'Ortiz', 'Almacenista', 'Tarde', 'ricardo.ortiz@mobileinfinix.com');

INSERT INTO ACCESORIOS (id_accesorio, nombre, descripcion, precio, disponibilidad)
VALUES
(1, 'Cargador Infinix 70W', 'Cargador rápido original Infinix', 79900, 1),
(2, 'Funda Infinix transparente', 'Funda protectora oficial', 29900, 1),
(3, 'Auriculares Infinix XE27', 'Auriculares inalámbricos con cancelación de ruido', 149900, 1),
(4, 'Protector pantalla Infinix', 'Vidrio templado 9H para modelos Hot y Note', 19900, 1),
(5, 'Power Bank Infinix 10000mAh', 'Batería portátil con carga rápida', 99900, 1),
(6, 'Cable USB-C Infinix', 'Cable de datos original 1.5m', 15900, 1),
(7, 'Soporte para celular', 'Soporte ajustable para escritorio', 24900, 1),
(8, 'Kit limpieza Infinix', 'Paño microfibra y líquido limpiador', 12900, 1);

INSERT INTO VENTAS (id_venta, id_cliente, id_celular, fecha_venta, total_pago, estado) VALUES
(1, 1, 4, '2023-09-10', 1299000, 'Completada'),
(2, 2, 2, '2023-09-12', 699000, 'Completada'),
(3, 3, 6, '2023-09-15', 1199000, 'Completada'),
(4, 4, 3, '2023-09-18', 899000, 'Completada'),
(5, 5, 1, '2023-09-20', 499000, 'Completada'),
(6, 6, 5, '2023-09-22', 549000, 'Completada'),
(7, 7, 7, '2023-09-25', 799000, 'Completada'),
(8, 8, 8, '2023-09-28', 599000, 'Completada');

INSERT INTO VENTA_ACCESORIOS (id_venta_accesorio, id_venta, id_accesorio, cantidad)
VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 4, 2),
(4, 2, 2, 1),
(5, 3, 3, 1),
(6, 3, 5, 1),
(7, 4, 1, 1),
(8, 4, 4, 1),
(9, 5, 6, 2),
(10, 6, 7, 1),
(11, 7, 3, 1),
(12, 8, 2, 1),
(13, 8, 8, 1);

INSERT INTO ASIGNACIONES_VENTAS (id_asignacion, id_venta, id_empleado, fecha, observaciones) VALUES
(1, 1, 1, '2023-09-10 10:30:00', 'Cliente satisfecho con la compra del Zero 30 5G'),
(2, 2, 2, '2023-09-12 15:45:00', 'Venta estándar con garantía extendida'),
(3, 3, 1, '2023-09-15 11:20:00', 'Cliente compró GT 10 Pro con accesorios premium'),
(4, 4, 2, '2023-09-18 16:30:00', 'Venta con promoción de lanzamiento'),
(5, 5, 1, '2023-09-20 09:15:00', 'Primer celular del cliente'),
(6, 6, 2, '2023-09-22 14:50:00', 'Venta rápida, cliente conocía el modelo'),
(7, 7, 1, '2023-09-25 10:10:00', 'Cliente compró auriculares XE27 adicionales'),
(8, 8, 2, '2023-09-28 17:20:00', 'Venta con kit de limpieza incluido');
 
 GO

SELECT * FROM CLIENTES;

--  Mostrar celulares disponibles
SELECT modelo, marca, precio 
FROM CELULARES 
WHERE estado = 'Disponible';

--  Ventas con accesorios
SELECT v.id_venta, c.nombre, c.apellido, a.nombre as accesorio, va.cantidad
FROM VENTAS v
JOIN CLIENTES c ON v.id_cliente = c.id_cliente
JOIN VENTA_ACCESORIOS va ON v.id_venta = va.id_venta
JOIN ACCESORIOS a ON va.id_accesorio = a.id_accesorio;

--  Empleados por turno
SELECT nombre, apellido, cargo, turno 
FROM EMPLEADOS 
ORDER BY turno, cargo;

--  Total de ventas por accesorio
SELECT a.nombre, SUM(a.precio * va.cantidad) as total_ventas
FROM ACCESORIOS a
JOIN VENTA_ACCESORIOS va ON a.id_accesorio = va.id_accesorio
GROUP BY a.nombre;

-- OPERACIONES DELETE
-- 1. Eliminar un cliente específico
DELETE FROM CLIENTES WHERE id_cliente = 5;

-- 2. Eliminar celulares en reparación (no aplica ya que no hay en reparación)
-- DELETE FROM CELULARES WHERE estado = 'En reparación';

-- 3. Eliminar accesorios no disponibles
DELETE FROM ACCESORIOS WHERE disponibilidad = 0;

-- 4. Eliminar ventas canceladas
DELETE FROM VENTAS WHERE estado = 'Cancelada';

-- 5. Eliminar asignaciones antiguas
DELETE FROM ASIGNACIONES_VENTAS 
WHERE fecha < '2023-01-01';

-- OPERACIONES INSERT
-- 1. Nuevo cliente
INSERT INTO CLIENTES (id_cliente, nombre, apellido, documento, telefono, fecha_registro)
VALUES (9, 'Daniela', 'Ramírez', '9009012345', '3109012345', '2023-10-05');

-- 2. Nuevo celular
INSERT INTO CELULARES (id_celular, modelo, marca, almacenamiento, precio, estado)
VALUES (9, 'Infinix Hot 40i', 'Infinix', 128, 649000, 'Disponible');

-- 3. Nuevo accesorio
INSERT INTO ACCESORIOS (id_accesorio, nombre, descripcion, precio, disponibilidad)
VALUES (9, 'Estuche Infinix premium', 'Estuche de cuero genuino', 89900, 1);

-- 4. Nueva venta
INSERT INTO VENTAS (id_venta, id_cliente, id_celular, fecha_venta, total_pago, estado)
VALUES (9, 3, 9, '2023-10-10', 649000, 'Completada');

-- 5. Nueva asignación de venta
INSERT INTO ASIGNACIONES_VENTAS (id_asignacion, id_venta, id_empleado, fecha, observaciones)
VALUES (9, 9, 1, '2023-10-10 11:30:00', 'Venta con promoción de lanzamiento');

-- OPERACIONES UPDATE
UPDATE CELULARES SET estado = 'Vendido' WHERE id_celular = 2;
UPDATE CELULARES SET estado = 'Disponible' WHERE id_celular = 2;
UPDATE CELULARES SET estado = 'Vendido' WHERE id_celular = 1;
UPDATE CELULARES SET estado = 'Disponible' WHERE id_celular = 3;
UPDATE CELULARES SET estado = 'Vendido' WHERE id_celular = 5;

-- CONSULTAS ANALÍTICAS
-- 1. Análisis de ventas por accesorio
SELECT 
    a.nombre AS accesorio,
    COUNT(*) AS veces_vendido,
    SUM(a.precio * va.cantidad) AS ingresos_generados,
    ROUND(AVG(a.precio * va.cantidad), 2) AS promedio_por_venta

FROM 
    VENTA_ACCESORIOS va
JOIN 
    ACCESORIOS a ON va.id_accesorio = a.id_accesorio
GROUP BY 
    a.nombre
ORDER BY 
    ingresos_generados DESC;

SELECT 
    c.marca,
    COUNT(v.id_venta) AS total_ventas,
    SUM(CASE WHEN va.id_accesorio IS NOT NULL THEN 1 ELSE 0 END) AS ventas_con_accesorios,
    SUM(v.total_pago) AS ingresos_totales,
    ROUND(AVG(v.total_pago), 2) AS promedio_venta
FROM 
    VENTAS v
JOIN 
    CELULARES c ON v.id_celular = c.id_celular
LEFT JOIN 
    VENTA_ACCESORIOS va ON v.id_venta = va.id_venta
WHERE 
    v.estado = 'Completada'
GROUP BY 
    c.marca
ORDER BY 
    ingresos_totales DESC;
-- 3. Comportamiento de clientes
SELECT 
    cl.id_cliente,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
    COUNT(v.id_venta) AS total_compras,
    SUM(v.total_pago) AS gasto_total,
    MAX(v.fecha_venta) AS ultima_compra,
    DATEDIFF(DAY, MAX(v.fecha_venta), GETDATE()) AS dias_desde_ultima_compra,
    COUNT(DISTINCT va.id_accesorio) AS accesorios_diferentes_comprados
FROM 
    CLIENTES cl
JOIN 
    VENTAS v ON cl.id_cliente = v.id_cliente
LEFT JOIN 
    VENTA_ACCESORIOS va ON v.id_venta = va.id_venta
WHERE 
    v.estado = 'Completada'
GROUP BY 
    cl.id_cliente, cl.nombre, cl.apellido
HAVING 
    COUNT(v.id_venta) > 1
ORDER BY 
    gasto_total DESC;

 GO