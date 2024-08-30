USE Reserva_hotel

--  indice con usuarios email y contraseña
CREATE UNIQUE INDEX idx_usuarios ON Usuarios(Email,UsuarioID, Contraseña);
-- indice con hoteles, ubicacion ,telefonos.email
CREATE UNIQUE INDEX idx_hoteles ON Hoteles(HotelID,Ubicación,Teléfono,Email);
-- indice con habitaciones
CREATE UNIQUE INDEX idx_habitaciones ON Habitaciones(HabitacionID);
-- indice conreservas y fechas
CREATE INDEX idx_reservas ON Reservas(ReservaID,FechaInicio,FechaFin);
-- indices listos

