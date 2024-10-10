--User Report

SELECT GuestID, FirstName, LastName, Contact, Email, Address
FROM Guest
ORDER BY LastName, FirstName;

--Reservation Report

SELECT 
    R.ReservationID,
    G.FirstName,
    G.LastName,
    R.CheckInDate,
    R.CheckOutDate,
    R.TotalPrice
FROM Reservation R
JOIN Guest G ON R.GuestID = G.GuestID
ORDER BY R.CheckInDate;

--Booking Report

SELECT 
    B.BillID,
    R.ReservationID,
    B.Amount,
    B.DateIssued,
    B.PaymentStatus
FROM Bill B
JOIN Reservation R ON B.ReservationID = R.ReservationID
ORDER BY B.DateIssued DESC;

--Inventory Report

SELECT ItemID, ItemName, Quantity, Category, PricePerUnit, SupplierName
FROM Inventory
ORDER BY ItemName;


--Restaurant Orders Report


SELECT 
    O.OrderID,
    R.ReservationID,
    O.OrderDate,
    O.TotalAmount,
    O.OrderDetails
FROM RestaurantOrders O
JOIN Reservation R ON O.ReservationID = R.ReservationID
ORDER BY O.OrderDate DESC;


--Maintenance Report


SELECT 
    M.MaintenanceID,
    R.RoomID,
    M.IssueDescription,
    M.RequestDate,
    M.Status,
    M.CompletionDate
FROM Maintenance M
JOIN Room R ON M.RoomID = R.RoomID
ORDER BY M.RequestDate DESC;


--Feedback Report


SELECT 
    F.FeedbackID,
    R.ReservationID,
    F.Rating,
    F.Comments,
    F.FeedbackDate
FROM Feedback F
JOIN Reservation R ON F.ReservationID = R.ReservationID
ORDER BY F.FeedbackDate DESC;


9. Payments Report

SELECT 
    P.PaymentID,
    P.ReservationID,
    P.PaymentAmount,
    P.PaymentDate,
    P.PaymentMethod,
    P.PaymentStatus
FROM Payments P
JOIN Reservation R ON P.ReservationID = R.ReservationID
ORDER BY P.PaymentDate DESC;