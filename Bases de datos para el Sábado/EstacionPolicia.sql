CREATE DATABASE EstacionPolicia;


USE EstacionPolicia;

CREATE TABLE Policias (
    id_policia INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    rango VARCHAR(30),
    fecha_ingreso DATE,
    estado VARCHAR(10) DEFAULT 'Activo' CHECK (estado IN ('Activo', 'Inactivo'))
);

CREATE TABLE Ciudadanos (
    id_ciudadano INT PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

CREATE TABLE Delitos (
    id_delito INT PRIMARY KEY,
    tipo_delito VARCHAR(50),
    descripcion VARCHAR(500),
    fecha_delito DATETIME,
    id_ciudadano INT FOREIGN KEY REFERENCES Ciudadanos(id_ciudadano)
);

CREATE TABLE Casos (
    id_caso INT PRIMARY KEY,
    codigo_caso VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    estado_caso VARCHAR(15) DEFAULT 'Abierto' CHECK (estado_caso IN ('Abierto', 'Cerrado')),
    fecha_apertura DATE,
    id_delito INT FOREIGN KEY REFERENCES Delitos(id_delito)
);

CREATE TABLE Vehiculos (
    id_vehiculo INT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE,
    marca VARCHAR(30),
    modelo VARCHAR(30),
    id_ciudadano INT FOREIGN KEY REFERENCES Ciudadanos(id_ciudadano)
);

CREATE TABLE Asignaciones_Casos (
    id_asignacion INT PRIMARY KEY,
    id_policia INT FOREIGN KEY REFERENCES Policias(id_policia),
    id_caso INT FOREIGN KEY REFERENCES Casos(id_caso),
    fecha_asignacion DATE
);

CREATE TABLE Evidencias_Delitos (
    id_evidencia INT PRIMARY KEY,
    id_delito INT FOREIGN KEY REFERENCES Delitos(id_delito),
    descripcion_evidencia VARCHAR(500),
    tipo_evidencia VARCHAR(50),
    fecha_registro DATETIME
);



INSERT INTO Ciudadanos VALUES
(1, '123456789', 'Nicolas', 'Ruiz', 'Calle 123', '3001234567'),
(2, '987654321', 'María', 'Gómez', 'Avenida 45', '3109876543'),
(3, '456789123', 'Carlos', 'Julio', 'Carrera 78', '3204567891'),
(4, '789123456', 'Mariana', 'Penagos', 'Calle 56', '3157891234'),
(5, '321654987', 'Luis', 'Rodríguez', 'Avenida 12', '3013216549');

INSERT INTO Policias VALUES
(1, 'Pedro', 'Sánchez', 'Sargento', '2020-01-27', 'Activo'),
(2, 'Laura', 'Ramírez', 'Teniente', '2018-06-20', 'Activo'),
(3, 'Steven', 'Tovar', 'Patrullero', '2021-03-10', 'Activo'),
(4, 'Sofía', 'Vargas', 'Capitán', '2015-10-05', 'Activo'),
(5, 'Andrés', 'Gutierrez', 'Cabo', '2019-08-25', 'Activo');

INSERT INTO Delitos VALUES
(1, 'Robo', 'Robo de vehiculo en centro comercial', '2025-05-10 14:30:00', 1),
(2, 'Hurto', 'Hurto de celular en via publica', '2025-06-01 09:15:00', 2),
(3, 'Vandalismo', 'Daños a propiedad publica', '2025-04-20 22:00:00', 3),
(4, 'Asalto', 'Asalto a mano armada en tienda', '2025-03-15 18:45:00', 4),
(5, 'Fraude', 'Estafa bancaria', '2025-02-28 11:00:00', 5);

INSERT INTO Casos VALUES
(1, 'CASO-001', 'Investigación de robo de vehículo', 'Abierto', '2025-05-11', 1),
(2, 'CASO-002', 'Investigación de hurto', 'Abierto', '2025-06-02', 2),
(3, 'CASO-003', 'Caso de vandalismo', 'Cerrado', '2025-04-21', 3),
(4, 'CASO-004', 'Investigación de asalto', 'Cerrado', '2025-03-16', 4),
(5, 'CASO-005', 'Caso de fraude', 'Abierto', '2025-03-01', 5);

INSERT INTO Asignaciones_Casos VALUES
(1, 1, 1, '2025-05-12'),
(2, 2, 2, '2025-06-03'),
(3, 3, 3, '2025-04-22'),
(4, 4, 4, '2025-03-17'),
(5, 5, 5, '2025-03-02');

INSERT INTO Vehiculos VALUES
(1, 'ABC123', 'Toyota', 'Corolla', 1),
(2, 'XYZ789', 'Honda', 'Civic', 2),
(3, 'DEF456', 'Ford', 'Focus', 3),
(4, 'GHI789', 'Chevrolet', 'Spark', 4),
(5, 'JKL012', 'Mazda', '3', 5);

INSERT INTO Evidencias_Delitos VALUES
(1, 1, 'Huellas dactilares en vehículo', 'Huellas', '2025-05-10 15:00:00'),
(2, 2, 'Video de cámara de seguridad', 'Video', '2025-06-01 10:00:00'),
(3, 3, 'Pintura encontrada en el lugar', 'Material', '2025-04-20 23:00:00'),
(4, 4, 'Arma blanca recuperada', 'Arma', '2025-03-15 19:00:00'),
(5, 5, 'Documentos bancarios falsificados', 'Documento', '2025-02-28 12:00:00');

 GO -- apartir de aquí me toca usar GO para separar los bloques
 
 
CREATE OR ALTER PROCEDURE ActualizarEstadoCaso 
    @id_caso INT,
    @nuevo_estado VARCHAR(15)
AS
BEGIN
    IF @nuevo_estado NOT IN ('Abierto', 'Cerrado')
    BEGIN
        RAISERROR('Estado no válido. Solo se permiten: Abierto, Cerrado', 16, 1);
        RETURN;
    END;

    UPDATE Casos
    SET estado_caso = @nuevo_estado
    WHERE id_caso = @id_caso;
END;
GO



-- 10 SELECT con funciones
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM Policias;

SELECT nombre, apellido, DATEDIFF(YEAR, fecha_ingreso, GETDATE()) AS años_servicio FROM Policias;

SELECT tipo_delito, YEAR(fecha_delito) AS año, MONTH(fecha_delito) AS mes, COUNT(*) AS total_delitos
FROM Delitos
GROUP BY tipo_delito, YEAR(fecha_delito), MONTH(fecha_delito);

SELECT codigo_caso, UPPER(COALESCE(descripcion, 'SIN DESCRIPCIÓN')) AS descripcion_mayus FROM Casos;

SELECT p.nombre, p.apellido, COUNT(ac.id_caso) AS casos_asignados
FROM Policias p
LEFT JOIN Asignaciones_Casos ac ON p.id_policia = ac.id_policia
WHERE ac.id_caso IN (SELECT id_caso FROM Casos WHERE estado_caso = 'Abierto')
GROUP BY p.id_policia, p.nombre, p.apellido;

SELECT apellido, UPPER(apellido) AS apellido_mayusculas FROM Ciudadanos;

SELECT tipo_delito, LOWER(tipo_delito) AS tipo_minusculas FROM Delitos;

SELECT UPPER(placa) AS placa_mayusculas FROM Vehiculos;

SELECT estado_caso, AVG(DATEDIFF(DAY, fecha_apertura, GETDATE())) AS promedio_dias
FROM Casos
GROUP BY estado_caso;

SELECT nombre, REPLACE(nombre, ' ', '-') AS nombre_modificado FROM Ciudadanos;

-- 5 SELECT adicionales
SELECT nombre, apellido, cedula FROM Ciudadanos
WHERE id_ciudadano NOT IN (SELECT id_ciudadano FROM Delitos);

SELECT c.codigo_caso, d.tipo_delito
FROM Casos c JOIN Delitos d ON c.id_delito = d.id_delito
WHERE c.estado_caso = 'Cerrado';

SELECT nombre, apellido, rango FROM Policias
WHERE DATEDIFF(DAY, fecha_ingreso, GETDATE()) > 730;

SELECT descripcion_evidencia, tipo_evidencia FROM Evidencias_Delitos
WHERE fecha_registro >= DATEADD(MONTH, -1, GETDATE());

SELECT v.placa, v.marca, c.nombre, c.apellido
FROM Vehiculos v
JOIN Ciudadanos c ON v.id_ciudadano = c.id_ciudadano
ORDER BY c.apellido;

-- 5 SUBCONSULTAS
SELECT nombre, apellido
FROM Policias
WHERE id_policia IN (SELECT id_policia FROM Asignaciones_Casos WHERE id_caso = 1);

SELECT codigo_caso FROM Casos
WHERE id_delito IN (SELECT id_delito FROM Delitos WHERE tipo_delito = 'Robo');

SELECT cedula, nombre FROM Ciudadanos
WHERE id_ciudadano NOT IN (
    SELECT id_ciudadano FROM Delitos WHERE fecha_delito > '2025-06-03'
);

SELECT tipo_delito, COUNT(*) AS total
FROM Delitos
WHERE id_ciudadano IN (
    SELECT id_ciudadano FROM Ciudadanos WHERE direccion LIKE '%Calle%'
)
GROUP BY tipo_delito;

SELECT id_caso, codigo_caso FROM Casos
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Casos WHERE id_caso = Casos.id_caso AND id_policia = 2
);

