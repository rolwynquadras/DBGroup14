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