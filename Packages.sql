    CREATE OR REPLACE PACKAGE booking_pkg AS
        PROCEDURE add_booking(
            p_customer_id IN NUMBER,
            p_car_id IN NUMBER,
            p_pickup_id IN NUMBER,
            p_drop_id IN NUMBER,
            p_booking_start_date IN DATE,
            p_booking_end_date IN DATE,
            p_insurance_code IN NUMBER,
            p_discount_code IN NUMBER
        );
        PROCEDURE cancel_booking(
            p_booking_id IN NUMBER
        );
        PROCEDURE complete_booking(
            p_booking_id IN NUMBER
        );
    END booking_pkg;
    /

    CREATE OR REPLACE PACKAGE BODY booking_pkg AS
        
        -- Procedure to add a booking
        PROCEDURE add_booking(
            p_customer_id IN NUMBER,
            p_car_id IN NUMBER,
            p_pickup_id IN NUMBER,
            p_drop_id IN NUMBER,
            p_booking_start_date IN DATE,
            p_booking_end_date IN DATE,
            p_insurance_code IN NUMBER,
            p_discount_code IN NUMBER
        )
        AS
            v_booking_id NUMBER;
            v_booking_status VARCHAR2(10) := 'Pending';
            v_pickup_city VARCHAR2(20);
            v_car_city VARCHAR2(20);
        BEGIN
            -- Check if customer_id exists in customer table
            SELECT customer_id INTO v_booking_id FROM customer WHERE customer_id = p_customer_id;
            IF v_booking_id IS NULL THEN
                RAISE_APPLICATION_ERROR(-20001, 'Customer does not exist');
            END IF;
            
            -- Check if car is available in current location
            SELECT car_availabilty INTO v_booking_status FROM cars WHERE car_id = p_car_id;
            IF v_booking_status <> 'Available' THEN
                RAISE_APPLICATION_ERROR(-20002, 'Car is not available');
            END IF;
            
            -- Check if pickup location is in the same city as car's current location
            SELECT location_city INTO v_pickup_city FROM location WHERE location_id = p_pickup_id;
            SELECT location_city INTO v_car_city FROM location WHERE location_id = (SELECT current_location FROM cars WHERE car_id = p_car_id);
            IF v_pickup_city <> v_car_city THEN
                RAISE_APPLICATION_ERROR(-20003, 'Car is not available in pickup city');
            END IF;
            
            -- Insert booking record
            INSERT INTO booking (customer_id, booking_datetime, car_id, booking_start_datetime, booking_end_datetime, booking_pickup, booking_drop, booking_insurance_code, discount_code,booking_status)
            VALUES (p_customer_id, SYSDATE, p_car_id, p_booking_start_date, p_booking_end_date, p_pickup_id, p_drop_id, p_insurance_code, p_discount_code,'Booked');
            
            -- Update car status
            UPDATE cars SET car_availabilty = 'Booked' WHERE car_id = p_car_id;
            
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Booking added successfully');
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END add_booking;

        
        
        -- Procedure to cancel a booking
        PROCEDURE cancel_booking(
            p_booking_id IN NUMBER
        )
        IS
        BEGIN
            UPDATE booking
            SET booking_status = 'CANCELLED'
            WHERE booking_id = p_booking_id;
            
            UPDATE cars
            SET car_availabilty = 'Available'
            WHERE car_id = (SELECT car_id FROM booking WHERE booking_id = p_booking_id);
            
            DBMS_OUTPUT.PUT_LINE('Booking ' || p_booking_id || ' has been cancelled and the corresponding car availability updated to AVAILABLE.');
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Booking ' || p_booking_id || ' does not exist.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error cancelling booking ' || p_booking_id || ': ' || SQLERRM);
        END cancel_booking;
        
        
        -- Procedure to complete a booking
    PROCEDURE complete_booking(
    p_booking_id IN NUMBER
    )
    IS
    v_car_id NUMBER;
    v_total_amount NUMBER;
    v_drop_location_id NUMBER;
    v_billing_id billing.bill_id%TYPE; -- new variable to hold the billing id
    BEGIN
    -- Get the car ID and drop location associated with the booking
    SELECT car_id, booking_drop INTO v_car_id, v_drop_location_id FROM booking WHERE booking_id = p_booking_id;

    -- Calculate the billing for the booking
    v_total_amount := calculate_billing(p_booking_id, p_total_amount => v_total_amount); 

    -- Insert a new record into the bill table
    INSERT INTO billing (booking_id,bill_status,totalAmount, bill_date)
    VALUES (p_booking_id, 'Unpaid', v_total_amount, SYSDATE)
    RETURNING bill_id INTO v_billing_id; -- use RETURNING to get the new billing id

    -- Update the booking status and billing id
    UPDATE booking SET booking_status = 'COMPLETED', bill_id = v_billing_id WHERE booking_id = p_booking_id;

    -- Update the car availability
    UPDATE cars SET car_availabilty = 'Available', current_location = v_drop_location_id WHERE car_id = v_car_id;

    DBMS_OUTPUT.PUT_LINE('Booking ' || p_booking_id || ' has been marked as completed, the car has been made available, a new bill has been generated, and the booking table has been updated with the new billing id.');
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Booking ' || p_booking_id || ' does not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error completing booking ' || p_booking_id || ': ' || SQLERRM);
    END complete_booking;


    END booking_pkg;
    /


    GRANT EXECUTE ON booking_pkg TO customer_accounts;

    grant EXECUTE on booking_pkg to management_accounts;
    /






