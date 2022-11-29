USE DBGroup14;

-- Master Key Encryption
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DmddGroup14';
-- Create Certificate
CREATE CERTIFICATE EncryptPassword
WITH SUBJECT = 'Encrypt Password';
-- Use symmetric key to encrpy the data
CREATE SYMMETRIC KEY Password_Key
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE EncryptPassword;
/* Open the symmetric key which will be used to encrypt the data. */
OPEN SYMMETRIC KEY Password_Key  
DECRYPTION BY CERTIFICATE EncryptPassword;
GO

/* INSERT in MemberAccount Table */
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1000, 'rolwyn@gmail.com', 'Rolwyn', 'Quadras', 'Hachiman Corp', 8572228888, 'USA', 'MA', 02119, 'Corporate');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1001, 'george@gmail.com', 'George', 'Abraham', 'Appletech', 8572228888, 'USA', 'California', 15417, 'Corporate');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1002, 'avinash@gmail.com', 'Avinash', 'Ayite', 'Walmart', 8572228888, 'USA', 'California', 15419, 'Corporate');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1003, 'john@gmail.com', 'John', 'Doe', null, 8572228888, 'USA', 'Washington', 20001, 'Individual');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1004, 'doe@gmail.com', 'Doe', 'John', null, 8572228888, 'USA', 'Washington', 20002, 'Individual');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1005, 'yash@gmail.com', 'Yash', 'Kadam', 'GoogleCore Corp', 8572228888, 'USA', 'MA', 02115, 'Corporate');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1006, 'sanyukta@gmail.com', 'Sanyukta', 'Kumbla', 'ABDF Pvt Ltd', 8572228888, 'USA', 'Florida', 32013, 'Corporate');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1007, 'aishwarya@gmail.com', 'Aishwarya', 'Kavitkar', 'TeddyFresh', 8572228888, 'USA', 'Alaska', 46120, 'Corporate');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1008, 'pranav@gmail.com', 'Pranav', 'Adhav', 'Spotify', 8572228888, 'USA', 'Ohio', 43027, 'Corporate');
INSERT INTO MemberAccount(MemberAccountID, EmailID, FirstName, LastName, CompanyName, ContactNumber, Country, State, ZipCode, MemberType)
	VALUES (1009, 'abhishek@gmail.com', 'Abhishek', 'Abhi', 'WeWork', 8572228888, 'USA', 'Virginia', 20103, 'Corporate');

select * from MemberAccount
delete from MemberAccount

/* INSERT in Login Table */
SET IDENTITY_INSERT Login OFF
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (100, 1000, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'Rolwyn@12345')), 'RolwynQ');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (101, 1001, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'a@12345')), 'george');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (102, 1002, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'b@12345')), 'avinash');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (103, 1003, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'c@12345')), 'john');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (104, 1004, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'d@12345')), 'doe');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (105, 1005, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'e@12345')), 'yash');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (106, 1006, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'f@12345')), 'sanyukta');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (107, 1007, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'g@12345')), 'aishwarya');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (108, 1008, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'h@12345')), 'pranav');
INSERT INTO Login(LoginID, MemberAccountID, Password, UserName)
	VALUES (109, 1009, EncryptByKey(Key_GUID('Password_Key'), CONVERT(varbinary,'i@12345')), 'abhishek');


INSERT INTO Employees(EmployeeID, FirstName, LastName, Gender, HireDate, EmailID, ContactNumber)
	VALUES (001, 'Rolwyn', 'Quadras', 'Male', '2022-11-28', 'rolwyn@gmail.com', 8457773333);
select * from Employees

INSERT INTO Location(LocationID, Country, State, City, ZipCode)
	VALUES (001, 'USA', 'MA', 'Boston', 02119);
select * from Location

INSERT INTO LandLord(LandLordID, FirstName, LastName, ContactNumber, EmailID)
	VALUES (001, 'Rolwyn', 'Quadras', 8673334454, 'rolwyn@gmail.com');
select * from LandLord

INSERT INTO Property(PropertyID, Price, LandLordID, Availability, LocationID, PropertyType)
	VALUES (111, 100, 001, 'Available', 001, 'Office');
INSERT INTO Property(PropertyID, Price, LandLordID, Availability, LocationID, PropertyType)
	VALUES (112, 200, 001, 'Available', 001, 'Office');
select * from Property

SET IDENTITY_INSERT Bookings ON
INSERT INTO Bookings(BookingID, MemberAccountID, PropertyID, StartDate, EndDate, NoOfDays, SpaceType, EmployeeID)
	VALUES (001, 1000, 111, '2022-11-28', '2022-11-30', 2, 'Office', 1);
INSERT INTO Bookings(BookingID, MemberAccountID, PropertyID, StartDate, EndDate, NoOfDays, SpaceType, EmployeeID)
	VALUES (002, 1001, 112, '2022-11-28', '2022-11-30', 2, 'Office', 1);
select * from Bookings

INSERT INTO Vendors(VendorID, LastName, FirstName, EmailID, ContactNumber, ServiceName)
	VALUES (111, 'Doe', 'John', 'joe@gmail.com', 8675554434, 'Vending Machine');
select * from Vendors
delete from Vendors

INSERT INTO Services(VendorID, PropertyID, ServicePrice, ServiceDate)
	VALUES (111, 111, 200, '2022-11-28');
INSERT INTO Services(VendorID, PropertyID, ServicePrice, ServiceDate)
	VALUES (111, 112, 500, '2022-11-29');
select * from Services
delete from Services

INSERT INTO Payments(PaymentID, PaymentHistory, PaymentMethod, PaymentPlan, BillingAddress, TotalAmount, BookingID)
	VALUES (2, 'History', 'Credit', 'one-time', '21 Highland', null, 2);
select * from Payments
delete from Payments

select * from Login
delete from Login
