
INSERT INTO insurance (insurance_code, insurance_name, coverage_type, cost_per_day, max_coverage)
SELECT 1, 'Basic Insurance', 'Liability', 5, 50000 FROM dual UNION ALL
SELECT 2, 'Standard Insurance', 'Collision', 10, 100000 FROM dual UNION ALL
SELECT 3, 'Premium Insurance', 'Collision', 15, 150000 FROM dual UNION ALL
SELECT 4, 'Extended Insurance', 'Collision', 20, 200000 FROM dual UNION ALL
SELECT 5, 'Full Coverage Ins', 'Collision', 25, 250000 FROM dual UNION ALL
SELECT 6, 'Suppl Liability Ins', 'Liability', 8, 80000 FROM dual UNION ALL
SELECT 7, 'Personal Acc. Ins', 'Personal', 7, 70000 FROM dual UNION ALL
SELECT 8, 'Loss Damage Waiver', 'Collision', 12, 120000 FROM dual UNION ALL
SELECT 9, 'Theft Protection Ins', 'Theft', 10, 100000 FROM dual UNION ALL
SELECT 10, '3rd Party Liab', 'Liability', 6, 60000 FROM dual;



INSERT INTO discount (discount_name, discount_percentage, expiry_date)
SELECT 'New Year Sale', 20, TO_DATE('2023-01-15', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Summer Discount', 15, TO_DATE('2023-07-31', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Thanksgiving Spc', 25, TO_DATE('2023-11-30', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Early Bird Offer', 10, TO_DATE('2023-04-30', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Black Friday Sale', 30, TO_DATE('2023-11-27', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Weekend Special', 5, TO_DATE('2023-12-31', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Winter Discount', 15, TO_DATE('2024-01-31', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Senior Citizen Dis', 10, TO_DATE('2023-12-31', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Student Discount', 8, TO_DATE('2023-12-31', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 'Corporate Discount', 12, TO_DATE('2023-12-31', 'YYYY-MM-DD') FROM dual;

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'Downtown San Francisco', '100 Market St', 'San Francisco', 94103);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'San Francisco Intl Airport', '780 McDonnell Rd', 'San Francisco', 94128);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'Los Angeles Intl Airport', '1 World Way', 'Los Angeles', 90045);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'Beverly Hills', '90210 Beverly Dr', 'Los Angeles', 90210);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'Santa Monica', '2nd St', 'Los Angeles', 90401);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'San Diego Intl Airport', '3225 N Harbor Dr', 'San Diego', 92101);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'Gaslamp Quarter', '5th Ave', 'San Diego', 92101);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'Las Vegas Strip', 'Las Vegas Blvd', 'Las Vegas', 89109);

INSERT INTO location (location_id, location_name, location_address_line_1, location_city, location_zip)
VALUES (location_id_seq.NEXTVAL, 'McCarran Intl Airport', '5757 Wayne Newton Blvd', 'Las Vegas', 89119);


INSERT INTO car_category(category_name, no_of_person, no_of_luggage, cost_per_hr)
VALUES ('Economy', 4, 2, 25);

INSERT INTO car_category(category_name, no_of_person, no_of_luggage, cost_per_hr)
VALUES ('Compact', 4, 3, 30);

INSERT INTO car_category(category_name, no_of_person, no_of_luggage, cost_per_hr)
VALUES ('Mid-size', 5, 4, 40);

INSERT INTO car_category(category_name, no_of_person, no_of_luggage, cost_per_hr)
VALUES ('Full-size', 7, 5, 50);
ALTER TRIGGER bill_insert_trigger DISABLE;
ALTER TRIGGER set_booking_status_pending DISABLE;

INSERT INTO car_category(category_name, no_of_person, no_of_luggage, cost_per_hr)
VALUES ('Luxury', 4, 2, 100);


