--1 Customer car Available
CREATE OR REPLACE VIEW car_available as
select * from cars where car_availabilty='Available' ;

--2 Customer viewing all insurance available for cars
CREATE OR REPLACE VIEW insurance_available as
select * from insurance;

--3 View displaying booking_status as Pending
CREATE OR REPLACE VIEW booking_pending as
select * from booking where booking_status = 'Booked';

--4 View displaying booking_status as Completed
CREATE OR REPLACE VIEW booking_completed as
select * from booking where booking_status = 'COMPLETED';

--5 View displaying booking_status as Cancelled
CREATE OR REPLACE VIEW booking_cancelled as
select * from booking where booking_status = 'CANCELLED';

--6 Customer viewing coupons
CREATE OR REPLACE VIEW discount_available as
select * from discount;

--7 All Economy Cars availablile in the system
CREATE OR REPLACE VIEW economy_car_availabilty as
select 
    c.car_name,
    c.car_make,
    c.car_model,
    c.car_year
from cars c 
join 
    car_category ca on c.category_id=ca.category_id 
where 
    ca.category_name='Economy' and c.car_availabilty='Available';

--8 All Compact Cars availablile in the system 
CREATE OR REPLACE VIEW compact_car_availabilty as
select 
    c.car_name,
    c.car_make,
    c.car_model,
    c.car_year
from cars c 
join 
    car_category ca on c.category_id=ca.category_id 
where 
    ca.category_name='Compact' and c.car_availabilty='Available';

--9 All Mid-Size Cars availablile in the system 
CREATE OR REPLACE VIEW midsize_car_availabilty as
select 
    c.car_name,
    c.car_make,
    c.car_model,
    c.car_year 
from cars c 
join 
    car_category ca on c.category_id=ca.category_id 
where 
    ca.category_name='Mid-size' and c.car_availabilty='Available';

--10 All Full-size Cars availablile in the system 
CREATE OR REPLACE VIEW fullsize_car_availabilty as
select 
    c.car_name,
    c.car_make,
    c.car_model,
    c.car_year
from cars c 
join 
    car_category ca on c.category_id=ca.category_id 
where 
    ca.category_name='Full-size' and c.car_availabilty='Available';

--11 All Luxury Cars availablile in the system
CREATE OR REPLACE VIEW luxury_car_availabilty as
select 
    c.car_name,
    c.car_make,
    c.car_model,
    c.car_year
from cars c 
join 
    car_category ca on c.category_id=ca.category_id 
where 
    ca.category_name='Luxury' and c.car_availabilty='Available';

--12 View for cars that have more than one trip and are involved in damage
CREATE OR REPLACE VIEW car_trip_damage AS
SELECT 
    c.car_id, 
    c.car_name, 
    c.car_make, 
    c.car_model, 
    COUNT(DISTINCT b.booking_id) AS trips, 
    COUNT(DISTINCT d.damage_id) AS damages
FROM Cars c
    INNER JOIN Booking b ON b.car_id = c.car_id
    INNER JOIN Damage d ON d.booking_id = b.booking_id
GROUP BY 
    c.car_id, c.car_name, c.car_make, c.car_model
HAVING COUNT(DISTINCT b.booking_id) > 0 AND COUNT(DISTINCT d.damage_id) > 0
ORDER BY 
    trips DESC, damages DESC;

--13 Type of car which is favoured more in a month
CREATE OR REPLACE VIEW preferred_car_types AS
SELECT 
    c.Category_id, 
    cc.category_name, 
    COUNT(*) as bookings_count
FROM CARS c
    INNER JOIN CAR_CATEGORY cc ON c.Category_id = cc.category_id
    INNER JOIN BOOKING b ON c.car_id = b.car_id
GROUP BY 
    c.Category_id, cc.category_name
ORDER BY 
    bookings_count DESC
fetch first 1 rows only;

--14 Displays the Revenue Report generated in a particular month along with cancelled and completed bookings   
CREATE OR REPLACE VIEW revenue_report_view AS
SELECT
    TO_CHAR(b.booking_datetime, 'YYYY') AS year,
    TO_CHAR(b.booking_datetime, 'MM') AS month,
    COUNT(DISTINCT b.booking_id) AS total_bookings,
    SUM(bi.totalAmount) AS total_revenue,
    SUM(CASE WHEN b.booking_status = 'CANCELLED' THEN bi.totalAmount ELSE 0 END) AS total_cancellation_revenue,
    SUM(CASE WHEN b.booking_status = 'COMPLETED' THEN bi.totalAmount ELSE 0 END) AS total_completed_revenue,
    (SUM(bi.totalAmount) - SUM(CASE WHEN b.booking_status = 'CANCELLED' THEN bi.totalAmount ELSE 0 END)) AS total_actual_revenue,
    cc.category_name,
    SUM(CASE WHEN b.booking_status = 'COMPLETED' THEN bi.totalAmount ELSE 0 END) AS revenue_by_category
