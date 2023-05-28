
SET SERVEROUTPUT ON;

BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'USER_SR') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/

-- Kill sessions for customer_user
BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'CUSTOMER_ACCOUNTS') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/

-- Kill sessions for manager_user
BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'MANAGEMENT_ACCOUNTS') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/

-- Kill sessions for RENTER_USER
BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'RENTER_CUSTOMERS') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/
-- delete users
DECLARE
  v_user_exists VARCHAR(1) := 'Y';
BEGIN
  FOR i IN (
    SELECT USERNAME
    FROM DBA_USERS
    WHERE USERNAME IN ('USER_SR', 'CUSTOMER_ACCOUNTS', 'MANAGEMENT_ACCOUNTS', 'RENTER_CUSTOMERS')
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('....Drop user ' || i.USERNAME);
    BEGIN
      SELECT 'Y'
      INTO v_user_exists
      FROM DBA_USERS
      WHERE USERNAME = i.USERNAME;

      EXECUTE IMMEDIATE 'DROP USER ' || i.USERNAME || ' CASCADE';
      DBMS_OUTPUT.PUT_LINE('........User ' || i.USERNAME || ' dropped successfully');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('........User does not exist');
    END;
  END LOOP;
END;
/




CREATE USER user_sr IDENTIFIED BY KBASH_DMDd2023;

COMMIT;

CREATE USER customer_accounts IDENTIFIED BY KBASH_DMDd2023;

COMMIT;

CREATE USER management_accounts IDENTIFIED BY KBASH_DMDd2023;

COMMIT;

CREATE USER renter_customers IDENTIFIED BY KBASH_DMDd2023;

COMMIT;



GRANT CONNECT,RESOURCE TO USER_SR;

COMMIT; 

GRANT CONNECT,RESOURCE TO customer_accounts;

COMMIT;

GRANT CONNECT,RESOURCE TO management_accounts;

COMMIT;

GRANT CONNECT,RESOURCE TO renter_customers;

COMMIT;



GRANT CREATE SESSION  TO user_sr;

GRANT CREATE SESSION TO customer_accounts;

GRANT CREATE SESSION TO management_accounts;

GRANT CREATE SESSION TO renter_customers;

COMMIT;




GRANT UNLIMITED TABLESPACE TO user_sr; 

GRANT UNLIMITED TABLESPACE TO customer_accounts; 

GRANT UNLIMITED TABLESPACE TO management_accounts; 

GRANT UNLIMITED TABLESPACE TO renter_customers;

COMMIT; 

GRANT DROP ANY TABLE, DROP ANY SEQUENCE, drop any procedure TO USER_SR;
COMMIT;

GRANT CREATE VIEW,CREATE SEQUENCE, CREATE TABLE,create procedure TO USER_SR;

COMMIT;
 
BEGIN
    FOR t IN (SELECT table_name FROM all_tables WHERE owner = 'USER_SR') LOOP
        EXECUTE IMMEDIATE 'GRANT ALL PRIVILEGES ON USER_SR.' || t.table_name || ' TO USER_SR';
    END LOOP;
END;
/

COMMIT;
/

