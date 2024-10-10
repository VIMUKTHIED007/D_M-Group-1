--Insert Payment


CREATE OR REPLACE PROCEDURE add_payment(
    p_paymentID IN NUMBER,
    p_reservationID IN NUMBER,
    p_paymentAmount IN NUMBER,
    p_paymentDate IN DATE,
    p_paymentMethod IN VARCHAR2,
    p_paymentStatus IN VARCHAR2
) IS
BEGIN
    INSERT INTO Payments (PaymentID, ReservationID, PaymentAmount, PaymentDate, PaymentMethod, PaymentStatus)
    VALUES (p_paymentID, p_reservationID, p_paymentAmount, p_paymentDate, p_paymentMethod, p_paymentStatus);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: PaymentID already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Retrieve Payment Details

CREATE OR REPLACE PROCEDURE get_payment(
    p_paymentID IN NUMBER
) IS
    v_reservationID Payments.ReservationID%TYPE;
    v_paymentAmount Payments.PaymentAmount%TYPE;
    v_paymentDate Payments.PaymentDate%TYPE;
    v_paymentMethod Payments.PaymentMethod%TYPE;
    v_paymentStatus Payments.PaymentStatus%TYPE;
BEGIN
    SELECT ReservationID, PaymentAmount, PaymentDate, PaymentMethod, PaymentStatus
    INTO v_reservationID, v_paymentAmount, v_paymentDate, v_paymentMethod, v_paymentStatus
    FROM Payments
    WHERE PaymentID = p_paymentID;

    DBMS_OUTPUT.PUT_LINE('Payment Details:');
    DBMS_OUTPUT.PUT_LINE('ReservationID: ' || v_reservationID);
    DBMS_OUTPUT.PUT_LINE('Payment Amount: ' || v_paymentAmount);
    DBMS_OUTPUT.PUT_LINE('Payment Date: ' || v_paymentDate);
    DBMS_OUTPUT.PUT_LINE('Payment Method: ' || v_paymentMethod);
    DBMS_OUTPUT.PUT_LINE('Payment Status: ' || v_paymentStatus);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Payment not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Modify Payment Status

CREATE OR REPLACE PROCEDURE update_payment_status(
    p_paymentID IN NUMBER,
    p_new_status IN VARCHAR2
) IS
BEGIN
    UPDATE Payments
    SET PaymentStatus = p_new_status
    WHERE PaymentID = p_paymentID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Payment not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Payment status updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Remove Payment

CREATE OR REPLACE PROCEDURE delete_payment(
    p_paymentID IN NUMBER
) IS
BEGIN
    DELETE FROM Payments WHERE PaymentID = p_paymentID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Payment not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Payment deleted successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/