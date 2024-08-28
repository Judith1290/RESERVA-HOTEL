USE Reserva_hotel;

# como realizar una Consulta para obtener los hoteles con mayor número de reservas USE Reserva_hotel;
SELECT
    h.HotelID,
    h.Nombre AS HotelNombre,
    COUNT(r.ReservaID) AS TotalReservas
FROM Hoteles h
    INNER JOIN Reservas r ON h.HotelID = r.HotelID
GROUP BY
    h.HotelID,
    h.Nombre;

-- COMO REALIZAR Consulta para buscar hoteles por nombre.

SELECT HotelID, Nombre FROM Hoteles WHERE Nombre LIKE '%RIU%';

-- LIKE (Búsqueda por Patrón)

-- SELECT HotelID, Nombre
-- FROM Hoteles
-- WHERE Nombre = 'RIU';

-- Consulta para buscar hoteles cuya ubicación termina con un texto específico

SELECT HotelID, Ubicación FROM Hoteles WHERE Ubicación LIKE '%as';

-- Consulta para calcular el promedio de reservas diarias en un hotel

SELECT AVG(
        DATEDIFF(FechaFin, FechaInicio) + 1
    ) AS PromedioDiasReservados
FROM Reservas
WHERE
    HotelID = 3;

--  función integrada AVG(). Esta función calcula automáticamente el valor promedio de una columna.

-- Consulta para listar los hoteles que tienen habitaciones disponibles pero no han sido
-- reservadas en el último mess

SELECT h.HotelID, ho.NombreHotel, COUNT(*) AS HabitacionesDisponibles
FROM
    Habitaciones h
    INNER JOIN Hoteles ho ON h.HotelID = ho.HotelID
    LEFT JOIN Reservas r ON h.HabitacionID = r.HabitacionID
    AND r.FechaReserva > DATEADD (MONTH, -1, GETDATE ())
WHERE
    h.Disponible = 1
    AND r.ReservaID IS NULL
GROUP BY
    h.HotelID,
    ho.NombreHotel