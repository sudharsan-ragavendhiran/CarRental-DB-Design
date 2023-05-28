DECLARE
  index_count INTEGER;
BEGIN
  -- Check if index exists
  SELECT COUNT(*)
  INTO index_count
  FROM user_indexes
  WHERE index_name = 'BOOKING_CAR_ID_IDX';

  IF index_count > 0 THEN
    -- Drop index if it exists
    DBMS_OUTPUT.PUT_LINE('Index BOOKING_CAR_ID_IDX exists. Dropping index...');
    EXECUTE IMMEDIATE 'DROP INDEX BOOKING_CAR_ID_IDX';
  END IF;

  -- Create new index
  DBMS_OUTPUT.PUT_LINE('Creating index BOOKING_CAR_ID_IDX...');
  EXECUTE IMMEDIATE 'CREATE INDEX BOOKING_CAR_ID_IDX ON booking (car_id)';
  DBMS_OUTPUT.PUT_LINE('Index BOOKING_CAR_ID_IDX created successfully.');
END;
/