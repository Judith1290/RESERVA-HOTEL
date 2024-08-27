USE Reserva_hotel


CREATE UNIQUE INDEX idx_usuarios ON Usuarios(Email,UsuarioID, Contraseña);

CREATE UNIQUE INDEX idx_hoteles ON Hoteles(HotelID,Ubicación,Teléfono,Email);

CREATE UNIQUE INDEX idx_habitaciones ON Habitaciones(HabitacionID);

CREATE INDEX idx_reservas ON Reservas(ReservaID,FechaInicio,FechaFin);

