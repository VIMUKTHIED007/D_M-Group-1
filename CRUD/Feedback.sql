--Insert Feedback
CREATE OR REPLACE PROCEDURE add_feedback(
    p_feedbackID IN NUMBER,
    p_reservationID IN NUMBER,
    p_rating IN NUMBER,
    p_comments IN VARCHAR2,
    p_feedbackDate IN DATE
) IS
BEGIN
    INSERT INTO Feedback (FeedbackID, ReservationID, Rating, Comments, FeedbackDate)
    VALUES (p_feedbackID, p_reservationID, p_rating, p_comments, p_feedbackDate);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: FeedbackID already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--Retrieve Feedback Details

CREATE OR REPLACE PROCEDURE get_feedback(
    p_feedbackID IN NUMBER
) IS
    v_reservationID Feedback.ReservationID%TYPE;
    v_rating Feedback.Rating%TYPE;
    v_comments Feedback.Comments%TYPE;
    v_feedbackDate Feedback.FeedbackDate%TYPE;
BEGIN
    SELECT ReservationID, Rating, Comments, FeedbackDate
    INTO v_reservationID, v_rating, v_comments, v_feedbackDate
    FROM Feedback
    WHERE FeedbackID = p_feedbackID;

    DBMS_OUTPUT.PUT_LINE('Feedback Details:');
    DBMS_OUTPUT.PUT_LINE('ReservationID: ' || v_reservationID);
    DBMS_OUTPUT.PUT_LINE('Rating: ' || v_rating);
    DBMS_OUTPUT.PUT_LINE('Comments: ' || v_comments);
    DBMS_OUTPUT.PUT_LINE('Feedback Date: ' || v_feedbackDate);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Feedback not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--Modify Feedback Rating and Comments

CREATE OR REPLACE PROCEDURE update_feedback(
    p_feedbackID IN NUMBER,
    p_new_rating IN NUMBER,
    p_new_comments IN VARCHAR2
) IS
BEGIN
    UPDATE Feedback
    SET Rating = p_new_rating, Comments = p_new_comments
    WHERE FeedbackID = p_feedbackID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Feedback not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Feedback updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--Remove Feedback


CREATE OR REPLACE PROCEDURE delete_feedback(
    p_feedbackID IN NUMBER
) IS
BEGIN
    DELETE FROM Feedback WHERE FeedbackID = p_feedbackID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Feedback not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Feedback deleted successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/