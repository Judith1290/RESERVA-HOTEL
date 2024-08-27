CREATE DATABASE Reserva_hotel

USE Reserva_hotel

-- holaa
-- Crear tablas
CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Contraseña VARCHAR(255) NOT NULL,
    Teléfono VARCHAR(20),
    Dirección VARCHAR(255)
);
CREATE TABLE Hoteles (
    HotelID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Ubicación VARCHAR(255) NOT NULL,
    Teléfono VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);
CREATE TABLE Habitaciones (
    HabitacionID INT AUTO_INCREMENT PRIMARY KEY,
    HotelID INT NOT NULL,
    Número VARCHAR(10) NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    PrecioPorNoche DECIMAL(10, 2) NOT NULL,
    Disponible BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (HotelID) REFERENCES Hoteles(HotelID)
);
CREATE TABLE Reservas (
    ReservaID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT NOT NULL,
    HabitacionID INT NOT NULL,
    HotelID INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (HabitacionID) REFERENCES Habitaciones(HabitacionID),
    FOREIGN KEY (HotelID) REFERENCES Hoteles(HotelID)
);
-- Insertar datos en las tablas
INSERT INTO Usuarios (Nombre, Email, Contraseña, Teléfono, Dirección)
VALUES
    ('Juan Pérez', 'carlos.perez@gmail.com', 'password123', '64506677', 'Puntarenas,Barranca'),
    ('Maria García', 'mari.garcia@gmail.com', 'pass456', '61437743', 'Puntarenas,Fraycaciano'),
    ('Frander', 'Frander@gmail.com', '12334', '3232332', 'Puntarenas,Fraycaciano');
INSERT INTO Hoteles (Nombre, Ubicación, Teléfono, Email)
VALUES
    ('Hotel RIU', 'GuanacasteA', '506 26812350', 'reserva@hotelRIU.com'),
    ('Hotel Las Brisas', 'Puntarenas', '2661 4040', 'reserva@hotelBrisas.com'),
    ('Hotel Mari', 'Puntarenas', '26618075', 'reservas@hotelMari.com');
INSERT INTO Habitaciones (HotelID, Número, Tipo, PrecioPorNoche, Disponible)
VALUES
    (1, '101', 'Doble', 80.00, TRUE),
    (1, '102', 'Sencilla', 50.00, TRUE),
    (1, '103', 'Suite', 120.00, TRUE),
    (2, '201', 'Doble', 70.00, TRUE),
    (2, '202', 'Sencilla', 40.00, TRUE),
    (2, '203', 'Suite', 110.00, TRUE),
    (3, '301', 'Sencilla', 70.00, TRUE),
    (3, '302', 'Suite', 180.00, TRUE);
-- Crear procedimientos almacenados
DELIMITER //
CREATE PROCEDURE AgregarNuevaReserva(
    IN p_UsuarioID INT,
    IN p_HotelID INT,
    IN p_HabitacionID INT,
    IN p_FechaInicio DATE,
    IN p_FechaFin DATE
)
BEGIN
    -- Verificar si la habitación pertenece al hotel especificado
    IF NOT EXISTS (
        SELECT 1
        FROM Habitaciones
        WHERE HabitacionID = p_HabitacionID
          AND HotelID = p_HotelID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La habitación no pertenece al hotel especificado.';
    ELSE
        -- Verificar si la habitación está disponible para las fechas especificadas
        IF NOT EXISTS (
            SELECT 1
            FROM Reservas
            WHERE HabitacionID = p_HabitacionID
              AND (p_FechaInicio <= FechaFin AND p_FechaFin >= FechaInicio)
        ) THEN
            -- Insertar la nueva reserva si no hay conflictos
            INSERT INTO Reservas (UsuarioID, HabitacionID, HotelID, FechaInicio, FechaFin)
            VALUES (p_UsuarioID, p_HabitacionID, p_HotelID, p_FechaInicio, p_FechaFin);
        ELSE
            -- Genera un error personalizado
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La habitación no está disponible para las fechas seleccionadas.';
        END IF;
    END IF;
END//
DELIMITER ;
-- Llamada al procedimiento para agregar una nueva reserva
CALL AgregarNuevaReserva(2, 1, 2, '2024-10-03', '2024-10-04');
DELIMITER //
CREATE PROCEDURE eliminacion_de_reserva(
    IN p_ReservaID INT
)
BEGIN
    -- Eliminar la reserva
    DELETE FROM Reservas
    WHERE ReservaID = p_ReservaID;
END//
DELIMITER ;
-- Llamada al procedimiento para eliminar una reserva
CALL eliminacion_de_reserva(3);
-- Consultas para verificar los datos

SELECT * FROM Reservas WHERE FechaInicio = CURDATE();
SELECT * FROM Reservas;
SELECT CURDATE();


