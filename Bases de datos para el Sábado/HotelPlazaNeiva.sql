
CREATE DATABASE HotelPlazaNeiva;

USE HotelPlazaNeiva;

-- CREACIÓN DE TABLAS
CREATE TABLE HUESPEDES (

    id_huesped INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    documento VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    correo VARCHAR(100),
    fecha_registro DATE DEFAULT CURRENT_DATE
);

CREATE TABLE HABITACIONES (

    id_habitacion INT PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    capacidad INT NOT NULL,
    precio_noche DECIMAL(10,2) NOT NULL,
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

CREATE TABLE SERVICIOS_ADICIONALES (

    id_servicio INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2) NOT NULL,
    disponibilidad BIT DEFAULT 1
);

CREATE TABLE RESERVAS (

    id_reserva INT PRIMARY KEY,
    id_huesped INT NOT NULL,
    id_habitacion INT NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    estado VARCHAR(20) DEFAULT 'Activa',
    total_pago DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_huesped) REFERENCES HUESPEDES(id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES HABITACIONES(id_habitacion)
);

-- TABLAS PIVOTE
CREATE TABLE RESERVA_SERVICIOS (

    id_reserva_serv INT PRIMARY KEY,
    id_reserva INT NOT NULL,
    id_servicio INT NOT NULL,
    cantidad INT DEFAULT 1,
    fecha_servicio DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_reserva) REFERENCES RESERVAS(id_reserva),
    FOREIGN KEY (id_servicio) REFERENCES SERVICIOS_ADICIONALES(id_servicio)
);

CREATE TABLE ASIGNACIONES_PERSONAL (

    id_asignacion INT PRIMARY KEY,
    id_reserva INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    observaciones VARCHAR(200),
    FOREIGN KEY (id_reserva) REFERENCES RESERVAS(id_reserva),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADOS(id_empleado)
);

-- INSERCIÓN DE DATOS DE EJEMPLO
INSERT INTO HUESPEDES (id_huesped, nombre, apellido, documento, telefono, correo) VALUES
(1, 'Carlos', 'Gómez', '123456789', '3101234567', 'carlos.gomez@gmail.com'),
(2, 'María', 'López', '987654321', '3209876543', 'maria.lopez@gmail.com'),
(3, 'Juan', 'Pérez', '456789123', '3154567891', 'juan.perez@gmail.com'),
(4, 'Ana', 'Rodríguez', '321654987', '3003216549', 'ana.rodriguez@gmail.com'),
(5, 'Pedro', 'Martínez', '789123456', '3017891234', 'pedro.martinez@gmail.com');

INSERT INTO HABITACIONES (id_habitacion, numero, tipo, capacidad, precio_noche, estado) VALUES
(1, '101', 'Individual', 1, 80000, 'Disponible'),
(2, '102', 'Doble', 2, 120000, 'Disponible'),
(3, '201', 'Suite', 4, 250000, 'Ocupada'),
(4, '202', 'Familiar', 5, 180000, 'Disponible'),
(5, '301', 'Presidencial', 2, 350000, 'Mantenimiento');

INSERT INTO EMPLEADOS (id_empleado, nombre, apellido, cargo, turno, contacto) VALUES
(1, 'Ana', 'Martínez', 'Recepcionista', 'Mañana', 'ana.martinez@hotel.com'),
(2, 'Luis', 'García', 'Conserje', 'Tarde', 'luis.garcia@hotel.com'),
(3, 'Sofía', 'Ramírez', 'Limpieza', 'Mañana', 'sofia.ramirez@hotel.com'),
(4, 'Carlos', 'Hernández', 'Seguridad', 'Noche', 'carlos.hernandez@hotel.com'),
(5, 'Marta', 'Díaz', 'Gerente', 'Completo', 'marta.diaz@hotel.com');

INSERT INTO SERVICIOS_ADICIONALES (id_servicio, nombre, descripcion, precio, disponibilidad) VALUES
(1, 'Desayuno buffet', 'Desayuno completo buffet', 25000, 1),
(2, 'Servicio a la habitación', 'Menú completo servido en habitación', 35000, 1),
(3, 'Lavandería', 'Lavado y planchado de prendas', 15000, 1),
(4, 'Spa', 'Masaje relajante de 60 minutos', 80000, 1),
(5, 'Parking', 'Estacionamiento cubierto', 10000, 1);

