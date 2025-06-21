CREATE DATABASE RecetasDeliciosas;
USE RecetasDeliciosas;


CREATE TABLE CHEFS (
    id_chef INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    experiencia INT NOT NULL,
    fecha_ingreso DATE 
);

CREATE TABLE RECETAS (
    id_receta INT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    tipo_comida VARCHAR(30) NOT NULL,
    tiempo_preparacion INT NOT NULL,
    dificultad VARCHAR(20) NOT NULL,
    estado VARCHAR(20) DEFAULT 'Publicada'
);

CREATE TABLE INGREDIENTES (
    id_ingrediente INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL,
    precio_por_unidad DECIMAL(10,2) NOT NULL
);

CREATE TABLE UTENSILIOS (
    id_utensilio INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    material VARCHAR(30) NOT NULL
);

CREATE TABLE PREPARACIONES (
    id_preparacion INT PRIMARY KEY,
    id_chef INT NOT NULL,
    id_receta INT NOT NULL,
    fecha_preparacion DATE NOT NULL,
    calificacion DECIMAL(3,1),
    FOREIGN KEY (id_chef) REFERENCES CHEFS(id_chef),
    FOREIGN KEY (id_receta) REFERENCES RECETAS(id_receta)
);

-- TABLAS PIVOTE
CREATE TABLE RECETA_INGREDIENTES (
    id_receta_ingrediente INT PRIMARY KEY,
    id_receta INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_receta) REFERENCES RECETAS(id_receta),
    FOREIGN KEY (id_ingrediente) REFERENCES INGREDIENTES(id_ingrediente)
);

CREATE TABLE RECETA_UTENSILIOS (
    id_receta_utensilio INT PRIMARY KEY,
    id_receta INT NOT NULL,
    id_utensilio INT NOT NULL,
    FOREIGN KEY (id_receta) REFERENCES RECETAS(id_receta),
    FOREIGN KEY (id_utensilio) REFERENCES UTENSILIOS(id_utensilio)
);


INSERT INTO CHEFS (id_chef, nombre, apellido, especialidad, experiencia, fecha_ingreso) 
VALUES
(1, 'María', 'González', 'Repostería', 10, '2018-03-15'),
(2, 'Carlos', 'Martínez', 'Cocina internacional', 8, '2019-05-20'),
(3, 'Ana', 'López', 'Cocina vegetariana', 5, '2020-02-10'),
(4, 'Pedro', 'Sánchez', 'Carnes', 12, '2017-11-05'),
(5, 'Lucía', 'Ramírez', 'Cocina asiática', 7, '2019-08-22');

INSERT INTO RECETAS (id_receta, nombre, tipo_comida, tiempo_preparacion, dificultad, estado) 
VALUES
(1, 'Tarta de manzana clásica', 'Postre', 90, 'Media', 'Publicada'),
(2, 'Risotto de champiñones', 'Principal', 60, 'Alta', 'Publicada'),
(3, 'Ensalada César', 'Entrante', 20, 'Baja', 'Publicada'),
(4, 'Pollo al curry', 'Principal', 45, 'Media', 'Publicada'),
(5, 'Brownie de chocolate', 'Postre', 50, 'Baja', 'Publicada'),
(6, 'Sopa de tomate', 'Entrante', 30, 'Baja', 'Publicada'),
(7, 'Lasagna boloñesa', 'Principal', 120, 'Alta', 'Publicada'),
(8, 'Tiramisú', 'Postre', 80, 'Media', 'Publicada');

INSERT INTO INGREDIENTES (id_ingrediente, nombre, tipo, unidad_medida, precio_por_unidad) 
VALUES
(1, 'Harina de trigo', 'Granos', 'kg', 2.50),
(2, 'Azúcar', 'Endulzante', 'kg', 1.80),
(3, 'Huevos', 'Lácteos', 'unidad', 0.30),
(4, 'Manzanas', 'Frutas', 'kg', 3.20),
(5, 'Champiñones', 'Vegetales', 'kg', 4.50),
(6, 'Arroz arbóreo', 'Granos', 'kg', 5.00),
(7, 'Pollo', 'Carnes', 'kg', 7.80),
(8, 'Leche', 'Lácteos', 'litro', 1.20),
(9, 'Tomates', 'Vegetales', 'kg', 2.30),
(10, 'Queso parmesano', 'Lácteos', 'kg', 12.00),
(11, 'Chocolate negro', 'Dulces', 'kg', 8.50),
(12, 'Mantequilla', 'Lácteos', 'kg', 6.00);

INSERT INTO UTENSILIOS (id_utensilio, nombre, descripcion, material) 
VALUES
(1, 'Batidora', 'Para mezclar ingredientes', 'Acero inoxidable'),
(2, 'Olla', 'Para cocinar a fuego lento', 'Acero'),
(3, 'Rodillo', 'Para estirar masas', 'Madera'),
(4, 'Cuchillo de chef', 'Para cortar y picar', 'Acero'),
(5, 'Tabla de cortar', 'Superficie para cortar alimentos', 'Plástico'),
(6, 'Molde para horno', 'Para hornear pasteles', 'Aluminio'),
(7, 'Espátula', 'Para mezclar y servir', 'Silicona'),
(8, 'Termómetro de cocina', 'Para medir temperaturas', 'Acero');

INSERT INTO PREPARACIONES (id_preparacion, id_chef, id_receta, fecha_preparacion, calificacion) 
VALUES
(1, 1, 1, '2023-09-10', 4.8),
(2, 2, 2, '2023-09-12', 4.5),
(3, 3, 3, '2023-09-15', 4.2),
(4, 4, 4, '2023-09-18', 4.7),
(5, 5, 5, '2023-09-20', 4.9),
(6, 1, 6, '2023-09-22', 4.0),
(7, 2, 7, '2023-09-25', 4.6),
(8, 3, 8, '2023-09-28', 4.8);

