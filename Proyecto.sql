-- la base de datos y uso de la base
CREATE DATABASE Reserva_hotel;
USE Reserva_hotel;

-- tabla Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY, -- 1NF: Asegura que cada registro sea único.
    Nombre VARCHAR(100) NOT NULL,             -- 1NF: Cada campo contiene un solo valor atómico.
    Email VARCHAR(100) NOT NULL UNIQUE,       -- 1NF: Valores únicos; 2NF: No hay dependencias parciales.
    Contraseña VARCHAR(255) NOT NULL,         -- 1NF: Cada campo tiene un valor atómico.
    Teléfono VARCHAR(20),                     -- 1NF: Cada campo contiene solo un valor.
    Dirección VARCHAR(255)                    -- 1NF: Un solo valor por campo; 2NF: No depende de una parte de la clave primaria.
);

--  tabla Hoteles
CREATE TABLE Hoteles (
    HotelID INT AUTO_INCREMENT PRIMARY KEY,   -- 1NF: Un identificador único por cada hotel.
    Nombre VARCHAR(100) NOT NULL,             -- 1NF: Campo atómico, solo un nombre por hotel.
    Ubicación VARCHAR(255) NOT NULL,          -- 1NF: Campo atómico; 2NF: Ubicación depende completamente de HotelID.
    Teléfono VARCHAR(20),                     -- 1NF: Un solo número de teléfono por hotel.
    Email VARCHAR(100) UNIQUE                 -- 1NF: Un solo valor de email por registro; 2NF: No hay dependencias parciales.
);

--  tabla Habitaciones
CREATE TABLE Habitaciones (
    HabitacionID INT AUTO_INCREMENT PRIMARY KEY, -- 1NF: Identificador único por cada habitación.
    HotelID INT NOT NULL,                        -- 2NF: HotelID depende completamente de HabitacionID.
    Número VARCHAR(10) NOT NULL,                 -- 1NF: Un solo número por habitación.
    Tipo VARCHAR(50) NOT NULL,                   -- 1NF: Un solo tipo por habitación.
    PrecioPorNoche DECIMAL(10, 2) NOT NULL,      -- 1NF: Un solo precio por noche.
    Disponible BOOLEAN DEFAULT TRUE,             -- 1NF: Un solo valor de disponibilidad por habitación.
    FOREIGN KEY (HotelID) REFERENCES Hoteles (HotelID) -- 3NF: Las dependencias se manejan correctamente a través de claves foráneas.
);

-- tabla Reservas
CREATE TABLE Reservas (
    ReservaID INT AUTO_INCREMENT PRIMARY KEY,    -- 1NF: Clave primaria única para cada reserva.
    UsuarioID INT NOT NULL,                      -- 2NF: UsuarioID depende de ReservaID.
    HabitacionID INT NOT NULL,                   -- 2NF: HabitacionID depende completamente de ReservaID.
    FechaInicio DATE NOT NULL,                   -- 1NF: Fechas atómicas.
    FechaFin DATE NOT NULL,                      -- 1NF: Fechas atómicas; 3NF: No hay dependencias transitivas.
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios (UsuarioID), -- 3NF: Dependencias manejadas con claves foráneas.
    FOREIGN KEY (HabitacionID) REFERENCES Habitaciones (HabitacionID) -- 3NF: Dependencias correctamente relacionadas.
);

--  tabla Usuarios
INSERT INTO Usuarios (Nombre, Email, Contraseña, Teléfono, Dirección)
VALUES 
    ('Juan Pérez', 'carlos.perez@gmail.com', 'password123', '64506677', 'Puntarenas,Barranca'),
    ('Maria García', 'mari.garcia@gmail.com', 'pass456', '61437743', 'Puntarenas,Fraycaciano'),
    ('Frander', 'Frander@gmail.com', '12334', '3232332', 'Puntarenas,Fraycaciano'),
    ('Luis Ramírez', 'luis.ramirez@gmail.com', 'securepass789', '61234567', 'San José, Escazú'),
    ('Ana López', 'ana.lopez@gmail.com', 'mypassword101', '62223344', 'Alajuela, San Carlos'),
    ('Carlos Herrera', 'juan.herrera@gmail.com', 'pass789', '63334455', 'Heredia, Belén'),
    ('Sofia Mendez', 'sofia.mendez@gmail.com', 'password321', '64445566', 'Cartago, Paraíso');

--tabla Hoteles
INSERT INTO Hoteles (Nombre, Ubicación, Teléfono, Email)
VALUES 
    ('Hotel RIU', 'Guanacaste', '506 26812350', 'reserva@hotelRIU.com'),
    ('Hotel Las Brisas', 'Puntarenas', '2661 4040', 'reserva@hotelBrisas.com'),
    ('Hotel Mari', 'Puntarenas', '26618075', 'reservas@hotelMari.com'),
    ('Hotel La Paz', 'San José', '2222 3333', 'contacto@hotellapaz.com'),
    ('Hotel El Paraíso', 'Cartago', '2555 6666', 'info@hoteleparaiso.com'),
    ('Hotel Vista Hermosa', 'Guanacaste', '2678 1234', 'reservas@vistahermosa.com'),
    ('Hotel Monteverde', 'Puntarenas', '2645 9876', 'booking@monteverdehotel.com');

