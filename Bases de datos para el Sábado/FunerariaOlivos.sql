
CREATE DATABASE FunerariaOlivos;


USE FunerariaOlivos;


CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cargo VARCHAR(30) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    estado VARCHAR(10) DEFAULT 'Activo' CHECK (estado IN ('Activo', 'Inactivo')),
    correo VARCHAR(100),
    fecha_creacion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    fecha_registro DATE DEFAULT GETDATE()
);

CREATE TABLE ServiciosFunerarios (
    id_servicio INT PRIMARY KEY,
    tipo_servicio VARCHAR(50) NOT NULL,
    descripcion VARCHAR(500),
    fecha_servicio DATETIME NOT NULL,
    id_cliente INT NOT NULL,
    nivel_urgencia VARCHAR(20) CHECK (nivel_urgencia IN ('Bajo', 'Medio', 'Alto')),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Contratos (
    id_contrato INT PRIMARY KEY,
    codigo_contrato VARCHAR(20) UNIQUE NOT NULL,
    descripcion VARCHAR(500),
    estado_contrato VARCHAR(15) DEFAULT 'Vigente' CHECK (estado_contrato IN ('Vigente', 'Finalizado')),
    fecha_inicio DATE NOT NULL,
    id_servicio INT NOT NULL,
    prioridad INT DEFAULT 1,
    FOREIGN KEY (id_servicio) REFERENCES ServiciosFunerarios(id_servicio)
);

CREATE TABLE VehiculosFuneraria (
    id_vehiculo INT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    id_cliente INT,
    estado VARCHAR(15) DEFAULT 'Disponible',
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE AsignacionesEmpleados (
    id_asignacion INT PRIMARY KEY,
    id_empleado INT NOT NULL,
    id_contrato INT NOT NULL,
    fecha_asignacion DATE NOT NULL,
    observaciones VARCHAR(200),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
    FOREIGN KEY (id_contrato) REFERENCES Contratos(id_contrato)
);

CREATE TABLE DocumentosContratos (
    id_documento INT PRIMARY KEY,
    id_contrato INT NOT NULL,
    descripcion_documento VARCHAR(500) NOT NULL,
    tipo_documento VARCHAR(50) NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT GETDATE(),
    ruta_archivo VARCHAR(255),
    FOREIGN KEY (id_contrato) REFERENCES Contratos(id_contrato)
);

GO

INSERT INTO Clientes (id_cliente, cedula, nombre, apellido, direccion, telefono) VALUES
(1, '123456789', 'Lucía', 'Tovar', 'Calle 12 #34-56', '3001112233'),
(2, '234567890', 'Carlos', 'Avella', 'Av. Las Palmas 123', '3002223344'),
(3, '345678901', 'Ana', 'Ríos', 'Carrera 45 #67-89', '3003334455'),
(4, '456789012', 'Juan', 'Olaya', 'Calle 90 #12-34', '3004445566'),
(5, '567890123', 'Marta', 'González', 'Av. del Sol 89', '3005556677');
GO

INSERT INTO Empleados (id_empleado, nombre, apellido, cargo, fecha_ingreso, estado, correo) VALUES
(1, 'Luis', 'Martínez', 'Asesor', '2020-02-01', 'Activo', 'lmartinez@funeraria.com'),
(2, 'Sofía', 'Avella', 'Conductor', '2019-05-20', 'Activo', 'slopez@funeraria.com'),
(3, 'Jorge', 'Gaitán', 'Coordinador', '2021-03-15', 'Activo', 'jdiaz@funeraria.com'),
(4, 'Camila', 'Trello', 'Tanatólogo', '2018-07-10', 'Activo', 'ctorres@funeraria.com'),
(5, 'Andrés', 'Messi', 'Asesor', '2022-01-05', 'Activo', 'asuarez@funeraria.com');
GO

INSERT INTO ServiciosFunerarios (id_servicio, tipo_servicio, descripcion, fecha_servicio, id_cliente, nivel_urgencia) VALUES
(1, 'Velación', 'Servicio completo de velación', '2025-05-10 10:00:00', 1, 'Medio'),
(2, 'Cremación', 'Cremación con ceremonia básica', '2025-06-01 09:30:00', 2, 'Bajo'),
(3, 'Inhumación', 'Entierro tradicional', '2025-04-20 15:00:00', 3, 'Alto'),
(4, 'Exhumación', 'Exhumación con trámites legales', '2025-03-15 08:00:00', 4, 'Medio'),
(5, 'Traslado', 'Traslado nacional del cuerpo', '2025-02-28 11:30:00', 5, 'Bajo');
GO

INSERT INTO Contratos (id_contrato, codigo_contrato, descripcion, estado_contrato, fecha_inicio, id_servicio, prioridad) VALUES
(1, 'CONT-001', 'Contrato para servicio de velación', 'Vigente', '2025-05-09', 1, 2),
(2, 'CONT-002', 'Contrato para cremación', 'Vigente', '2025-06-01', 2, 1),
(3, 'CONT-003', 'Contrato para inhumación', 'Finalizado', '2025-04-19', 3, 3),
(4, 'CONT-004', 'Contrato para exhumación', 'Finalizado', '2025-03-14', 4, 2),
(5, 'CONT-005', 'Contrato para traslado', 'Vigente', '2025-02-27', 5, 1);
GO

INSERT INTO AsignacionesEmpleados (id_asignacion, id_empleado, id_contrato, fecha_asignacion, observaciones) VALUES
(1, 1, 1, '2025-05-09', 'Asignación inicial'),
(2, 2, 2, '2025-06-01', 'Requiere vehículo especial'),
(3, 3, 3, '2025-04-19', 'Coordinación con cementerio'),
(4, 4, 4, '2025-03-14', 'Proceso legal complejo'),
(5, 5, 5, '2025-02-27', 'Traslado interurbano');
GO

INSERT INTO VehiculosFuneraria (id_vehiculo, placa, marca, modelo, id_cliente, estado) VALUES
(1, 'AAA123', 'Ford', 'Transit', 1, 'Disponible'),
(2, 'BBB234', 'Chevrolet', 'N300', 2, 'En mantenimiento'),
(3, 'CCC345', 'Hyundai', 'H1', 3, 'Disponible'),
(4, 'DDD456', 'Kia', 'Pregio', 4, 'En servicio'),
(5, 'EEE567', 'Renault', 'Master', 5, 'Disponible');
GO

INSERT INTO DocumentosContratos (id_documento, id_contrato, descripcion_documento, tipo_documento, fecha_registro, ruta_archivo) VALUES
(1, 1, 'Copia de cédula', 'Identificación', '2025-05-09 09:00:00', '/documentos/cont001/cedula.pdf'),
(2, 2, 'Registro civil de defunción', 'Legal', '2025-06-01 08:30:00', '/documentos/cont002/defuncion.pdf'),
(3, 3, 'Certificado médico de defunción', 'Médico', '2025-04-19 14:00:00', '/documentos/cont003/certificado.pdf'),
(4, 4, 'Autorización judicial de exhumación', 'Judicial', '2025-03-14 07:30:00', '/documentos/cont004/autorizacion.pdf'),
(5, 5, 'Permiso de traslado', 'Logística', '2025-02-27 10:15:00', '/documentos/cont005/permiso.pdf');

GO

--  Aquí van los Procedimientos para el  almacenado para actualizar los contratos osea los estados
CREATE OR ALTER PROCEDURE sp_ActualizarEstadoContrato
    @id_contrato INT,
    @nuevo_estado VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @nuevo_estado NOT IN ('Activo', 'Finalizado')
        BEGIN
            RAISERROR('Estado no válido. Solo se permiten: Activo, Finalizado', 16, 1);
            RETURN;
        END;

        IF NOT EXISTS (SELECT 1 FROM Contratos WHERE id_contrato = @id_contrato)
        BEGIN
            RAISERROR('El contrato especificado no existe', 16, 1);
            RETURN;
        END;

        UPDATE Contratos
        SET estado_contrato = @nuevo_estado
        WHERE id_contrato = @id_contrato;
        
        -- Registrar el cambio en un log (tabla hipotética)
        -- INSERT INTO LogCambiosContratos (id_contrato, estado_anterior, estado_nuevo, fecha_cambio)
        -- SELECT @id_contrato, estado_contrato, @nuevo_estado, GETDATE()
        -- FROM Contratos WHERE id_contrato = @id_contrato;
        
        COMMIT TRANSACTION;
        
        PRINT 'Estado del contrato actualizado correctamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- Aquí van los reportes de servicios activos
CREATE VIEW vw_ServiciosActivos AS
SELECT 
    c.id_cliente,
    c.nombre + ' ' + c.apellido AS cliente,
    s.tipo_servicio,
    s.fecha_servicio,
    con.codigo_contrato,
    con.estado_contrato,
    e.nombre + ' ' + e.apellido AS empleado_asignado
FROM 
    Clientes c
    INNER JOIN ServiciosFunerarios s ON c.id_cliente = s.id_cliente
    INNER JOIN Contratos con ON s.id_servicio = con.id_servicio
    LEFT JOIN AsignacionesEmpleados ae ON con.id_contrato = ae.id_contrato
    LEFT JOIN Empleados e ON ae.id_empleado = e.id_empleado
WHERE 
    con.estado_contrato = 'Activo';
GO

-- Función para calcular días hasta el servicio
CREATE FUNCTION fn_DiasHastaServicio(@id_servicio INT)
RETURNS INT
AS
BEGIN
    DECLARE @dias INT;
    
    SELECT @dias = DATEDIFF(DAY, GETDATE(), fecha_servicio)
    FROM ServiciosFunerarios
    WHERE id_servicio = @id_servicio;
    
    RETURN @dias;
END;
GO

-- Consultas de ejemplo
-- 1. Clientes con servicios pendientes
SELECT 
    c.nombre + ' ' + c.apellido AS cliente,
    s.tipo_servicio,
    s.fecha_servicio,
    dbo.fn_DiasHastaServicio(s.id_servicio) AS dias_restantes
FROM 
    Clientes c
    JOIN ServiciosFunerarios s ON c.id_cliente = s.id_cliente
    JOIN Contratos con ON s.id_servicio = con.id_servicio
WHERE 
    con.estado_contrato = 'Vigente'
ORDER BY 
    s.fecha_servicio;
GO

-- 2. Empleados y sus asignaciones
SELECT 
    e.nombre + ' ' + e.apellido AS empleado,
    e.cargo,
    COUNT(ae.id_asignacion) AS asignaciones_activas
FROM 
    Empleados e
    LEFT JOIN AsignacionesEmpleados ae ON e.id_empleado = ae.id_empleado
    LEFT JOIN Contratos c ON ae.id_contrato = c.id_contrato AND c.estado_contrato = 'Vigente'
GROUP BY 
    e.nombre, e.apellido, e.cargo
ORDER BY 
    asignaciones_activas DESC;
GO

-- 3. Vehículos y su disponibilidad
SELECT 
    marca + ' ' + modelo AS vehiculo,
    placa,
    estado,
    CASE 
        WHEN v. id_cliente IS NULL THEN 'Disponible'
        ELSE c.nombre + ' ' + c.apellido
    END AS asignado_a
FROM 
    VehiculosFuneraria v
    LEFT JOIN Clientes c ON v.id_cliente = c.id_cliente
ORDER BY 
    estado, marca;
GO

-- 4. Documentos próximos a vencer (ejemplo hipotético)
SELECT 
    c.codigo_contrato,
    dc.tipo_documento,
    dc.descripcion_documento,
    dc.fecha_registro,
    DATEDIFF(DAY, dc.fecha_registro, GETDATE()) AS dias_desde_registro
FROM 
    DocumentosContratos dc
    JOIN Contratos c ON dc.id_contrato = c.id_contrato
WHERE 
    c.estado_contrato = 'Activo'
    AND DATEDIFF(DAY, dc.fecha_registro, GETDATE()) > 30
ORDER BY 
    dias_desde_registro DESC;
GO

-- 5. Resumen de servicios por tipo
SELECT 
    tipo_servicio,
    COUNT(*) AS total_servicios,
    SUM(CASE WHEN nivel_urgencia = 'Alto' THEN 1 ELSE 0 END) AS alta_urgencia,
    SUM(CASE WHEN nivel_urgencia = 'Medio' THEN 1 ELSE 0 END) AS media_urgencia,
    SUM(CASE WHEN nivel_urgencia = 'Bajo' THEN 1 ELSE 0 END) AS baja_urgencia
FROM 
    ServiciosFunerarios
GROUP BY 
    tipo_servicio
ORDER BY 
    total_servicios DESC;
GO