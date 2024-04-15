
-- Stored Procedure to update Orders$ table

CREATE PROCEDURE Reset_orders$ AS

SELECT * INTO Temp FROM Orders$ 

TRUNCATE TABLE Orders$

INSERT INTO Orders$
SELECT [Row ID]
      ,[Order ID]
	  ,DATEADD(DAY, (SELECT DATEDIFF(DAY, MAX([Order Date]), GETDATE()) FROM Temp), [Order Date]) 'Order Date' 
      ,DATEADD(DAY, (SELECT DATEDIFF(DAY, MAX([Order Date]), GETDATE()) FROM Temp), [Ship Date]) 'Ship Date' 
      ,[Ship Mode]
      ,[Customer ID]
      ,[Customer Name]
      ,[Segment]
      ,[Country]
      ,[City]
      ,[State]
      ,[Postal Code]
      ,[Region]
      ,[Product ID]
      ,[Category]
      ,[Sub-Category]
      ,[Product Name]
      ,[Sales]
      ,[Quantity]
      ,[Discount]
      ,[Profit]
FROM Temp

DROP TABLE Temp

UPDATE Orders$
SET [Ship Date] = NULL
WHERE [Ship Date] > GETDATE()

SELECT * FROM Orders$
ORDER BY [Order Date] DESC
GO







-- Execute the stored procedure to update Orders table

EXEC Reset_orders$ 