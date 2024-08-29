-- Selecciona la base de datos a utilizar
USE Reserva_hotel;

-- 1. Consulta para obtener los hoteles con mayor número de reservas
-- Esta consulta muestra los hoteles ordenados por la cantidad total de reservas, de mayor a menor.
SELECT
    h.HotelID,
    h.Nombre AS HotelNombre,
    COUNT(r.ReservaID) AS TotalReservas
FROM Hoteles h
INNER JOIN Reservas r ON h.HotelID = r.HotelID
GROUP BY
    h.HotelID,
    h.Nombre
ORDER BY
    TotalReservas DESC;

-- 2. Consulta para buscar hoteles por nombre
-- Esta consulta busca hoteles cuyo nombre contiene el texto "RIU".
SELECT HotelID, Nombre
FROM Hoteles
WHERE Nombre LIKE '%RIU%';

-- 3. Consulta para buscar hoteles cuya ubicación termina con un texto específico
-- Esta consulta busca hoteles cuya ubicación termina con "as".
SELECT HotelID, Ubicación
FROM Hoteles
WHERE Ubicación LIKE '%as';

-- 4. Consulta para calcular el promedio de días de reservas en un hotel
-- Esta consulta calcula el promedio de días reservados para el hotel con HotelID = 3.
SELECT AVG(
        DATEDIFF(FechaFin, FechaInicio) + 1
    ) AS PromedioDiasReservados
FROM Reservas
WHERE
    HotelID = 3;

-- 5. Consulta para listar los hoteles que tienen habitaciones disponibles pero no han sido
-- reservadas en el último mes
-- Esta consulta obtiene los hoteles con habitaciones disponibles y que no han sido reservadas en el último mes.
SELECT h.Nombre, h.Ubicación
FROM Hoteles h
WHERE
    h.HotelID NOT IN (
        SELECT r.HotelID
        FROM Reservas r
        WHERE
            r.FechaInicio >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    )
    AND h.HotelID IN (
        SELECT ha.HotelID
        FROM Habitaciones ha
        WHERE
            ha.Disponible = TRUE
    );