FROM
    booking b
    INNER JOIN billing bi ON b.booking_id = bi.booking_id
    INNER JOIN cars c ON b.car_id = c.car_id
    INNER JOIN car_category cc ON c.Category_id = cc.category_id
GROUP BY
    TO_CHAR(b.booking_datetime, 'YYYY'),
    TO_CHAR(b.booking_datetime, 'MM'),
    cc.category_name;

--15 View for car utilization based on number of bookings
CREATE OR REPLACE VIEW car_utilization AS
SELECT 
    C.car_id,
    C.car_make|| ' '|| C.car_model AS car_name,
    CC.category_name,
    CC.no_of_person,
    CC.no_of_luggage,
    COUNT(B.booking_id) AS total_bookings,
    round(SUM((B.booking_end_datetime - B.booking_start_datetime)*24),2) AS total_utilization_time,
    ROUND(SUM((B.booking_end_datetime - B.booking_start_datetime)*24) / COUNT(B.booking_id), 2) AS avg_utilization_time
FROM 
    cars C
    JOIN car_category CC ON C.category_id = CC.category_id
    JOIN booking B ON C.car_id = B.car_id
GROUP BY 
    C.car_id,
    C.car_make,
    C.car_model,
    CC.category_name,
    CC.no_of_person,
    CC.no_of_luggage
ORDER BY
C.CAR_ID;
    
--16 Booking status report including booking count grouping by booking status 
CREATE or replace VIEW booking_status_report AS
SELECT 
    B.booking_status, 
    COUNT(*) AS booking_count
FROM 
    booking B
GROUP BY 
    B.booking_status;

--17 Displays damage report with count of total damages 
CREATE or replace VIEW damage_report AS
SELECT 
    C.car_id,
    CC.category_name,
    C.car_make,
    C.car_model,
    COUNT(D.damage_id) AS total_damages,
    SUM(D.damage_cost) AS total_damage_cost,
    COUNT(DISTINCT B.booking_id) AS total_bookings
FROM 
    cars C
    JOIN car_category CC ON C.category_id = CC.category_id
    JOIN booking B ON C.car_id = B.car_id
    JOIN damage D ON B.booking_id = D.booking_id
GROUP BY 
    C.car_id,
    CC.category_name,
    C.car_make,
    C.car_model;

--18 Display the monthly transaction for all cars 
CREATE OR REPLACE VIEW CAR_MONTHLY_TRANSACTION AS
SELECT 
    C.CAR_ID,
    C.CAR_NAME,
    SUM(BI.TOTALAMOUNT) as total_amount
FROM 
    CARS C 
INNER JOIN BOOKING B ON C.CAR_ID = B.CAR_ID 
INNER JOIN BILLING BI ON B.BOOKING_ID = BI.BOOKING_ID 
GROUP BY 
    C.CAR_ID,
    C.CAR_NAME
ORDER BY 
C.CAR_ID;
    




GRANT SELECT on revenue_report_view TO MANAGEMENT_ACCOUNTS;

grant select on damage_report to management_accounts;

grant select on booking_status_report to management_accounts;

grant select on car_utilization to management_accounts;

grant select on car_utilization to renter_customers;

GRANT SELECT ON car_available to customer_accounts,management_accounts;

GRANT SELECT ON economy_car_availabilty TO CUSTOMER_ACCOUNTS,MANAGEMENT_ACCOUNTS;

GRANT SELECT ON compact_car_availabilty TO CUSTOMER_ACCOUNTS,MANAGEMENT_ACCOUNTS;

GRANT SELECT ON booking_cancelled TO CUSTOMER_ACCOUNTS,MANAGEMENT_ACCOUNTS;

GRANT SELECT ON DISCOUNT TO CUSTOMER_ACCOUNTS,MANAGEMENT_ACCOUNTS;

GRANT SELECT on revenue_report_view TO MANAGEMENT_ACCOUNTS;

grant select on damage_report to management_accounts;

grant select on booking_status_report to management_accounts;

grant select on car_utilization to management_accounts;

grant select on car_utilization to renter_customers;

COMMIT;

-- Select statement for all views
SELECT * FROM car_available;
SELECT * FROM insurance_available;
SELECT * FROM booking_pending;
SELECT * FROM booking_completed;
SELECT * FROM booking_cancelled;
SELECT * FROM discount_available;
SELECT * FROM economy_car_availabilty;
SELECT * FROM compact_car_availabilty;
SELECT * FROM midsize_car_availabilty;
SELECT * FROM fullsize_car_availabilty;
SELECT * FROM luxury_car_availabilty;
SELECT * FROM car_trip_damage;
SELECT * FROM preferred_car_types;
SELECT * FROM revenue_report_view;
SELECT * FROM car_utilization;

/