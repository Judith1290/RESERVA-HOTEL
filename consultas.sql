USE reserva_hotel

-- habitaciones disponibles
SELECT COUNT(*) AS HabitacionesDisponibles
FROM Habitaciones
WHERE HotelID = 1 AND Disponible = TRUE;

-- busqueda de hoteles por ubicacion segun el nombre de la ubicacion
SELECT * 
FROM Hoteles
WHERE Ubicación LIKE 'Punt%';
