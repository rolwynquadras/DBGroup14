USE DBGroup14;

CREATE TABLE MemberAccount
(MemberAccountID INT PRIMARY KEY NOT NULL,
EmailID varchar(30),
FirstName varchar(30),
LastName varchar(30),
CompanyName varchar(30),
ContactNumber int,
Country varchar(30),
State varchar(30),
ZipCode smallint,
MemberType varchar(30),
SubscriptionID int REFERENCES Subscription(SubscriptionID)
)

CREATE TABLE Subscription
(SubscriptionID INT PRIMARY KEY NOT NULL,
PaymentID varchar(30) REFERENCES Payment(PaymentID),
SubscriptionStatus varchar(30),
SubscriptionExpirationDate date,
SubscriptionStartDate date
)