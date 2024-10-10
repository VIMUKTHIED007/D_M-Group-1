--Insert a new Room

CREATE OR REPLACE PROCEDURE add_room(
    p_roomID IN NUMBER,
    p_roomtype IN VARCHAR2,
    p_pricepernight IN NUMBER,
    p_status IN VARCHAR2
) IS
BEGIN
    INSERT INTO Room (RoomID, RoomType, PricePerNight, Status)
    VALUES (p_roomID, p_roomtype, p_pricepernight, p_status);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: RoomID already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Retrieve Room Details

CREATE OR REPLACE PROCEDURE get_room(
    p_roomID IN NUMBER
) IS
    v_roomtype Room.RoomType%TYPE;
    v_pricepernight Room.PricePerNight%TYPE;
    v_status Room.Status%TYPE;
BEGIN
    SELECT RoomType, PricePerNight, Status
    INTO v_roomtype, v_pricepernight, v_status
    FROM Room
    WHERE RoomID = p_roomID;

    DBMS_OUTPUT.PUT_LINE('Room Details:');
    DBMS_OUTPUT.PUT_LINE('Room Type: ' || v_roomtype);
    DBMS_OUTPUT.PUT_LINE('Price per Night: ' || v_pricepernight);
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_status);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Room not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Modify Room Status

CREATE OR REPLACE PROCEDURE update_room_status(
    p_roomID IN NUMBER,
    p_new_status IN VARCHAR2
) IS
BEGIN
    UPDATE Room
    SET Status = p_new_status
    WHERE RoomID = p_roomID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Room not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Room status updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Remove a Room

CREATE OR REPLACE PROCEDURE delete_room(
    p_roomID IN NUMBER
) IS
BEGIN
    DELETE FROM Room WHERE RoomID = p_roomID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Room not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Room deleted successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/