-- Insert 10 sample customers using the add_customer procedure
BEGIN
  add_customer('John', 'Doe', '1234567890', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 1234567890, 'john.doe@example.com', '123 Main St', 'Anytown', 12345, 'Individual');
  add_customer('Jane', 'Doe', '0987654321', TO_DATE('1985-01-01', 'YYYY-MM-DD'), 0987654321, 'jane.doe@example.com', '456 Second St', 'Otherville', 98765, 'Individual');
  add_customer('Bob', 'Smith', '1111111111', TO_DATE('1975-01-01', 'YYYY-MM-DD'), 1111111111, 'bob.smith@example.com', '789 Third St', 'Smallville', 54321, 'Corporate');
  add_customer('Alice', 'Johnson', '2222222222', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 2222222222, 'alice.johnson@example.com', '10 Elm St', 'Bigcity', 67890, 'Individual');
  add_customer('James', 'Brown', '3333333333', TO_DATE('1983-01-01', 'YYYY-MM-DD'), 3333333333, 'james.brown@example.com', '12 Maple St', 'Hometown', 45678, 'Corporate');
  add_customer('Sarah', 'Lee', '4444444444', TO_DATE('1988-01-01', 'YYYY-MM-DD'), 4444444444, 'sarah.lee@example.com', '14 Oak St', 'Anytown', 12345, 'Individual');
  add_customer('Michael', 'Chang', '5555555555', TO_DATE('1977-01-01', 'YYYY-MM-DD'), 5555555555, 'michael.chang@example.com', '16 Pine St', 'Otherville', 98765, 'Corporate');
  add_customer('Maggie', 'Smith', '6666666666', TO_DATE('1986-01-01', 'YYYY-MM-DD'), 6666666666, 'maggie.smith@example.com', '18 Birch St', 'Smallville', 54321, 'Individual');
  add_customer('Tom', 'Jones', '7777777777', TO_DATE('1981-01-01', 'YYYY-MM-DD'), 7777777777, 'tom.jones@example.com', '20 Spruce St', 'Bigcity', 67890, 'Individual');
  add_customer('Julia', 'Roberts', '8888888888', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 8888888888, 'julia.roberts@example.com', '22 Cedar St', 'Hometown', 45678, 'Corporate');
END;
/


BEGIN 
    update_customer_verification(1);
    update_customer_verification(2);
    update_customer_verification(3);
    update_customer_verification(4);
    update_customer_verification(5);
    update_customer_verification(6);
    update_customer_verification(7);
    update_customer_verification(8);
    update_customer_verification(9);
    update_customer_verification(10);
END;
/


BEGIN
  add_car('Toyota Camry', 'Toyota', 'Camry', 2015, 'ABC123', 'Available', 50, 3, 1, 2, 'T');
  add_car('Honda Civic', 'Honda', 'Civic', 2018, 'DEF456', 'Available', 35, 5, 2, 1, 'T');
  add_car('Ford Mustang', 'Ford', 'Mustang', 2020, 'GHI789', 'Available', 10, 7, 3, 3, 'T');
  add_car('Chevrolet Tahoe', 'Chevrolet', 'Tahoe', 2019, 'JKL012', 'Available', 25, 10, 4, 5, 'T');
  add_car('Mercedes-Benz C-Class', 'Mercedes-Benz', 'C-Class', 2021, 'MNO345', 'Available', 5, 10, 5, 1, 'T');
  add_car('Audi A4', 'Audi', 'A4', 2017, 'PQR678', 'Available', 40, 3, 1, 4, 'T');
  add_car('BMW 3 Series', 'BMW', '3 Series', 2020, 'STU901', 'Available', 15, 7, 2, 3, 'T');
  add_car('Lexus RX', 'Lexus', 'RX', 2022, 'VWX234', 'Available', 10, 8, 3, 1, 'T');
  add_car('Nissan Altima', 'Nissan', 'Altima', 2016, 'YZA567', 'Available', 55, 5, 4, 1, 'T');
  add_car('Tesla Model 3', 'Tesla', 'Model 3', 2021, 'BCD890', 'Available', 20, 10, 5, 4, 'T');
  add_car('Mercedes-4 Matic', 'Mercedes', 'C-Class',2022,'KAR018','Available',80,2,1,1,'T');
  add_car('Swift dezire','Swift','D-4',2018,'THI908','Available',12,3,2,1,'T');
  add_car('Aria','TATA','Aria',2020,'KPR453','Available',80,5,4,4,'T');
  add_car('Q7','Audi','Q7',2018,'AKA765','Available',26,9,3,3,'T');
  add_car('Indigo','TATA','Aria',2016,'SHA045','Available',30,1,3,1,'T');
  add_car('Wagnor','Suzuki','Wagnor',2010,'VAN765','Available',25,5,1,1,'T');
  add_car('Accord Sedan', 'Honda', 'Accord', 2018, 'AB1234', 'Available', 32, 3, 2, 2, 'T');
  add_car('Civic Sedan', 'Honda', 'Civic', 2020, 'CD5678', 'Available', 15, 2, 1, 2, 'T');
  add_car('Sonata', 'Hyundai', 'Sonata', 2017, 'GH3486', 'Available', 50, 4, 2, 2, 'T');
END;
/



INSERT INTO review (review_title, review_description, car_id)
VALUES ('Great Car', 'This car is amazing!', 1);

INSERT INTO review (review_title, review_description, car_id)
VALUES ('Love it', 'This car is perfect for me', 2);

INSERT INTO review (review_title, review_description, car_id)
VALUES ('Solid Car', 'Runs like a charm', 3);

INSERT INTO review (review_title, review_description, car_id)
VALUES ('Amazing', 'I cant believe how smooth the ride is', 4);

INSERT INTO review (review_title, review_description, car_id)
VALUES ('Impressed', 'This car exceeded my expectations', 5);

