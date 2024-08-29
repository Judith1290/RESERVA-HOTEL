USE reserva_hotel

-- habitaciones disponibles
SELECT COUNT(*) AS HabitacionesDisponibles
FROM Habitaciones
WHERE HotelID = 1 AND Disponible = TRUE;

-- busqueda de hoteles por ubicacion segun el nombre de la ubicacion
SELECT * 
FROM Hoteles
WHERE Ubicación LIKE 'Punta%';

-- Consulta para obtener las reservas de un cliente (por email) realizadas en el mes anterior.
SELECT * 
FROM reservas 
WHERE UsuarioID = (
    SELECT `UsuarioID`
    FROM Usuarios 
    WHERE Email = 'mari.garcia@gmail.com'
) 
AND FechaFin < '2024-08-18';

-- Consulta para identificar el hotel con la mayor ocupación en el mes anterior.
SELECT 
    ho.HotelID,
    COUNT(r.ReservaID) AS Cantidad_reserva
FROM 
    Reservas r
INNER JOIN 
    Habitaciones hab ON r.HabitacionID = hab.HabitacionID
INNER JOIN 
    Hoteles ho ON hab.HotelID = ho.HotelID
WHERE 
    MONTH(r.FechaFin) = MONTH(CURDATE() - INTERVAL 1 MONTH)
    AND YEAR(r.FechaFin) = YEAR(CURDATE() - INTERVAL 1 MONTH)
GROUP BY 
    ho.HotelID
ORDER BY 
    Cantidad_reserva DESC
LIMIT 1;