-- tabla Habitaciones
INSERT INTO Habitaciones (HotelID, Número, Tipo, PrecioPorNoche, Disponible)
VALUES
    -- Datos del Hotel RIU
    (1, '101', 'Doble', 80.00, TRUE),
    (1, '102', 'Sencilla', 50.00, TRUE),
    (1, '103', 'Suite', 120.00, TRUE),
    (1, '104', 'Doble', 85.00, TRUE),
    (1, '105', 'Sencilla', 55.00, TRUE),
    (1, '106', 'Suite', 125.00, TRUE),
    -- Datos del Hotel Las Brisas
    (2, '201', 'Doble', 70.00, TRUE),
    (2, '202', 'Sencilla', 40.00, TRUE),
    (2, '203', 'Suite', 110.00, TRUE),
    (2, '204', 'Doble', 75.00, TRUE),
    (2, '205', 'Sencilla', 45.00, TRUE),
    (2, '206', 'Suite', 115.00, TRUE),
    -- Datos del Hotel Mari
    (3, '301', 'Sencilla', 70.00, TRUE),
    (3, '302', 'Suite', 180.00, TRUE),
    (3, '303', 'Doble', 90.00, TRUE),
    (3, '304', 'Sencilla', 75.00, TRUE),
    (3, '305', 'Suite', 185.00, TRUE),
    (3, '306', 'Doble', 95.00, TRUE),
    -- Datos del Hotel La Paz
    (4, '401', 'Doble', 80.00, TRUE),
    (4, '402', 'Sencilla', 50.00, TRUE),
    (4, '403', 'Suite', 120.00, TRUE),
    (4, '404', 'Doble', 85.00, TRUE),
    (4, '405', 'Sencilla', 55.00, TRUE),
    (4, '406', 'Suite', 125.00, TRUE),
    -- Datos del Hotel El Paraíso
    (5, '501', 'Doble', 70.00, TRUE),
    (5, '502', 'Sencilla', 40.00, TRUE),
    (5, '503', 'Suite', 110.00, TRUE),
    (5, '504', 'Doble', 75.00, TRUE),
    (5, '505', 'Sencilla', 45.00, TRUE),
    (5, '506', 'Suite', 115.00, TRUE),
    -- Datos del Hotel Vista Hermosa
    (6, '601', 'Doble', 90.00, TRUE),
    (6, '602', 'Sencilla', 60.00, TRUE),
    (6, '603', 'Suite', 140.00, TRUE),
    (6, '604', 'Doble', 95.00, TRUE),
    (6, '605', 'Sencilla', 65.00, TRUE),
    (6, '606', 'Suite', 145.00, TRUE),
    -- Datos del Hotel Monteverde
    (7, '701', 'Doble', 85.00, TRUE),
    (7, '702', 'Sencilla', 55.00, TRUE),
    (7, '703', 'Suite', 130.00, TRUE),
    (7, '704', 'Doble', 90.00, TRUE),
    (7, '705', 'Sencilla', 60.00, TRUE),
    (7, '706', 'Suite', 135.00, TRUE);

-- Crear procedimientos almacenados

DELIMITER / /

-- agregar una nueva reserva
CREATE PROCEDURE AgregarNuevaReserva(
    IN p_UsuarioID INT,
    IN p_HabitacionID INT,
    IN p_FechaInicio DATE,
    IN p_FechaFin DATE
)
BEGIN
    -- Validación de datos: Verifica si la habitación está disponible para las fechas seleccionadas
    IF NOT EXISTS (
        SELECT 1
        FROM Reservas
        WHERE HabitacionID = p_HabitacionID
          AND (p_FechaInicio <= FechaFin AND p_FechaFin >= FechaInicio)
    ) THEN
        -- Inserta la nueva reserva si no hay conflictos de fechas
        INSERT INTO Reservas (UsuarioID, HabitacionID, FechaInicio, FechaFin)
        VALUES (p_UsuarioID, p_HabitacionID, p_FechaInicio, p_FechaFin);
    ELSE
        -- Manejo de errores: Genera un error personalizado si la habitación no está disponible
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La habitación no está disponible para las fechas seleccionadas.';
    END IF;
END

DELIMITER;
CALL AgregarNuevaReserva ( 6, 1, '2024-7-30', '2024-7-30' );
DELIMITER / /

-- Procedimiento para eliminar una reserva
CREATE PROCEDURE eliminacion_de_reserva(
    IN p_ReservaID INT
)
BEGIN
    -- Atomicidad de transacciones: La eliminación es una operación atómica
    DELETE FROM Reservas WHERE ReservaID = p_ReservaID;
END

DELIMITER;

CALL eliminacion_de_reserva (13);


DROP DATABASE reserva_hoteles