INSERT INTO review (review_title, review_description, car_id)
VALUES ('Luxury', 'The interior of this car is stunning', 6);

INSERT INTO review (review_title, review_description, car_id)
VALUES ('GreatValue', 'I got alot for my money',7);

BEGIN
  booking_pkg.add_booking(1,1,1,9,TO_DATE('2023-01-01 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-01-04 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);
  booking_pkg.add_booking(10,14,3,1,TO_DATE('2023-01-09 11:30:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-01-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),2,10);
  booking_pkg.add_booking(2,3,3,8,TO_DATE('2023-01-23 13:30:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-01-29 14:30:00','YYYY-MM-DD HH24:MI:SS'),3,9);
  booking_pkg.add_booking(9,18,1,2,TO_DATE('2023-01-23 15:30:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-01-31 15:45:00','YYYY-MM-DD HH24:MI:SS'),4,8);
  booking_pkg.add_booking(3,5,5,7,TO_DATE('2023-02-01 16:15:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-02-04 16:40:00','YYYY-MM-DD HH24:MI:SS'),5,7);
  booking_pkg.add_booking(7,6,1,3,TO_DATE('2023-02-02 17:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-02-07 17:00:00','YYYY-MM-DD HH24:MI:SS'),6,6);
  booking_pkg.add_booking(4,7,4,6,TO_DATE('2023-02-09 18:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-02-14 18:30:00','YYYY-MM-DD HH24:MI:SS'),7,5);
  booking_pkg.add_booking(6,8,6,4,TO_DATE('2023-02-12 18:45:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-02-18 19:15:00','YYYY-MM-DD HH24:MI:SS'),8,4);
  booking_pkg.add_booking(5,9,4,5,TO_DATE('2023-02-20 19:30:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-02-28 20:00:00','YYYY-MM-DD HH24:MI:SS'),9,3);
  booking_pkg.add_booking(8,10,5,1,TO_DATE('2023-03-08 21:30:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-03-18 22:00:00','YYYY-MM-DD HH24:MI:SS'),10,2);
END;
/

INSERT INTO damage(damage_name,damage_description, damage_id,booking_id,damage_cost)
VALUES('Dent','Small dent near the doors',1,1,100);

INSERT INTO damage(damage_name,damage_description,damage_id,booking_id,damage_cost)
VALUES('Mirror','left side mirror broken',2,2,200);

INSERT INTO damage(damage_name,damage_description,damage_id,booking_id,damage_cost)
VALUES('Brake','brake not working properly',3,3,100);

INSERT INTO damage(damage_name,damage_description,damage_id,booking_id,damage_cost)
VALUES('Glass','glass hit by a rock and broken',4,4,150);

INSERT INTO damage(damage_name,damage_description,damage_id,booking_id,damage_cost)
VALUES('Windshield','windshield hit by a rock',5,5,100);

INSERT INTO damage(damage_name,damage_description,damage_id,booking_id,damage_cost)
VALUES('Windshield','windshield hit by a stone',6,4,100);

INSERT INTO damage(damage_name,damage_description,damage_id,booking_id,damage_cost)
VALUES('Windshield','windshield hit by a cchappal',7,3,100);

INSERT INTO damage(damage_name,damage_description,damage_id,booking_id,damage_cost)
VALUES('Windshield','windshield hit by a glass',8,4,100);

BEGIN
    booking_pkg.complete_booking(1);
    booking_pkg.complete_booking(7);
    booking_pkg.complete_booking(4);
    booking_pkg.complete_booking(2);
    booking_pkg.cancel_booking(3);
    booking_pkg.cancel_booking(5);
END;
/

BEGIN
booking_pkg.add_booking(3,1,9,1,TO_DATE('2023-04-11 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-04-14 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);
booking_pkg.cancel_booking(9);

booking_pkg.add_booking(1,3,3,1,TO_DATE('2023-04-11 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-04-14 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);
booking_pkg.complete_booking(10);

booking_pkg.add_booking(5,9,5,4,TO_DATE('2023-04-12 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-04-15 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);
booking_pkg.complete_booking(11);

booking_pkg.add_booking(8,9,4,9,TO_DATE('2023-05-11 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-05-14 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);

END; 
/


BEGIN 
booking_pkg.add_booking(1,1,9,1,TO_DATE('2023-06-01 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-06-03 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);
booking_pkg.complete_booking(13);

booking_pkg.add_booking(3,5,3,1,TO_DATE('2023-06-01 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-06-04 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);
booking_pkg.complete_booking(14);

booking_pkg.add_booking(6,7,2,1,TO_DATE('2023-06-11 10:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-06-14 10:30:00','YYYY-MM-DD HH24:MI:SS'),1,1);
booking_pkg.complete_booking(15);
END;
/

BEGIN
mark_bill_as_paid(1);
mark_bill_as_paid(4);
mark_bill_as_paid(7);
mark_bill_as_paid(8);
END;
/