INSERT INTO RESERVAS (id_reserva, id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado, total_pago) VALUES
(1, 1, 3, '2023-11-10', '2023-11-15', 'Activa', 1250000),
(2, 2, 1, '2023-11-12', '2023-11-14', 'Activa', 160000),
(3, 3, 2, '2023-11-05', '2023-11-10', 'Completada', 600000),
(4, 4, 4, '2023-11-20', '2023-11-25', 'Reservada', 900000),
(5, 5, 5, '2023-12-01', '2023-12-05', 'Cancelada', 1400000);

INSERT INTO RESERVA_SERVICIOS (id_reserva_serv, id_reserva, id_servicio, cantidad)
VALUES
    (1, 1, 1, 5),
    (2, 1, 4, 2),
    (3, 2, 1, 2),
    (4, 3, 3, 3),
    (5, 4, 2, 1);

INSERT INTO ASIGNACIONES_PERSONAL (id_asignacion, id_reserva, id_empleado, observaciones)
VALUES
    (1, 1, 1, 'Chekeo realizado'),
    (2, 2, 1, 'Checkeo rápido'),
    (3, 3, 2, 'Servicio especial solicitado'),
    (4, 4, 3, 'Preparación temprana'),
    (5, 5, 5, 'Reserva cancelada por cliente');

SELECT * FROM HUESPEDES;

SELECT numero, tipo, precio_noche 
FROM HABITACIONES 
WHERE estado = 'Disponible';

SELECT r.id_reserva, h.nombre, h.apellido, s.nombre as servicio, rs.cantidad
FROM RESERVAS r
JOIN HUESPEDES h ON r.id_huesped = h.id_huesped
JOIN RESERVA_SERVICIOS rs ON r.id_reserva = rs.id_reserva
JOIN SERVICIOS_ADICIONALES s ON rs.id_servicio = s.id_servicio;

SELECT nombre, apellido, cargo, turno 
FROM EMPLEADOS 
ORDER BY turno, cargo;

SELECT s.nombre, SUM(s.precio * rs.cantidad) as total_ventas
FROM SERVICIOS_ADICIONALES s
JOIN RESERVA_SERVICIOS rs ON s.id_servicio = rs.id_servicio
GROUP BY s.nombre;

DELETE FROM HUESPEDES WHERE id_huesped = 5;

DELETE FROM HABITACIONES WHERE estado = 'Mantenimiento';

DELETE FROM SERVICIOS_ADICIONALES WHERE disponibilidad = 0;

DELETE FROM RESERVAS WHERE estado = 'Cancelada';

DELETE FROM ASIGNACIONES_PERSONAL 
WHERE fecha < '2023-01-01';

INSERT INTO HUESPEDES (id_huesped, nombre, apellido, documento, telefono, correo)
VALUES (6, 'Laura', 'Fernández', '159753486', '3119876543', 'laura.fernandez@gmail.com');

INSERT INTO HABITACIONES (id_habitacion, numero, tipo, capacidad, precio_noche, estado)
VALUES (6, '103', 'Doble', 2, 150000, 'Disponible');

INSERT INTO SERVICIOS_ADICIONALES (id_servicio, nombre, descripcion, precio, disponibilidad)
VALUES (6, 'Tour ciudad', 'Recorrido guiado por la ciudad', 50000, 1);

INSERT INTO RESERVAS (id_reserva, id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado, total_pago)
VALUES (6, 2, 4, '2023-12-10', '2023-12-15', 'Activa', 900000);

INSERT INTO ASIGNACIONES_PERSONAL (id_asignacion, id_reserva, id_empleado, observaciones)
VALUES (6, 6, 2, 'Asignación para tour especial');

