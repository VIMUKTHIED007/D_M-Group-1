--Inventory Item

CREATE OR REPLACE PROCEDURE create_inventory (
  p_ItemID IN NUMBER,
  p_ItemName IN VARCHAR2,
  p_Quantity IN NUMBER,
  p_Category IN VARCHAR2,
  p_PricePerUnit IN NUMBER,
  p_SupplierName IN VARCHAR2
) AS
BEGIN
  INSERT INTO Inventory (ItemID, ItemName, Quantity, Category, PricePerUnit, SupplierName)
  VALUES (p_ItemID, p_ItemName, p_Quantity, p_Category, p_PricePerUnit, p_SupplierName);
  
  DBMS_OUTPUT.PUT_LINE('Item added successfully.');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Error: Item ID already exists.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
--Read Inventory Item

CREATE OR REPLACE PROCEDURE read_inventory (
  p_ItemID IN NUMBER
) AS
  v_ItemName Inventory.ItemName%TYPE;
  v_Quantity Inventory.Quantity%TYPE;
  v_Category Inventory.Category%TYPE;
  v_PricePerUnit Inventory.PricePerUnit%TYPE;
  v_SupplierName Inventory.SupplierName%TYPE;
BEGIN
  SELECT ItemName, Quantity, Category, PricePerUnit, SupplierName
  INTO v_ItemName, v_Quantity, v_Category, v_PricePerUnit, v_SupplierName
  FROM Inventory
  WHERE ItemID = p_ItemID;
  
  DBMS_OUTPUT.PUT_LINE('Item Name: ' || v_ItemName);
  DBMS_OUTPUT.PUT_LINE('Quantity: ' || v_Quantity);
  DBMS_OUTPUT.PUT_LINE('Category: ' || v_Category);
  DBMS_OUTPUT.PUT_LINE('Price Per Unit: ' || v_PricePerUnit);
  DBMS_OUTPUT.PUT_LINE('Supplier: ' || v_SupplierName);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error: No item found with ID ' || p_ItemID);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
--Update Inventory Item

CREATE OR REPLACE PROCEDURE update_inventory (
  p_ItemID IN NUMBER,
  p_Quantity IN NUMBER,
  p_PricePerUnit IN NUMBER
) AS
BEGIN
  UPDATE Inventory
  SET Quantity = p_Quantity, PricePerUnit = p_PricePerUnit
  WHERE ItemID = p_ItemID;
  
  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: No item found with ID ' || p_ItemID);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Item updated successfully.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
--Delete Inventory Item

CREATE OR REPLACE PROCEDURE delete_inventory (
  p_ItemID IN NUMBER
) AS
BEGIN
  DELETE FROM Inventory WHERE ItemID = p_ItemID;
  
  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: No item found with ID ' || p_ItemID);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Item deleted successfully.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
