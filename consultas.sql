USE reserva_hotel
-- habitaciones disponibles
SELECT COUNT(*) AS HabitacionesDisponibles
FROM Habitaciones
WHERE HotelID = 1 AND Disponible = TRUE;

