CREATE OR REPLACE FUNCTION calculate_billing(
    p_booking_id IN booking.booking_id%TYPE,
    p_total_amount OUT NUMBER
) RETURN NUMBER
AS
    v_rental_cost NUMBER(10);
    v_insurance_cost NUMBER(10);
    v_discount_percentage NUMBER(10);
    v_discount_amount NUMBER(10);
    v_damage_cost NUMBER(10);
BEGIN
    SELECT ABS(((booking_start_datetime-booking_end_datetime)*24) )* cc.cost_per_hr INTO v_rental_cost
    FROM booking b inner join cars c on b.car_id=c.car_id
    inner join car_category cc on c.category_id=cc.category_id
    WHERE b.booking_id = p_booking_id; 

    SELECT NVL(cost_per_day, 0) INTO v_insurance_cost
    FROM insurance
    WHERE insurance_code = (SELECT booking_insurance_code FROM booking WHERE booking_id = p_booking_id);

    SELECT NVL(discount_percentage, 0) INTO v_discount_percentage
    FROM discount
    WHERE discount_code = (SELECT discount_code FROM booking WHERE booking_id = p_booking_id);

    v_discount_amount := (v_rental_cost + v_insurance_cost) * (v_discount_percentage / 100);

    SELECT NVL(SUM(damage_cost), 0) INTO v_damage_cost
    FROM damage
    WHERE booking_id = p_booking_id;

    p_total_amount := v_rental_cost + v_insurance_cost - v_discount_amount + v_damage_cost;
    
    RETURN p_total_amount;
END;
/

CREATE OR REPLACE FUNCTION get_frequent_cars(start_date IN DATE, end_date IN DATE)
RETURN sys_refcursor
IS
    car_cursor sys_refcursor;
BEGIN
    OPEN car_cursor FOR
    SELECT car.car_id, car.car_make, car.car_model, COUNT(*) AS rental_count, SUM(bill.totalAmount) AS total_revenue
    FROM booking
    JOIN cars car ON booking.car_id = car.car_id
    JOIN billing bill ON booking.bill_id = bill.bill_id
    WHERE booking.booking_datetime BETWEEN start_date AND end_date
    GROUP BY car.car_id, car.car_make, car.car_model
    ORDER BY rental_count DESC;
    
    RETURN car_cursor;
END;
/

CREATE OR REPLACE FUNCTION get_total_discount_amount(start_date DATE, end_date DATE)
RETURN NUMBER
IS
    total_discount NUMBER := 0;
BEGIN
    SELECT SUM(discount_percentage) INTO total_discount
    FROM discount
    WHERE expiry_date BETWEEN start_date AND end_date;
    
    RETURN total_discount;
END;
/