-- 5 UPDATE
UPDATE Policias SET nombre = LOWER(nombre);

UPDATE Ciudadanos
SET telefono = CONCAT('+57', telefono)
WHERE telefono NOT LIKE '+57%'; 

UPDATE Casos SET descripcion = 'Actualizado';

UPDATE Delitos SET descripcion = COALESCE(descripcion, 'Ninguna');

UPDATE Asignaciones_Casos
SET fecha_asignacion = DATEADD(DAY, 1, fecha_asignacion);

-- 5 ALTER
ALTER TABLE Policias ADD correo VARCHAR(50);

ALTER TABLE Delitos ADD gravedad VARCHAR(20) CHECK (gravedad IN ('Leve', 'Moderado', 'Grave'));

ALTER TABLE Casos ADD prioridad INT DEFAULT 1;

ALTER TABLE Vehiculos ALTER COLUMN marca VARCHAR(50);

-- 5 DELETE
DELETE FROM Evidencias_Delitos;
DELETE FROM Asignaciones_Casos;
DELETE FROM Vehiculos;
DELETE FROM Casos;
DELETE FROM Delitos;

-- 5 TRUNCATE
TRUNCATE TABLE Policias;
TRUNCATE TABLE Evidencias_Delitos;
TRUNCATE TABLE Asignaciones_Casos;
TRUNCATE TABLE Vehiculos;
TRUNCATE TABLE Delitos;

-- 5 DROP
DROP TABLE Evidencias_Delitos;
DROP TABLE Asignaciones_Casos;
DROP TABLE Vehiculos;
DROP TABLE Casos;
DROP TABLE Delitos;