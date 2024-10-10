--new Reservation

CREATE OR REPLACE PROCEDURE add_reservation(
    p_reservationID IN NUMBER,
    p_guestID IN NUMBER,
    p_roomID IN NUMBER,
    p_checkInDate IN DATE,
    p_checkOutDate IN DATE,
    p_totalPrice IN NUMBER
) IS
BEGIN
    INSERT INTO Reservation (ReservationID, GuestID, RoomID, CheckInDate, CheckOutDate, TotalPrice)
    VALUES (p_reservationID, p_guestID, p_roomID, p_checkInDate, p_checkOutDate, p_totalPrice);
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: GuestID or RoomID not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Retrieve Reservation Details

CREATE OR REPLACE PROCEDURE get_reservation(
    p_reservationID IN NUMBER
) IS
    v_guestID Reservation.GuestID%TYPE;
    v_roomID Reservation.RoomID%TYPE;
    v_checkInDate Reservation.CheckInDate%TYPE;
    v_checkOutDate Reservation.CheckOutDate%TYPE;
    v_totalPrice Reservation.TotalPrice%TYPE;
BEGIN
    SELECT GuestID, RoomID, CheckInDate, CheckOutDate, TotalPrice
    INTO v_guestID, v_roomID, v_checkInDate, v_checkOutDate, v_totalPrice
    FROM Reservation
    WHERE ReservationID = p_reservationID;

    DBMS_OUTPUT.PUT_LINE('Reservation Details:');
    DBMS_OUTPUT.PUT_LINE('GuestID: ' || v_guestID);
    DBMS_OUTPUT.PUT_LINE('RoomID: ' || v_roomID);
    DBMS_OUTPUT.PUT_LINE('Check-In Date: ' || v_checkInDate);
    DBMS_OUTPUT.PUT_LINE('Check-Out Date: ' || v_checkOutDate);
    DBMS_OUTPUT.PUT_LINE('Total Price: ' || v_totalPrice);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Reservation not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Modify Reservation Dates

CREATE OR REPLACE PROCEDURE update_reservation_dates(
    p_reservationID IN NUMBER,
    p_new_checkInDate IN DATE,
    p_new_checkOutDate IN DATE
) IS
BEGIN
    UPDATE Reservation
    SET CheckInDate = p_new_checkInDate, CheckOutDate = p_new_checkOutDate
    WHERE ReservationID = p_reservationID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Reservation not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Reservation dates updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Remove a Reservation

CREATE OR REPLACE PROCEDURE delete_reservation(
    p_reservationID IN NUMBER
) IS
BEGIN
    DELETE FROM Reservation WHERE ReservationID = p_reservationID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Reservation not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Reservation deleted successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/