-- Selecciona la base de datos a utilizar
USE reserva_hotel;


-- consulta cuenta el número de habitaciones disponibles en el hotel especifico con la fecha especifica
SELECT COUNT(*) AS HabitacionesDisponibles
FROM Habitaciones ha
WHERE ha.HotelID = 1
AND ha.Disponible = TRUE
AND ha.HabitacionID NOT IN (
    SELECT r.HabitacionID
    FROM Reservas r
    WHERE r.FechaInicio <= '2024-08-15' AND r.FechaFin >= '2024-08-15'
);

-- buscae hotelespor ubiciacion
SELECT *
FROM Hoteles
WHERE Ubicación LIKE 'Punt%';



-- buscar reseerva del ultimo mes de usuario por correo
SELECT *
FROM Reservas
WHERE UsuarioID = (
    SELECT UsuarioID
    FROM Usuarios
    WHERE Email = 'mari.garcia@gmail.com'
)
AND FechaInicio BETWEEN DATE_SUB(LAST_DAY(CURDATE()) + INTERVAL 1 DAY - INTERVAL 1 MONTH, INTERVAL 1 MONTH)
AND LAST_DAY(CURDATE()) - INTERVAL 1 MONTH;


-- h
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
    r.FechaInicio <= LAST_DAY(CURDATE() - INTERVAL 1 MONTH)
    AND r.FechaFin >= DATE_SUB(CURDATE() - INTERVAL 1 MONTH, INTERVAL 1 DAY)
GROUP BY
    ho.HotelID
ORDER BY
    Cantidad_reserva DESC
LIMIT 1;
