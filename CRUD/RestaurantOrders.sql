--Create Restaurant Order

CREATE OR REPLACE PROCEDURE create_restaurant_order (
  p_OrderID IN NUMBER,
  p_ReservationID IN NUMBER,
  p_OrderDate IN DATE,
  p_TotalAmount IN NUMBER,
  p_OrderDetails IN VARCHAR2
) AS
BEGIN
  INSERT INTO RestaurantOrders (OrderID, ReservationID, OrderDate, TotalAmount, OrderDetails)
  VALUES (p_OrderID, p_ReservationID, p_OrderDate, p_TotalAmount, p_OrderDetails);
  
  DBMS_OUTPUT.PUT_LINE('Order added successfully.');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Error: Order ID already exists.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

--Read Restaurant Order

CREATE OR REPLACE PROCEDURE read_restaurant_order (
  p_OrderID IN NUMBER
) AS
  v_ReservationID RestaurantOrders.ReservationID%TYPE;
  v_OrderDate RestaurantOrders.OrderDate%TYPE;
  v_TotalAmount RestaurantOrders.TotalAmount%TYPE;
  v_OrderDetails RestaurantOrders.OrderDetails%TYPE;
BEGIN
  SELECT ReservationID, OrderDate, TotalAmount, OrderDetails
  INTO v_ReservationID, v_OrderDate, v_TotalAmount, v_OrderDetails
  FROM RestaurantOrders
  WHERE OrderID = p_OrderID;
  
  DBMS_OUTPUT.PUT_LINE('Reservation ID: ' || v_ReservationID);
  DBMS_OUTPUT.PUT_LINE('Order Date: ' || v_OrderDate);
  DBMS_OUTPUT.PUT_LINE('Total Amount: ' || v_TotalAmount);
  DBMS_OUTPUT.PUT_LINE('Order Details: ' || v_OrderDetails);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error: No order found with ID ' || p_OrderID);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

--Update Restaurant Order

CREATE OR REPLACE PROCEDURE update_restaurant_order (
  p_OrderID IN NUMBER,
  p_TotalAmount IN NUMBER,
  p_OrderDetails IN VARCHAR2
) AS
BEGIN
  UPDATE RestaurantOrders
  SET TotalAmount = p_TotalAmount, OrderDetails = p_OrderDetails
  WHERE OrderID = p_OrderID;
  
  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: No order found with ID ' || p_OrderID);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Order updated successfully.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

--Delete Restaurant Order

CREATE OR REPLACE PROCEDURE delete_restaurant_order (
  p_OrderID IN NUMBER
) AS
BEGIN
  DELETE FROM RestaurantOrders WHERE OrderID = p_OrderID;
  
  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: No order found with ID ' || p_OrderID);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Order deleted successfully.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
