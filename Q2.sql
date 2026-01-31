SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Customber_Master (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Customber_Name NVARCHAR(50) NOT NULL,
    Phone_Number INT NOT NULL,
    City NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Product_Master (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Product_Name NVARCHAR(50) NOT NULL,
    Unit_Price FLOAT NOT NULL
)
GO

CREATE TABLE SalesPerson_Master (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SalesPerson_Name NVARCHAR(50) NOT NULL,
    Number INT NOT NULL,
    City NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Order_Detail (
    Order_Id INT IDENTITY(1,1) PRIMARY KEY,
    Customber_Id INT NOT NULL,
    SalesPerson_Id INT NOT NULL,
    Product_Id INT NOT NULL,
    Quantity INT NOT NULL,
    Total_Amount FLOAT NOT NULL,
    Purchase_Date DATE NOT NULL
)
GO

ALTER TABLE Order_Detail
ADD FOREIGN KEY (Customber_Id) REFERENCES Customber_Master(ID)
GO

ALTER TABLE Order_Detail
ADD FOREIGN KEY (Product_Id) REFERENCES Product_Master(Id)
GO

ALTER TABLE Order_Detail
ADD FOREIGN KEY (SalesPerson_Id) REFERENCES SalesPerson_Master(Id)
GO

INSERT INTO Customber_Master VALUES
('Rahul Sharma', 987654321, 'Delhi'),
('Priya Verma', 912345678, 'Mumbai'),
('Amit Singh', 998877665, 'Patna'),
('Neha Gupta', 934561278, 'Bangalore'),
('Rohit Kumar', 901234567, 'Kolkata')
GO

INSERT INTO Product_Master VALUES
('Laptop', 55000),
('Smartphone', 25000),
('Headphones', 1500),
('Keyboard', 1200),
('Mouse', 600)
GO

INSERT INTO SalesPerson_Master VALUES
('Suresh Yadav', 888888888, 'Delhi'),
('Anita Roy', 777777777, 'Mumbai'),
('Vikram Patel', 666666666, 'Ahmedabad'),
('Pooja Singh', 999999999, 'Patna')
GO

INSERT INTO Order_Detail VALUES
(1, 1, 1, 1, 55000, '2026-01-05'),
(2, 2, 2, 2, 50000, '2026-01-10'),
(3, 4, 3, 3, 4500,  '2026-01-15'),
(4, 3, 4, 1, 1200,  '2026-01-20'),
(5, 1, 5, 2, 1200,  '2026-01-25')
GO

SELECT * FROM Customber_Master
SELECT * FROM Product_Master
SELECT * FROM SalesPerson_Master
SELECT * FROM Order_Detail


--Q2)Third Highest Total Sales 

SELECT * FROM
    Order_Detail o 
Inner join Product_Master p 
    on p.Id=o.Product_Id 
order by 
    p.Unit_Price*o.Quantity desc
offset 2 rows fetch next 1 row only;

--Q3)Management wants to identify salespersons who generated high revenue

SELECT 
    s.Id AS SalesPerson_ID,
    s.SalesPerson_Name,
    SUM(p.Unit_Price * o.Quantity) AS TotalSales
FROM SalesPerson_Master s
INNER JOIN Order_Detail o 
    ON o.SalesPerson_Id = s.Id
INNER JOIN Product_Master p 
    ON o.Product_Id = p.Id
GROUP BY 
    s.Id,
    s.SalesPerson_Name
HAVING 
    SUM(p.Unit_Price * o.Quantity) < 60000;
--Q4)The company wants to find customers who spent more than the average customer spending.

SELECT 
    c.Customer_Name,
    SUM(p.Unit_Price * o.Quantity) AS TotalSpent
FROM Order_Detail o
INNER JOIN Customer_Master c 
    ON c.ID = o.Customer_Id
INNER JOIN Product_Master p 
    ON p.ID = o.Product_Id
GROUP BY 
    c.Customer_Name
HAVING 
    SUM(p.Unit_Price * o.Quantity) >
    (
        SELECT 
            AVG(CustomerTotal)
        FROM
        (
            SELECT 
                SUM(p2.Unit_Price * o2.Quantity) AS CustomerTotal
            FROM Order_Detail o2
            INNER JOIN Product_Master p2 
                ON p2.ID = o2.Product_Id
            GROUP BY o2.Customer_Id
        ) x
    );



--Q5)Operations team wants formatted and filtered data


SELECT 
    UPPER(c.Customber_Name) AS CustomerName,
    DATENAME(MONTH, o.Purchase_Date) AS OrderMonth,
    o.Order_ID,
    o.Purchase_Date
FROM Order_Detail o
INNER JOIN Customber_Master c 
    ON c.ID = o.Customber_Id
WHERE 
    o.Purchase_Date >= '2026-01-01'
    AND o.Purchase_Date < '2026-02-01';
