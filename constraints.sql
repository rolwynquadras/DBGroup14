 USE DBGroup14;

GO 
CREATE FUNCTION availability_check
(@property int
)
	RETURNS bit
	AS
	BEGIN
	DECLARE @value bit;
	IF (@property = (SELECT p.PropertyID
					FROM dbo.Property p
					Where p.Availability = 'Booked'
						))
	SET @value = 'False'
	ELSE
	SET @value = 'True'
	RETURN @value
	END
GO

 ALTER TABLE Bookings
 ADD CONSTRAINT avail_check CHECK (dbo.availability_check(PropertyID) = 'True')
 GO

 CREATE FUNCTION member_check
 ( @member int)
 	RETURNS bit
	AS
	BEGIN
	DECLARE @value bit;
	IF (@member = (SELECT m.MemberAccountID
					FROM dbo.MemberAccount m
						))
	SET @value = 'True'
	ELSE
	SET @value = 'False'
	RETURN @value
	END
GO
  ALTER TABLE Bookings
 ADD CONSTRAINT memberid_check CHECK (dbo.member_check(MemberAccountID) = 'True')
 GO

CREATE FUNCTION dbo.getTotalAmount(@BookingID INT)
RETURNS money
BEGIN
   DECLARE @TotalAmount money = 0;
   DECLARE @PropertyPrice money = 0;
   DECLARE @ServicePrice money = 0;
	   SELECT @PropertyPrice = pt.Price, @ServicePrice = SUM(sv.ServicePrice)
		FROM Bookings bo
		JOIN Property pt
			ON bo.PropertyID = pt.PropertyID
		JOIN dbo.Services sv
			ON sv.PropertyID = pt.PropertyID
		GROUP BY pt.Price, pt.PropertyID, bo.BookingID
		HAVING bo.BookingID = @BookingID;
	SET @TotalAmount = @PropertyPrice + @ServicePrice + (@PropertyPrice + @ServicePrice) * 0.05;
   RETURN @TotalAmount;
END;
GO

DROP FUNCTION IF EXISTS dbo.getTotalAmount;

CREATE TRIGGER dbo.insert_total_amount
ON Payments
AFTER INSERT
AS
BEGIN
	DECLARE @TotalAmount money
	DECLARE @BookingID int
	SELECT @BookingID = BookingID FROM Bookings;
	SET @TotalAmount = dbo.getTotalAmount(@BookingID)
	UPDATE Payments
		SET TotalAmountWithTax = @TotalAmount
		WHERE BookingID = @BookingID;
END;
GO
drop trigger dbo.insert_total_amount