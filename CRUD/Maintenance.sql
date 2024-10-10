--Create Maintenance Request

CREATE OR REPLACE PROCEDURE create_maintenance (
  p_MaintenanceID IN NUMBER,
  p_RoomID IN NUMBER,
  p_IssueDescription IN VARCHAR2,
  p_RequestDate IN DATE,
  p_Status IN VARCHAR2,
  p_CompletionDate IN DATE
) AS
BEGIN
  INSERT INTO Maintenance (MaintenanceID, RoomID, IssueDescription, RequestDate, Status, CompletionDate)
  VALUES (p_MaintenanceID, p_RoomID, p_IssueDescription, p_RequestDate, p_Status, p_CompletionDate);
  
  DBMS_OUTPUT.PUT_LINE('Maintenance request added successfully.');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Error: Maintenance ID already exists.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
--Read Maintenance Request

CREATE OR REPLACE PROCEDURE read_maintenance (
  p_MaintenanceID IN NUMBER
) AS
  v_RoomID Maintenance.RoomID%TYPE;
  v_IssueDescription Maintenance.IssueDescription%TYPE;
  v_RequestDate Maintenance.RequestDate%TYPE;
  v_Status Maintenance.Status%TYPE;
  v_CompletionDate Maintenance.CompletionDate%TYPE;
BEGIN
  SELECT RoomID, IssueDescription, RequestDate, Status, CompletionDate
  INTO v_RoomID, v_IssueDescription, v_RequestDate, v_Status, v_CompletionDate
  FROM Maintenance
  WHERE MaintenanceID = p_MaintenanceID;
  
  DBMS_OUTPUT.PUT_LINE('Room ID: ' || v_RoomID);
  DBMS_OUTPUT.PUT_LINE('Issue Description: ' || v_IssueDescription);
  DBMS_OUTPUT.PUT_LINE('Request Date: ' || v_RequestDate);
  DBMS_OUTPUT.PUT_LINE('Status: ' || v_Status);
  DBMS_OUTPUT.PUT_LINE('Completion Date: ' || v_CompletionDate);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error: No maintenance request found with ID ' || p_MaintenanceID);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
--Update Maintenance Request

CREATE OR REPLACE PROCEDURE update_maintenance (
  p_MaintenanceID IN NUMBER,
  p_Status IN VARCHAR2
