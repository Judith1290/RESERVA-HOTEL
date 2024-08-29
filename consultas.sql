-- Selecciona la base de datos a utilizar
USE reserva_hotel;


-- Esta consulta cuenta el número de habitaciones disponibles en el hotel con HotelID = 1 para la fecha dada '2024-08-15'.
SELECT COUNT(*) AS HabitacionesDisponibles
FROM Habitaciones ha
WHERE ha.HotelID = 1
AND ha.Disponible = TRUE
AND ha.HabitacionID NOT IN (
    SELECT r.HabitacionID
    FROM Reservas r
    WHERE r.FechaInicio <= '2024-08-15' AND r.FechaFin >= '2024-08-15'
);

-- 2. Consulta para buscar hoteles por ubicación según el nombre de la ubicación
-- Esta consulta busca hoteles cuya ubicación comienza con 'Punt'.
SELECT *
FROM Hoteles
WHERE Ubicación LIKE 'Punt%';

-- 3. Consulta para obtener las reservas de un cliente (por email) realizadas en el mes anterior
-- Esta consulta obtiene todas las reservas realizadas por el usuario con el email 'mari.garcia@gmail.com' en el mes anterior.
SELECT *
FROM Reservas
WHERE UsuarioID = (
    SELECT UsuarioID
    FROM Usuarios
    WHERE Email = 'mari.garcia@gmail.com'
)
AND FechaInicio >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
AND FechaFin < CURDATE();

-- 4. Consulta para identificar el hotel con la mayor ocupación en el mes anterior
-- Esta consulta identifica el hotel con la mayor cantidad de reservas en el mes anterior.
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
