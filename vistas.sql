USE reserva_hotel;

CREATE VIEW VistaReservas AS
SELECT
    r.ReservaID,
    u.Nombre AS UsuarioNombre,
    h.Nombre AS HotelNombre,
    ha.Número AS HabitacionNumero,
    ha.Tipo AS HabitacionTipo,
    r.FechaInicio,
    r.FechaFin
FROM
    Reservas r
    JOIN Usuarios u ON r.UsuarioID = u.UsuarioID
    JOIN Habitaciones ha ON r.HabitacionID = ha.HabitacionID
    JOIN Hoteles h ON ha.HotelID = h.HotelID;