UPDATE HABITACIONES SET estado = 'Ocupada' WHERE id_habitacion = 2;
UPDATE HABITACIONES SET estado = 'Disponible' WHERE id_habitacion = 2;
UPDATE HABITACIONES SET estado = 'Ocupada' WHERE id_habitacion = 1;
UPDATE HABITACIONES SET estado = 'Disponible' WHERE id_habitacion = 3;
UPDATE HABITACIONES SET estado = 'Ocupada' WHERE id_habitacion = 5;

SELECT 
    sa.nombre AS servicio,
    COUNT(*) AS veces_solicitado,
    SUM(sa.precio * rs.cantidad) AS ingresos_generados,
    ROUND(AVG(sa.precio * rs.cantidad), 2) AS promedio_por_solicitud
FROM 
    RESERVA_SERVICIOS rs
JOIN 
    SERVICIOS_ADICIONALES sa ON rs.id_servicio = sa.id_servicio
GROUP BY 
    sa.nombre
ORDER BY 
    ingresos_generados DESC;

    SELECT 
    sa.nombre AS tipo_servicio,
    COUNT(*) AS total_servicios_solicitados,
    SUM(CASE WHEN ha.estado = 'Ocupada' THEN 1 ELSE 0 END) AS servicios_en_habitaciones_ocupadas,
    SUM(CASE WHEN ha.estado = 'Reservada' THEN 1 ELSE 0 END) AS servicios_en_habitaciones_reservadas,
    SUM(CASE WHEN DATEDIFF(day, r.fecha_entrada, r.fecha_salida) > 3 THEN 1 ELSE 0 END) AS servicios_estancias_largas
FROM 
    RESERVA_SERVICIOS rs
JOIN 
    SERVICIOS_ADICIONALES sa ON rs.id_servicio = sa.id_servicio
JOIN 
    RESERVAS r ON rs.id_reserva = r.id_reserva
JOIN 
    HABITACIONES ha ON r.id_habitacion = ha.id_habitacion
GROUP BY 
    sa.nombre
ORDER BY 
    total_servicios_solicitados DESC;
    SELECT 
    h.tipo AS tipo_habitacion,
    COUNT(r.id_reserva) AS total_reservas,
    AVG(DATEDIFF(day, r.fecha_entrada, r.fecha_salida)) AS estancia_promedio_dias,
    SUM(r.total_pago) AS ingresos_totales,
    SUM(r.total_pago) / COUNT(DISTINCT MONTH(r.fecha_entrada)) AS ingresos_mensuales_promedio,
    ROUND(SUM(r.total_pago) / (COUNT(r.id_reserva) * AVG(DATEDIFF(day, r.fecha_entrada, r.fecha_salida))), 2) AS tarifa_diaria_promedio
FROM 
    RESERVAS r
JOIN 
    HABITACIONES h ON r.id_habitacion = h.id_habitacion
WHERE 
    r.estado != 'Cancelada'
GROUP BY 
    h.tipo
ORDER BY 
    ingresos_totales DESC;

    SELECT 
    h.id_huesped,
    CONCAT(h.nombre, ' ', h.apellido) AS huesped,
    COUNT(r.id_reserva) AS total_estancias,
    SUM(DATEDIFF(day, r.fecha_entrada, r.fecha_salida)) AS noches_totales,
    SUM(r.total_pago) AS gasto_total,
    SUM(CASE WHEN r.fecha_entrada >= DATEADD(month, -6, CURRENT_DATE) THEN 1 ELSE 0 END) AS estancias_ultimos_6_meses,
    MAX(r.fecha_entrada) AS ultima_visita,
    DATEDIFF(day, MAX(r.fecha_entrada), CURRENT_DATE) AS dias_desde_ultima_visita,
    COUNT(DISTINCT rs.id_servicio) AS servicios_diferentes_utilizados
FROM 
    HUESPEDES h
JOIN 
    RESERVAS r ON h.id_huesped = r.id_huesped
LEFT JOIN 
    RESERVA_SERVICIOS rs ON r.id_reserva = rs.id_reserva
WHERE 
    r.estado != 'Cancelada'
GROUP BY 
    h.id_huesped, h.nombre, h.apellido
HAVING 
    COUNT(r.id_reserva) > 1
ORDER BY 
    gasto_total DESC;