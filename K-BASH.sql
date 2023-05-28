--PROJECT PHASE 3
--TEAM K-BASH


--(1)	DDL SCRIPT:
--(a)	Creating the users and granting them rights respectively
--CLEANUP SCRIPT


SET SERVEROUTPUT ON
DECLARE
  v_table_exists VARCHAR(1) := 'Y';
  v_view_exists VARCHAR(1) := 'Y';
  v_procedure_exists VARCHAR(1) := 'Y';
  v_user_exists VARCHAR(1) := 'Y';
  v_sequence_exists VARCHAR(1) := 'Y';
  v_sql VARCHAR(2000);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Start schema cleanup');

  -- Drop tables
  FOR i IN (
    SELECT 'DISCOUNT' table_name FROM dual UNION ALL
    SELECT 'LOCATION' table_name FROM dual UNION ALL
    SELECT 'INSURANCE' table_name FROM dual UNION ALL
    SELECT 'CUSTOMER' table_name FROM dual UNION ALL
    SELECT 'CARS' table_name FROM dual UNION ALL
    SELECT 'BOOKING' table_name FROM dual UNION ALL
    SELECT 'CAR_CATEGORY' table_name FROM dual UNION ALL
    SELECT 'REVIEW' table_name FROM dual UNION ALL
    SELECT 'DAMAGE' table_name FROM dual UNION ALL
    SELECT 'BILLING' table_name FROM dual 
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('....Drop table ' || i.table_name);
    BEGIN
      SELECT 'Y'
      INTO v_table_exists
      FROM USER_TABLES
      WHERE TABLE_NAME = i.table_name;

      v_sql := 'DROP TABLE ' || i.table_name;
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('........Table ' || i.table_name || ' dropped successfully');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('........Table does not exist');
    END;
  END LOOP;

  -- Drop views
  FOR i IN (
    SELECT VIEW_NAME
    FROM USER_VIEWS
    WHERE VIEW_NAME IN ('CUSTOMER_VIEW', 'BOOKING_VIEW')
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('....Drop view ' || i.VIEW_NAME);
    BEGIN
      SELECT 'Y'
      INTO v_view_exists
      FROM USER_VIEWS
      WHERE VIEW_NAME = i.VIEW_NAME;

      v_sql := 'DROP VIEW ' || i.VIEW_NAME;
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('........View ' || i.VIEW_NAME || ' dropped successfully');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('........View does not exist');
    END;
  END LOOP;

  -- Drop procedures
  FOR i IN (
    SELECT OBJECT_NAME
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE = 'PROCEDURE' AND OBJECT_NAME IN ('ADD_BOOKING', 'ADD_CAR','ADD_CUSTOMER')
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('....Drop procedure ' || i.OBJECT_NAME);
    BEGIN
      SELECT 'Y'
      INTO v_procedure_exists
      FROM USER_OBJECTS
      WHERE OBJECT_TYPE = 'PROCEDURE' AND OBJECT_NAME = i.OBJECT_NAME;

      v_sql := 'DROP PROCEDURE ' || i.OBJECT_NAME;
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('........Procedure ' || i.OBJECT_NAME || ' dropped successfully');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('........Procedure does not exist');
    END;
  END LOOP;

-- Drop sequences
BEGIN
  FOR i IN (
    SELECT SEQUENCE_NAME
    FROM USER_SEQUENCES
    WHERE SEQUENCE_NAME IN (
      'RENTAL_ID_SEQ',
      'BOOKING_ID_SEQ',
      'LOCATION_ID_SEQ',
      'CAR_ID_SEQ',
      'CATEGORY_ID_SEQ',
      'DAMAGE_ID_SEQ',
      'REVIEW_ID_SEQ',
      'BILLING_ID_SEQ',
      'DISCOUNT_ID_SEQ',
      'CUSTOMER_ID_SEQ'
    )
  ) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || i.SEQUENCE_NAME;
    DBMS_OUTPUT.PUT_LINE('Dropped sequence ' || i.SEQUENCE_NAME);
  END LOOP;
END;

END;
/


CREATE SEQUENCE customer_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE booking_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE location_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE car_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE category_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE damage_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE review_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE billing_id_seq
    MINVALUE 1
    MAXVALUE 1000
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE discount_id_seq
  MINVALUE 1
  MAXVALUE 1000
  START WITH 1
  INCREMENT BY 1
  CACHE 20;


--Customer
CREATE TABLE customer (
    customer_id NUMBER DEFAULT customer_id_seq.NEXTVAL PRIMARY KEY,
    customer_first_name VARCHAR2(30) NOT NULL,
    customer_last_name VARCHAR2(30) NOT NULL,
    customer_driving_license VARCHAR2(10) NOT NULL,
    customer_dob DATE NOT NULL,
    customer_contactNumber NUMBER(10) NOT NULL,
    customer_email VARCHAR2(30) NOT NULL,
    customer_address_line_1 VARCHAR2(30) NOT NULL,
    customer_city VARCHAR2(30) NOT NULL,
    customer_zip NUMBER(10) NOT NULL,
    customer_type VARCHAR2(10) NOT NULL,
    customer_isverified CHAR(1) NOT NULL
);


--Cars
CREATE TABLE cars (
  car_id NUMBER(10) DEFAULT car_id_seq.NEXTVAL PRIMARY KEY NOT NULL,
  car_name VARCHAR2(30) NOT NULL,
  car_make VARCHAR2(30) NOT NULL,
  car_model VARCHAR2(30) NOT NULL,
  car_year NUMBER(4) NOT NULL,
  car_plateno VARCHAR2(10) NOT NULL,
  car_availabilty VARCHAR2(10) NOT NULL,
  car_mileage NUMBER(10) NOT NULL,
  customer_id NUMBER(10) NOT NULL,
  current_location NUMBER(10) NOT NULL,
  Category_id NUMBER(10) NOT NULL,
  car_isverified Char(1) NOT NULL
);

--Booking
CREATE TABLE booking (
  booking_id NUMBER(10)DEFAULT booking_id_seq.NEXTVAL PRIMARY KEY NOT NULL,
  customer_id NUMBER(10) NOT NULL,
  booking_datetime DATE NOT NULL,
  car_id NUMBER(10) NOT NULL,
  booking_start_datetime DATE  NOT NULL,
  booking_end_datetime DATE NOT NULL,
  booking_pickup NUMBER(10) NOT NULL,
  booking_drop NUMBER(10)  NOT NULL,
  booking_status VARCHAR2(10) NOT NULL,
  booking_insurance_code NUMBER(10) NOT NULL,
  bill_id NUMBER(10) NOT NULL,
  discount_code NUMBER(10) NOT NULL
);
ALTER TABLE booking MODIFY bill_id NUMBER(10,0) NULL;


CREATE TABLE damage(
  damage_id NUMBER(10) PRIMARY KEY NOT NULL,
  damage_name VARCHAR(10) NOT NULL,
  damage_description VARCHAR(50) NOT NULL,
  damage_cost NUMBER(10) NOT NULL,
  booking_id NUMBER(10) NOT NULL
);


--BILLING
CREATE TABLE billing (
    bill_id NUMBER(10) DEFAULT billing_id_seq.NEXTVAL PRIMARY KEY NOT NULL,
    booking_id NUMBER(10) NOT NULL,
    bill_status VARCHAR(10),
    totalAmount NUMBER(10) NOT NULL,
    bill_date DATE NOT NULL
);

--insurance
CREATE TABLE insurance (
    insurance_code NUMBER(10) PRIMARY KEY NOT NULL,
    insurance_name VARCHAR(20) NOT NULL,
    coverage_type VARCHAR(10) NOT NULL,
    cost_per_day NUMBER(10) NOT NULL,
    max_coverage NUMBER(10) NOT NULL
);


--discount
CREATE TABLE discount (
    discount_code NUMBER(10) DEFAULT discount_id_seq.NEXTVAL PRIMARY KEY NOT NULL,
    discount_name VARCHAR2(20) NOT NULL,
    discount_percentage NUMBER(10) NOT NULL,
    expiry_date DATE NOT NULL
);


--location
CREATE TABLE location (
    location_id NUMBER(10) DEFAULT location_id_seq.NEXTVAL PRIMARY KEY ,
    location_name VARCHAR(30) NOT NULL,
    location_address_line_1 VARCHAR(30) NOT NULL,
    location_city VARCHAR(30) NOT NULL,
    location_zip NUMBER(10) NOT NULL
);


--review
CREATE TABLE review (
    review_id NUMBER(10) DEFAULT review_id_seq.NEXTVAL PRIMARY KEY NOT NULL,
    review_title VARCHAR(10) NOT NULL,
    review_description VARCHAR(50) NOT NULL,
    car_id NUMBER(10) NOT NULL
);

--cateogry
CREATE TABLE car_category (
  category_id NUMBER(10) DEFAULT category_id_seq.NEXTVAL  PRIMARY KEY NOT NULL,
  category_name VARCHAR(10) NOT NULL,
  no_of_person NUMBER(10) NOT NULL,
  no_of_luggage NUMBER(10) NOT NULL,
  cost_per_hr NUMBER(10) NOT NULL
);

-- Procedure
CREATE OR REPLACE PROCEDURE add_car (
  p_car_name IN cars.car_name%TYPE,
  p_car_make IN cars.car_make%TYPE,
  p_car_model IN cars.car_model%TYPE,
  p_car_year IN cars.car_year%TYPE,
  p_car_plateno IN cars.car_plateno%TYPE,
  p_car_availabilty IN cars.car_availabilty%TYPE,
  p_car_mileage IN cars.car_mileage%TYPE,
  p_customer_id IN cars.customer_id%TYPE,
  p_current_location IN cars.current_location%TYPE,
  p_Category_id IN cars.Category_id%TYPE,
  p_car_isverified IN cars.car_isverified%TYPE
) IS
  v_count NUMBER;
  v_car_id NUMBER;
BEGIN
  -- Check if car_plateno already exists
  SELECT COUNT(*) INTO v_count FROM cars WHERE car_plateno = p_car_plateno;
  
  IF v_count > 0 THEN
    -- If car_plateno already exists, raise an error
    RAISE_APPLICATION_ERROR(-20001, 'Car with that plate number already exists');
  ELSE
    -- Otherwise, insert new car entry
    INSERT INTO cars ( car_name, car_make, car_model, car_year, car_plateno,
      car_availabilty, car_mileage, customer_id, current_location, Category_id, car_isverified
    ) VALUES (p_car_name, p_car_make, p_car_model, p_car_year, p_car_plateno,
      p_car_availabilty, p_car_mileage, p_customer_id, p_current_location, p_Category_id, p_car_isverified
    );
    
  END IF;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE add_customer (
    in_first_name VARCHAR2,
    in_last_name VARCHAR2,
    in_driving_license VARCHAR2,
    in_dob DATE,
    in_contactNumber NUMBER,
    in_email VARCHAR2,
    in_address_line_1 VARCHAR2,
    in_city VARCHAR2,
    in_zip NUMBER,
    in_customer_type VARCHAR2
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM customer WHERE Customer_driving_license = in_driving_license;
    
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Customer already exists.');
    ELSE
        INSERT INTO customer (
            customer_first_name,
            customer_last_name,
            Customer_driving_license,
            customer_dob,
            customer_contactNumber,
            customer_email,
            customer_address_line_1,
            customer_city,
            customer_zip,
            customer_type,
            customer_isverified
        ) VALUES (
            in_first_name,
            in_last_name,
            in_driving_license,
            in_dob,
            in_contactNumber,
            in_email,
            in_address_line_1,
            in_city,
            in_zip,
            in_customer_type,
            'F'
        );
        DBMS_OUTPUT.PUT_LINE('Customer added successfully.');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE update_customer_verification(
    p_customer_id IN customer.customer_id%TYPE
)
IS
BEGIN
    UPDATE customer
    SET customer_isverified = 'T'
    WHERE customer_id = p_customer_id;
    
    COMMIT;
END;

/
CREATE OR REPLACE PROCEDURE mark_bill_as_paid (p_bill_id IN NUMBER)
AS
BEGIN
  UPDATE billing
  SET bill_status = 'PAID'
  WHERE bill_id = p_bill_id;
  DBMS_OUTPUT.PUT_LINE('Bill ' || p_bill_id || ' marked as PAID.');
END;
/


CREATE OR REPLACE PROCEDURE mark_bill_paid(
    p_booking_id IN NUMBER
)
IS
BEGIN
    -- Update the bill status to "Paid" for the given booking ID
    UPDATE billing SET bill_status = 'Paid' WHERE booking_id = p_booking_id;

    DBMS_OUTPUT.PUT_LINE('Billing record for booking ' || p_booking_id || ' has been marked as Paid.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Billing record for booking ' || p_booking_id || ' does not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error marking billing record for booking ' || p_booking_id || ' as Paid: ' || SQLERRM);
END;
/

-- 

-- BEGIN 
--    COMPLETE_BOOKING(1);
--    CANCEL_BOOKING(7);
--    mark_bill_paid(1);
--    CANCEL_BOOKING(7);
-- END;
/
GRANT SELECT,UPDATE ON  customer TO customer_accounts ; 

GRANT SELECT ON   booking TO customer_accounts ; 

GRANT SELECT ON  insurance TO customer_accounts; 

GRANT SELECT ON  discount TO customer_accounts; 

GRANT SELECT ON  billing TO customer_accounts; 

GRANT SELECT ON  cars TO customer_accounts; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  DAMAGE TO customer_accounts; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  review TO customer_accounts; 

GRANT SELECT ON   customer TO management_accounts ; 

GRANT SELECT ON   booking TO management_accounts ; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  insurance TO management_accounts; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  discount TO management_accounts; 

GRANT SELECT ON  billing TO management_accounts; 

GRANT SELECT ON  cars TO management_accounts; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  CAR_CATEGORY TO management_accounts; 

GRANT SELECT ON  DAMAGE TO management_accounts; 

GRANT SELECT ON  review TO management_accounts; 

GRANT SELECT,UPDATE ON   customer TO renter_customers ; 

GRANT SELECT ON   booking TO renter_customers ; 

GRANT SELECT ON  insurance TO renter_customers; 

GRANT SELECT ON  discount TO renter_customers; 

GRANT SELECT ON  billing TO renter_customers; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  cars TO renter_customers; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  DAMAGE TO renter_customers; 

GRANT SELECT, INSERT, UPDATE, DELETE ON  review TO renter_customers; 

GRANT EXECUTE ON mark_bill_as_paid TO MANAGEMENT_ACCOUNTS;

GRANT EXECUTE ON add_customer TO customer_accounts;

GRANT EXECUTE ON add_car TO renter_customers;

GRANT EXECUTE ON update_customer_verification TO MANAGEMENT_ACCOUNTS;

COMMIT;
/


