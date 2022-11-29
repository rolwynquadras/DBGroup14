USE DBGroup14;

-- 1.Landlord Table
CREATE TABLE LandLord
	(LandLordID int PRIMARY KEY NOT NULL,
	FirstName varchar(100),
	LastName varchar(100),
	ContactNumber char(10),
	EmailID varchar(100)
	);

-- 2.Location Table
CREATE TABLE Location
	(LocationID int PRIMARY KEY NOT NULL,
	Country varchar(100),
	State varchar(100),
	City varchar(100),
	ZipCode smallint
	);

-- 3.Property Table
CREATE TABLE Property
	(PropertyID int PRIMARY KEY NOT NULL,
	Price money,
	LandLordID int REFERENCES LandLord(LandLordID),
	Availability varchar(30),
	LocationID int REFERENCES Location(LocationID),
	PropertyType varchar(50)
	);

-- 4.Vendors
CREATE TABLE Vendors
	(VendorID int PRIMARY KEY NOT NULL,
	LastName varchar(100),
	FirstName varchar(100),
	EmailID varchar(100),
	ContactNumber char(10),
	ServiceName varchar(100)
	);

-- 5.Services
CREATE TABLE Services
	(VendorID int REFERENCES Vendors(VendorID),
	PropertyID int REFERENCES Property(PropertyID),
	ServicePrice money,
	ServiceDate date,
	);

-- 6.Employees
CREATE TABLE Employees
	(EmployeeID int PRIMARY KEY NOT NULL,
	FirstName varchar(100),
	LastName varchar(100),
	Gender varchar(100),
	HireDate date,
	EmailID varchar(100),
	ContactNumber char(10),
	);

-- 7.MemberAccount Table
CREATE TABLE MemberAccount
	(MemberAccountID int PRIMARY KEY not null,
	EmailID varchar(100) unique not null,
	FirstName varchar(100),
	LastName varchar(100),
	CompanyName varchar(255),
	ContactNumber char(10),
	Country varchar(100),
	State varchar(100),
	ZipCode char(5),
	MemberType varchar(50)
	);

-- 8.Login Table
CREATE TABLE Login
	(LoginID int PRIMARY KEY IDENTITY(100, 1),
	MemberAccountID int REFERENCES MemberAccount(MemberAccountID) UNIQUE,
	Timestamp datetime DEFAULT GETDATE(),
	Password varbinary(255), --encrypt this
	UserName varchar(255) UNIQUE
	)

--alter table Login add constraint account_check check (MemberAccountID = (select MemberAccountID from Login))

-- 9.Booking
CREATE TABLE Bookings
	(BookingID int IDENTITY PRIMARY KEY NOT NULL,
	MemberAccountID int REFERENCES MemberAccount(MemberAccountID),
	PropertyID int REFERENCES Property(PropertyID),
	StartDate datetime,
	EndDate datetime,
	NoOfDays int, --computed value
	SpaceType varchar(100),
	EmployeeID int REFERENCES Employees(EmployeeID)
	);

-- 10.Payment
CREATE TABLE Payments
	(PaymentID int PRIMARY KEY NOT NULL,
	PaymentHistory varchar(255),
	PaymentMethod varchar(100),
	PaymentPlan varchar(100),
	BillingAddress varchar(255),
	TotalAmountWithTax money,
	BookingID int REFERENCES Bookings(BookingID),
	);

-- 11.Subscription
CREATE TABLE Subscription
	(SubscriptionID int PRIMARY KEY NOT NULL,
	PaymentID int REFERENCES Payments(PaymentID),
	SubscriptionStatus varchar(100),
	SubscriptionExpirationDate datetime,
	SubscriptionStartDate datetime
	);

-- 12.Customer Feedback
CREATE TABLE Feedback
	(FeedbackID int PRIMARY KEY NOT NULL,
	Rating smallint,
	Date datetime,
	Comment varchar(255),
	BookingID int REFERENCES Bookings(BookingID)
	);

-- 13.Renters Insurance
CREATE TABLE RentersInsurance
	(RentersInsuranceID int PRIMARY KEY NOT NULL,
	BookingID int REFERENCES Bookings(BookingID),
	InsuranceType varchar(100)
	);

-- 14.Legal Consultant
CREATE TABLE LegalConsultant
	(LegalConsultantID int PRIMARY KEY NOT NULL,
	FirstName varchar(100),
	LastName varchar(100),
	EmailID varchar(100),
	ContactNumber char(10)
	);

-- 15.Lease
CREATE TABLE Lease
	(LeaseID int PRIMARY KEY NOT NULL,
	LeaseStartDate datetime,
	LeaseEndDate datetime,
	BookingID int REFERENCES Bookings(BookingID),
	leaseDurationInYears float,
	LegalConsultantID int REFERENCES LegalConsultant(LegalConsultantID)
	);

	drop table Lease
	drop table LegalConsultant
	drop table RentersInsurance
	drop table Feedback
	drop table Subscription
	drop table Payments
	drop table Bookings
	drop table Login
	drop table MemberAccount
	drop table Employees
	drop table Services
	drop table Vendors
	drop table Property
	drop table Location
	drop table LandLord