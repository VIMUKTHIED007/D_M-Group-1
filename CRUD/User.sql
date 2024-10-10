--Insert a new Guest

CREATE OR REPLACE PROCEDURE add_guest(
    p_guestID IN NUMBER,
    p_firstname IN VARCHAR2,
    p_lastname IN VARCHAR2,
    p_contact IN VARCHAR2,
    p_email IN VARCHAR2,
    p_address IN VARCHAR2
) IS
BEGIN
    INSERT INTO Guest (GuestID, FirstName, LastName, Contact, Email, Address)
    VALUES (p_guestID, p_firstname, p_lastname, p_contact, p_email, p_address);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: GuestID already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Retrieve Guest Details

CREATE OR REPLACE PROCEDURE get_guest(
    p_guestID IN NUMBER
) IS
    v_firstname Guest.FirstName%TYPE;
    v_lastname Guest.LastName%TYPE;
    v_contact Guest.Contact%TYPE;
    v_email Guest.Email%TYPE;
    v_address Guest.Address%TYPE;
BEGIN
    SELECT FirstName, LastName, Contact, Email, Address
    INTO v_firstname, v_lastname, v_contact, v_email, v_address
    FROM Guest
    WHERE GuestID = p_guestID;

    DBMS_OUTPUT.PUT_LINE('Guest Details:');
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_firstname || ' ' || v_lastname);
    DBMS_OUTPUT.PUT_LINE('Contact: ' || v_contact);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Guest not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Modify Guest Contact Info

CREATE OR REPLACE PROCEDURE update_guest_contact(
    p_guestID IN NUMBER,
    p_new_contact IN VARCHAR2
) IS
BEGIN
    UPDATE Guest
    SET Contact = p_new_contact
    WHERE GuestID = p_guestID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Guest not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Guest contact updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Remove a Guest

CREATE OR REPLACE PROCEDURE delete_guest(
    p_guestID IN NUMBER
) IS
BEGIN
    DELETE FROM Guest WHERE GuestID = p_guestID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Guest not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Guest deleted successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/