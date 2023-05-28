CREATE OR REPLACE TRIGGER bill_insert_trigger
BEFORE INSERT ON billing
FOR EACH ROW
BEGIN
  :new.bill_status := 'Unpaid';
END;
/


CREATE OR REPLACE TRIGGER set_booking_status_pending
BEFORE INSERT ON booking
FOR EACH ROW
BEGIN
  :NEW.BOOKING_STATUS := 'Booked';
END;
/