INSERT INTO RECETA_INGREDIENTES (id_receta_ingrediente, id_receta, id_ingrediente, cantidad) 
VALUES
(1, 1, 1, 0.300),
(2, 1, 2, 0.200),
(3, 1, 3, 3.000),
(4, 1, 4, 0.800),
(5, 2, 5, 0.500),
(6, 2, 6, 0.400),
(7, 2, 8, 0.500),
(8, 3, 9, 0.600),
(9, 3, 10, 0.100),
(10, 4, 7, 1.000),
(11, 4, 5, 0.300),
(12, 5, 11, 0.400),
(13, 5, 2, 0.300),
(14, 5, 3, 4.000),
(15, 6, 9, 1.200),
(16, 7, 1, 0.400),
(17, 7, 7, 1.200),
(18, 8, 3, 6.000),
(19, 8, 2, 0.250),
(20, 8, 8, 0.500);

INSERT INTO RECETA_UTENSILIOS (id_receta_utensilio, id_receta, id_utensilio) 
VALUES
(1, 1, 1),
(2, 1, 3),
(3, 1, 6),
(4, 2, 2),
(5, 2, 7),
(6, 3, 4),
(7, 3, 5),
(8, 4, 2),
(9, 4, 4),
(10, 5, 1),
(11, 5, 6),
(12, 6, 2),
(13, 7, 2),
(14, 7, 6),
(15, 8, 1),
(16, 8, 6);


SELECT * FROM CHEFS;


SELECT nombre, tipo_comida, tiempo_preparacion 
FROM RECETAS 
WHERE estado = 'Publicada';


SELECT r.nombre, i.nombre as ingrediente, ri.cantidad, i.unidad_medida
FROM RECETAS r
JOIN RECETA_INGREDIENTES ri ON r.id_receta = ri.id_receta
JOIN INGREDIENTES i ON ri.id_ingrediente = i.id_ingrediente;


SELECT nombre, apellido, especialidad, experiencia 
FROM CHEFS 
ORDER BY especialidad, experiencia DESC;


SELECT r.nombre, SUM(i.precio_por_unidad * ri.cantidad) as costo_aproximado
FROM RECETAS r
JOIN RECETA_INGREDIENTES ri ON r.id_receta = ri.id_receta
JOIN INGREDIENTES i ON ri.id_ingrediente = i.id_ingrediente
GROUP BY r.nombre;

-- LOS  DELETES 

DELETE FROM CHEFS WHERE id_chef = 5;


DELETE FROM RECETAS WHERE estado != 'Publicada';


DELETE FROM INGREDIENTES 
WHERE id_ingrediente NOT IN (SELECT DISTINCT id_ingrediente FROM RECETA_INGREDIENTES);


INSERT INTO CHEFS (id_chef, nombre, apellido, especialidad, experiencia, fecha_ingreso)
VALUES (6, 'Sofía', 'Hernández', 'Repostería sin gluten', 4, '2023-01-10');


INSERT INTO RECETAS (id_receta, nombre, tipo_comida, tiempo_preparacion, dificultad, estado)
VALUES (9, 'Pan de banana', 'Postre', 70, 'Baja', 'Publicada');

INSERT INTO INGREDIENTES (id_ingrediente, nombre, tipo, unidad_medida, precio_por_unidad)
VALUES (13, 'Banana', 'Fruta', 'kg', 2.80);


UPDATE RECETAS SET dificultad = 'Media' WHERE id_receta = 5;
UPDATE INGREDIENTES SET precio_por_unidad = 2.00 WHERE id_ingrediente = 2;
UPDATE CHEFS SET experiencia = experiencia + 1 WHERE id_chef = 3;


SELECT 
    i.nombre AS ingrediente,
    COUNT(*) AS veces_utilizado,
    SUM(ri.cantidad) AS cantidad_total,
    ROUND(AVG(ri.cantidad), 2) AS promedio_por_receta
FROM 
    RECETA_INGREDIENTES ri
JOIN 
    INGREDIENTES i ON ri.id_ingrediente = i.id_ingrediente
GROUP BY 
    i.nombre
ORDER BY 
    veces_utilizado DESC;


SELECT 
    r.tipo_comida,
    COUNT(p.id_preparacion) AS total_preparaciones,
    ROUND(AVG(p.calificacion), 2) AS promedio_calificacion,
    ROUND(AVG(r.tiempo_preparacion), 0) AS tiempo_promedio
FROM 
    RECETAS r
LEFT JOIN 
    PREPARACIONES p ON r.id_receta = p.id_receta
GROUP BY 
    r.tipo_comida
ORDER BY 
    promedio_calificacion DESC;

-- 3. Desempeño de chefs
SELECT 
    c.id_chef,
    CONCAT(c.nombre, ' ', c.apellido) AS chef,
    COUNT(p.id_preparacion) AS recetas_preparadas,
    ROUND(AVG(p.calificacion), 2) AS calificacion_promedio,
    DATEDIFF(DAY, MIN(p.fecha_preparacion), MAX(p.fecha_preparacion)) AS dias_activo
FROM 
    CHEFS c
JOIN 
    PREPARACIONES p ON c.id_chef = p.id_chef
GROUP BY 
    c.id_chef, c.nombre, c.apellido
HAVING 
    COUNT(p.id_preparacion) > 1
ORDER BY 
    calificacion_promedio DESC;
