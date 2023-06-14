EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
SET IDENTITY_INSERT Production.Product ON

--1. Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego. Procedura musi przyjmowaæ jako argument wejœciowy liczbê n.
--Generowanie ci¹gu Fibonacciego musi zostaæ zaimplementowane jako osobna funkcja,wywo³ywana przez procedurê.

CREATE FUNCTION dbo.Fibonacci(@num INT)
RETURNS @tab TABLE("Tablica wynikow" INT)
AS
BEGIN
	DECLARE  @n2 INT, @n1 INT, @n0 INT, @i INT;
	SET @n2=0;
	SET @n1=1;
	SET @n0=0;
	SET @i=1;
	IF (@num=0)
		INSERT INTO @tab VALUES(NULL);
	IF (@num>=1)
		WHILE (@num>=@i)
		BEGIN
			INSERT INTO @tab VALUES(@n0);
			SET @n2=@n0;
			SET @n0=@n1+@n0;
			SET @n1=@n2;
			SET @i+=1;
		END
RETURN
END;

SELECT * FROM Fibonacci(6);

CREATE PROC FibonacciProc @n INT
AS
DECLARE @i INT;
SET @i=0;
BEGIN
	WHILE(@i=0)
	BEGIN
		SELECT * FROM Fibonacci(@n);
		SET @i+=1;
	END;
END;

EXEC FibonacciProc 20;

--2. Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko tak, aby by³o napisane du¿ymi literami. 

CREATE TRIGGER trig_dml
	ON Person.Person
	AFTER INSERT
	AS
		BEGIN
			UPDATE Person.Person
			SET LastName = UPPER(LastName)
			WHERE Person.BusinessEntityID IN (SELECT BusinessEntityID FROM inserted);
		END

		
INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, LastName) VALUES(20785, 'IN', 'Emilia', 'Brandys')
SELECT * FROM Person.Person



--3. Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi zmiana wartoœci w polu 
--‘TaxRate’o wiêcej ni¿ 30%.

CREATE TRIGGER taxRateMonitoring
	ON Sales.SalesTaxRate
	INSTEAD OF UPDATE
	AS
	DECLARE @NewTaxR int, @TaxR int
	SELECT @NewTaxR = TaxRate FROM inserted
	SELECT @TaxR = TaxRate FROM deleted
		IF (@NewTaxR > 1.3*@TaxR)
			BEGIN
				PRINT ('TaxRate wiêksze ni¿ 30%')
			END
		ELSE
			BEGIN
				UPDATE Sales.SalesTaxRate
				SET TaxRate = (SELECT TaxRate FROM inserted)
				WHERE SalesTaxRateID = (SELECT SalesTaxRateID FROM inserted)
			END


	UPDATE Sales.SalesTaxRate
	SET TaxRate = 12
	WHERE SalesTaxRateID = 7;


	UPDATE Sales.SalesTaxRate
	SET TaxRate = 8
	WHERE SalesTaxRateID = 7;

	SELECT * FROM Sales.SalesTaxRate