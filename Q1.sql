CREATE TABLE Customers(
CustomerID INT IDENTITY (1,1) Primary Key ,
CustomerName VARCHAR(100) NOT NULL,
PhoneNumber VARCHAR(15),
City VARCHAR(50),
CreatedDate DATE

);
CREATE TABLE Accounts
(
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountNumber VARCHAR(20),
    AccountType VARCHAR(20), -- Savings / Current
    OpeningBalance DECIMAL(12,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Transactions
(
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    TransactionType VARCHAR(10), -- Deposit / Withdraw
    Amount DECIMAL(12,2),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
CREATE TABLE Bonus
(
    BonusID INT PRIMARY KEY,
    AccountID INT,
    BonusMonth INT,
    BonusYear INT,
    BonusAmount DECIMAL(10,2),
    CreatedDate DATE,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
INSERT INTO Customers VALUES
('Ravi Kumar', '9876543210', 'Chennai', '2023-01-10'),
('Priya Sharma', '9123456789', 'Bangalore', '2023-03-15'),
('John Peter', '9988776655', 'Hyderabad', '2023-06-20');
INSERT INTO Accounts VALUES
(101, 1, 'SB1001', 'Savings', 20000),
(102, 2, 'SB1002', 'Savings', 15000),
(103, 3, 'SB1003', 'Savings', 30000);
INSERT INTO Transactions VALUES
(1, 101, '2024-01-05', 'Deposit', 30000),
(2, 101, '2024-01-18', 'Withdraw', 5000),
(3, 101, '2024-02-10', 'Deposit', 25000),

(4, 102, '2024-01-07', 'Deposit', 20000),
(5, 102, '2024-01-25', 'Deposit', 35000),
(6, 102, '2024-02-05', 'Withdraw', 10000),

(7, 103, '2024-01-10', 'Deposit', 15000),
(8, 103, '2024-01-20', 'Withdraw', 5000);

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

ALTER TABLE Bonus
ADD CONSTRAINT FK_Bonus_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);



--Question 1 – Stored Procedure (Date Range + Aggregation)
CREATE PROC QUESTION1
@StartDate Date,
@EndDate Date,
@AccountID INT
AS
BEGIN
SELECT 
	SUM(CASE
		WHEN TransactionType='Deposit'
		THEN Amount
		END)AS TotalAmountDeposited
		,
		SUM(CASE
		WHEN TransactionType='Withdraw'
		THEN Amount
		END) AS TotalAmountWithdrawn
	FROM Transactions
	Where AccountID=@AccountID
	AND TransactionDate BETWEEN @StartDate AND @EndDate;
END;


EXEC QUESTION1 '1-5-2024','10-5-2024',101

--Q2

CREATE PROCEDURE usp_MonthlyBonusUpdate
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Bonus (BonusID, AccountID, BonusMonth, BonusYear, BonusAmount, CreatedDate)
    SELECT 
        ROW_NUMBER() OVER (ORDER BY T.AccountID, YEAR(T.TransactionDate), MONTH(T.TransactionDate)) 
            + ISNULL((SELECT MAX(BonusID) FROM Bonus), 0) AS BonusID,

        T.AccountID,
        MONTH(T.TransactionDate) AS BonusMonth,
        YEAR(T.TransactionDate) AS BonusYear,
        1000 AS BonusAmount,
        GETDATE() AS CreatedDate
    FROM Transactions T
    WHERE T.TransactionType = 'Deposit'
    GROUP BY 
        T.AccountID,
        YEAR(T.TransactionDate),
        MONTH(T.TransactionDate)
    HAVING SUM(T.Amount) > 50000
    AND NOT EXISTS (
        SELECT 1
        FROM Bonus B
        WHERE B.AccountID = T.AccountID
          AND B.BonusMonth = MONTH(T.TransactionDate)
          AND B.BonusYear = YEAR(T.TransactionDate)
    );
END;

exec usp_MonthlyBonusUpdate

--Q3

SELECT 
    C.CustomerName,
    A.AccountNumber,

    A.OpeningBalance
    + SUM(CASE 
        WHEN T.TransactionType = 'Deposit' 
        THEN T.Amount 
    END)
    - SUM(CASE 
        WHEN T.TransactionType = 'Withdraw' 
        THEN T.Amount 
    END)
    + SUM(B.BonusAmount)
    AS CurrentBalance

FROM Customers C
JOIN Accounts A
    ON C.CustomerID = A.CustomerID

LEFT JOIN Transactions T
    ON A.AccountID = T.AccountID

LEFT JOIN Bonus B
    ON A.AccountID = B.AccountID

GROUP BY 
    C.CustomerName,
    A.AccountNumber,
    A.OpeningBalance;
