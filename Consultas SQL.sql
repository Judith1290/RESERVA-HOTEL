-- Selecciona la base de datos a utilizar
USE Reserva_hotel;

-- 1. Consulta para obtener los hoteles con mayor número de reservas
-- Esta consulta muestra los hoteles ordenados por la cantidad total de reservas, de mayor a menor.
SELECT
    h.HotelID,
    h.Nombre AS HotelNombre,
    COUNT(r.ReservaID) AS TotalReservas
FROM
    Hoteles h
    INNER JOIN Reservas r ON h.HotelID = HabitacionID
GROUP BY
    h.HotelID,
    h.Nombre
ORDER BY TotalReservas DESC;

-- 2. Consulta para buscar hoteles por nombre
-- Esta consulta busca hoteles cuyo nombre contiene el texto "RIU".
SELECT HotelID, Nombre FROM Hoteles WHERE Nombre LIKE '%RIU%';

-- 3. Consulta para buscar hoteles cuya ubicación termina con un texto específico
-- Esta consulta busca hoteles cuya ubicación termina con "as".
SELECT HotelID, Ubicación FROM Hoteles WHERE Ubicación LIKE '%as';

-- 4. Consulta para calcular el promedio de días de reservas en un hotel
-- Esta consulta calcula el promedio de días reservados para el hotel con HotelID = 3.

SELECT AVG(
        DATEDIFF(r.FechaFin, r.FechaInicio) + 1
    ) AS PromedioDiasReservados
FROM Reservas r
    INNER JOIN Habitaciones ha ON r.HabitacionID = ha.HabitacionID
WHERE
    ha.HotelID = 1;

-- 5. Consulta para listar los hoteles que tienen habitaciones disponibles pero no han sido
-- reservadas en el último mes
-- Esta consulta obtiene los hoteles con habitaciones disponibles y que no han sido reservadas en el último mes.

SELECT
    ha.HabitacionID,
    ha.Número,
    ha.Tipo,
    ha.PrecioPorNoche,
    (
        SELECT h.Nombre
        FROM Hoteles h
        WHERE
            h.HotelID = ha.HotelID
    ) AS HotelNombre,
    (
        SELECT h.Ubicación
        FROM Hoteles h
        WHERE
            h.HotelID = ha.HotelID
    ) AS Ubicación
FROM Habitaciones ha
WHERE
    ha.Disponible = TRUE
    AND NOT EXISTS (
        SELECT 1
        FROM Reservas r
        WHERE
            r.HabitacionID = ha.HabitacionID
            AND r.FechaInicio BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
    );