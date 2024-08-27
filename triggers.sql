
USE reserva_hotel;


DELIMITER //
CREATE TRIGGER actualizar_disponibilidad_habitaciones
AFTER INSERT ON Reservas
FOR EACH ROW
BEGIN
    IF (NEW.HabitacionID IS NOT NULL) THEN
        UPDATE Habitaciones
        SET Disponible = FALSE
        WHERE HabitacionID = NEW.HabitacionID;
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER eliminar_disponibilidad_habitaciones
AFTER DELETE ON Reservas
FOR EACH ROW
BEGIN
    IF (OLD.HabitacionID IS NOT NULL) THEN
        UPDATE Habitaciones
        SET Disponible = TRUE
        WHERE HabitacionID = OLD.HabitacionID;
    END IF;
END//
DELIMITER ;



